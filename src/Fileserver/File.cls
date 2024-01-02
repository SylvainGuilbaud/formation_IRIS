Include %occErrors

/// Represents one file served on fileserver.
Class Fileserver.File Extends %Persistent [ ClassType = persistent ]
{

/// Name of the file (without path, but with extension).
Property Name As %String;

/// Path of the file.
Property Directory As %String;

/// Extension of the file.
Property Extension As %String;

/// Size of the file in bytes.
Property Size As %BigInt;

/// Date of creation of the file in <i>YYYY-MM-DD hh:mm:ss</i> format.
Property DateCreated As %TimeStamp;

/// Date of modification of the file in <i>YYYY-MM-DD hh:mm:ss</i> format.
Property DateModified As %TimeStamp;

/// All downloads of the file
Relationship Downloads As Fileserver.Download [ Cardinality = many, Inverse = File ];

Index DirName On (Directory, Name) [ Unique ];

ClassMethod Init(dir As %String = "") As %Status
{
	if dir="" set dir=##class(%SYS.System).TempDirectory()
	set ^Settings("user_files_dir")=dir
	write !
	zwrite ^Settings("user_files_dir")
	set list("/csp/fileserver/files.csp")=""
	do $system.OBJ.CompileList(.list)
	new $namespace
	set $namespace="%SYS"
	set Status=##Class(Config.Startup).Get(.Properties)
	set Url="http://"_$zu(110)_":52773/fileserver/files"
	if Status set Url="http://"_$zu(110)_":"_$g(Properties("WebServerPort"),52773)_"/fileserver/files" 
	write !,Url
	quit $$$OK
}

// do ##class(Fileserver.File).AddDir("D:\Pictures\Desktop")

/// Add files from directory <b>dir</b> to fileserver.<br>
/// <b>rec</b> - recursive: 1 - to add subfolders, 0 - so skip them.
ClassMethod AddDir(dir As %String, rec As %Boolean = 0) As %Status
{
	set st=$$$OK
	if ##class(%File).DirectoryExists(dir)
	{
		// Build resultset of all files and subfolders in a directory
		set rs=##Class(%ResultSet).%New("%File.FileSet")
 		do rs.Execute(dir,"*",,1) // build result set of all files in dir
 		while rs.Next() {
			if rs.Get("Type")'="D" //check for directories
			{
				set file=..%New()
				set file.Name=rs.Get("ItemName")
				set file.Directory=##class(%File).GetDirectory(rs.Get("Name"))
				set file.Extension=$p(file.Name,".",*)
				set file.Size=rs.Get("Size")
				set file.DateCreated=rs.Get("DateCreated")				
				set file.DateModified=rs.Get("DateModified")
				do file.%Save()
			} else {
				if (rec=1) {
					do ..AddDir(rs.Get("Name"),1)
				}
			} 
		}
	} else {
		set st = $$$ERROR($$$DirectoryNotExist,dir)
	}
	quit st
}

/// Add file to fileserver.<br>
/// <b>file</b> - full filename with path.
ClassMethod AddFile(filename As %String) As %Status
{
	set st=$$$OK
	if ##class(%File).Exists(filename)
	{
		try {
			set file=..%New()
			set file.Name=##class(%File).GetFilename(filename)
			set file.Directory=##class(%File).GetDirectory(filename)
			set file.Extension=$p(file.Name,".",*)
			set file.Size=##class(%File).GetFileSize(filename)
			set file.DateCreated=$ZDATETIME(##class(%File).GetFileDateCreated(filename),3)	
			set file.DateModified=$ZDATETIME(##class(%File).GetFileDateModified(filename),3)
			do file.%Save()
		} catch ex {		
			set st=ex.AsStatus()
		}
	} else {
		set st = $$$ERROR($$$FileDoesNotExist, filename)	
	}
	quit st
}

/// Delete files from directory <b>dir</b> to fileserver.<br>
/// <b>rec</b> - recursive: 1 - to delete subfolders, 0 - so skip them.
ClassMethod DelDir(dir As %String, rec As %Boolean = 0) As %Status
{
	set st=$$$OK
	set dir=##class(%File).NormalizeDirectory(dir)
	if (rec=0) {
		&SQL(DELETE FROM Fileserver."File" WHERE Directory=:dir)
		if (SQLCODE'=0) {
			set st = $System.Status.Error($$$SQLError, SQLCODE, dir)
		}
	} else {
		&SQL(DELETE FROM Fileserver."File" WHERE Directory %STARTSWITH :dir)
		if (SQLCODE'=0) {
			set st = $System.Status.Error($$$SQLError, SQLCODE, dir)
		}
	}
	quit st
}

/// Delete file from fileserver.<br>
/// <b>fileid</b> - id of <class>Fileserver.File</class>.
ClassMethod DelFileById(fileid As %String) As %Status
{
	set st=$$$OK
	&SQL(DELETE FROM Fileserver."File" WHERE ID=:fileid)
	if (SQLCODE'=0) {
		set st = $System.Status.Error($$$SQLError, SQLCODE, fileid)
	}
	quit st
}

/// Delete file from fileserver.<br>
/// <b>fileid</b> - id of <class>Fileserver.File</class>.
ClassMethod DelFile(filedir As %String, filename As %String) As %Status
{
	set st=$$$OK
	&SQL(DELETE FROM Fileserver."File" WHERE Directory=:filedir and Name=:filename)
	if (SQLCODE'=0) {
		set st = $System.Status.Error($$$SQLError, SQLCODE, filedir_filename)
	}
	quit st
}

/// Update files from directory <b>dir</b> on fileserver.<br>
/// <b>rec</b> - recursive: 1 - to update subfolders, 0 - so skip them.
ClassMethod UpdDir(dir As %String, rec As %Boolean = 1) As %Status
{
	set st=$$$OK
	
	try {
		set dir=##class(%File).NormalizeDirectory(dir)
		if ##class(%File).DirectoryExists(dir)
		{ 		
			set rs=##Class(%ResultSet).%New("%File.FileSet")
 			do rs.Execute(dir,"*",,1) // build result set of all files in dir
 			while rs.Next() {
				if rs.Get("Type")'="D" //check for directories
				{
					set $list(dirfiles,*+1)=rs.Get("ItemName") // Build list of files in the folder
				} else {
					if (rec=1) {
						do ..UpdDir(rs.Get("Name"),1)
					}
				}
			}
		
			// Build list of files in the database
 			set sql = "SELECT Name FROM Fileserver.""File"" WHERE Directory=?"
  			set tStatement = ##class(%SQL.Statement).%New()	
			set st = tStatement.%Prepare(sql)
   			set rset = tStatement.%Execute(dir)
   			while rset.%Next() {
	   			set $list(basefiles,*+1)=rset.%Get("Name")
     		}
     	
     		// Find differense between lists of files in database and directory
			do ..DiffList(basefiles,dirfiles,.added,.deleted)
		
			set ptr=0,count=0
   			while $LISTNEXT(added,ptr,value) 
   			{
    			set count=count+1
   				do ..AddFile(dir_value)
   			}
   			
   			set ptr=0,count=0
   			while $LISTNEXT(deleted,ptr,value) 
   			{
    			set count=count+1
   				do ..DelFile(dir,value)
   			}
		} else {
			set st = $$$ERROR($$$DirectoryNotExist,dir)
		} 
	} catch ex {
		set st=ex.AsStatus()
	}
	quit st
}

/// Finds diff between two lists.<br>
/// <b>old</b> - original list.<br>
/// <b>new</b> - modified list.<br>
/// <b>.added</b> - list with all added elements (present in new list, absent in old list.<br>
/// <b>.deleted</b> - list with all deleted elements (present in old list, absent in new list.<br>
ClassMethod DiffList(old As %List, new As %List, Output added As %List, Output deleted As %List) As %Status [ Internal ]
{
	set st=$$$OK
	if ($LISTVALID(old)=0) quit $$$ERROR($$$AttributeValueMustBeList,"old")
	if ($LISTVALID(new)=0) quit $$$ERROR($$$AttributeValueMustBeList,"new")
    try {
    	for i=1:1:$LISTLENGTH(old) 
    	{
    		set match=$LISTFIND(new,$LIST(old,i))
    		if match'=0
    		{
	    		set $LIST(old,i)=""
	    		set $LIST(new,match)=""
    		}
    	}
    	set added=new
    	set deleted=old
    } catch ex {
	    set st=ex.AsStatus()
    }
    quit st
}

ClassMethod ItsAllTheSameShit() [ Internal, Private ]
{
	#dim st As %Status = $$$OK
	set st=$$$OK
	set st=1
}

Storage Default
{
<Data name="FileDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Extension</Value>
</Value>
<Value name="3">
<Value>Size</Value>
</Value>
<Value name="4">
<Value>DateCreated</Value>
</Value>
<Value name="5">
<Value>DateModified</Value>
</Value>
<Value name="6">
<Value>Name</Value>
</Value>
<Value name="7">
<Value>Directory</Value>
</Value>
</Data>
<DataLocation>^Fileserver.FileD</DataLocation>
<DefaultData>FileDefaultData</DefaultData>
<ExtentSize>100000</ExtentSize>
<IdLocation>^Fileserver.FileD</IdLocation>
<IndexLocation>^Fileserver.FileI</IndexLocation>
<StreamLocation>^Fileserver.FileS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
