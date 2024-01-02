Include %occErrors

Class Fileserver.JSON Extends %Base
{

/// Converts SQL query result to JSON.
ClassMethod FileListToJSON() As %Status
{
		set st=$$$OK
		try{
			do ##class(%ZEN.Auxiliary.jsonSQLProvider).%WriteJSONFromSQL(,"SELECT ID, Name, Size, Extension FROM Fileserver.File")
		} catch ex{
			set st=ex.AsStatus()
		}
    	quit st
}

ClassMethod CheckPermission(FileID As %Integer) As %Boolean
{
	quit 1
}

/// Custom user actions to get access to file.
ClassMethod RequestFile(FileID As %Integer) As %Status
{
	set FileID=$ZSTRIP(FileID,"*E'N")
	if (..CheckPermission(FileID))
	{
		set DownloadId=..GenerateDownload(FileID)
		set DownloadLink="/fileserver/download/"_DownloadId
		&html<
		<html>
		<body style="text-align: center;">
		<button onclick="history.back()">Go Back</button>
			<h2>Your download is ready</h2>
			<h3>Active only for your IP for the next 24 hours</h3>
			<a href="#(DownloadLink)#">Click to start your download</a>
		</body>
		</html>			
		>
	}
	quit $$$OK
}

/// Create Fileserver.Download object.
ClassMethod GenerateDownload(FileID As %Integer) As %String
{
	set download=##class(Fileserver.Download).%New()
	set download.DateCreated=$ZDATETIME($NOW(),3)
	set download.DateActiveUntil=$ZDATETIME(($PIECE($NOW(),",",1)+1)_","_$PIECE($NOW(),",",2),3) // Active for 24 hours
	set download.IP=%request.GetCgiEnv("REMOTE_ADDR")
	set download.File=##class(Fileserver.File).%OpenId(FileID)
	do download.DownloadIDGenerate()
	set DownloadID = download.DownloadID
	do download.%Save()
	kill download
	quit DownloadID
}

/// Check if user has a correct Fileserver.Download object, serve him his file.
ClassMethod DownloadFile(DownloadId As %String) As %Status
{
	try {
		&SQL(SELECT "File"->"Name","File"->"Directory","File"->"Size","IP","DownloadCount","DateActiveUntil" INTO :fname, :fdir, :fsize, :ip,:dcount,:dateactive FROM Fileserver.Download WHERE DownloadID=:DownloadId)
		if (SQLCODE=0)
		{
			if ((ip=%request.GetCgiEnv("REMOTE_ADDR")) && ($ZDATETIMEH(dateactive,3,1)>$HOROLOG))
			{
				//w $ZDATETIMEH(dateactive,3,1)," ",$HOROLOG
				set dcount=dcount+1
				&SQL(UPDATE Fileserver.Download SET "DownloadCount"=:dcount WHERE DownloadID=:DownloadId)
				//set %response.ContentLength=fsize
				set %response.ContentType="application/octet-stream"
				
				do %response.SetHeader("Content-Disposition","attachment; filename="""_fname_"""")
				set stream=##class(%FileBinaryStream).%New()
				set stream.Filename=fdir_fname
				while 'stream.AtEnd {
				set line=stream.Read()
					write line
				}
			}
			else {
				set st=$System.Status.Error($$$GeneralError,"Download time limit exceeded, or another IP")
			}
		} else {
			set st = $System.Status.Error($$$SQLError, SQLCODE, "DownloadID not found")
		}
	}catch ex {
		set st=$$$ADDSC($System.Status.Error($$$GeneralError,ex.AsSystemError()), st)
	}
	quit st
}

/// Check if user has a correct Fileserver.Download object, serve him his file.
ClassMethod UploadFile() As %Status
{
	#dim st As %Status = $$$OK
	try {	
 		set Location=$g(^Settings("user_files_dir"),"C:\UserFiles\")
		set Stream =%request.GetMimeData("fotofile0",1)
		set Name=$p(Stream.FileName,".",0,*-1)
		set Extension=$p(Stream.FileName,".",*)
		set FileName=Location_Name_"."_Extension

		set counter = 1
		while ##class(%File).Exists(FileName) 
		{
			set FileName=Location_Name_"_("_counter_")."_Extension
			set counter=counter+1
		}
		set file=##class(%Stream.FileBinary).%New()
		set file.Filename=FileName
		do file.CopyFromAndSave(Stream)
		
		do ##class(Fileserver.File).AddFile(FileName)
		
		kill file
	}catch ex {
		set st=$$$ADDSC($System.Status.Error($$$GeneralError,ex.AsSystemError()), st)
	}
	quit st
}

}
