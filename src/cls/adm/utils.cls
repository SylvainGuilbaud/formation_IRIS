Class adm.utils Extends %Persistent
{

/// Rebuild all the indexes for classes
/// parameters
///  namefilter: the filter for the name of classes ("startwith")
ClassMethod buildAllIndices(namefilter As %String)
{
	set filterlength=$length(namefilter)+1
	// ResultSets for walking down the classes
	set rsClass=##class(%ResultSet).%New("%Dictionary.CompiledClassQuery:Summary")
	quit:'rsClass.Execute()
	// Get each class
	while rsClass.Next() {
		// Ignore system or non persistent classes
		continue:rsClass.Get("System")
		continue:('rsClass.Get("Persistent"))
		set className=rsClass.Get("Name")
		continue:($find(className,namefilter)'=filterlength)
		// check if class exists and contains indices
		continue:'##class(%Dictionary.ClassDefinition).%ExistsId(className)
		continue:'(##class(%Dictionary.ClassDefinition).%OpenId(className).Indices.Count()>0)
		// re-populate the indices
		write $i(nb)_"-"_className
		set start=$zh
		do $zobjclassmethod(className,"%PurgeIndices")
		do $zobjclassmethod(className,"%BuildIndices")
		set duration=$zh-start
		write " - done "_duration_" seconds",!
	}
}

/// test if a class is a system class
ClassMethod tableNotSystem(name As %String) As %Boolean [ SqlName = table_Not_System, SqlProc ]
{
	if (##class(%Dictionary.ClassDefinition).%ExistsId(name)) && ('##class(%Dictionary.ClassDefinition).%OpenId(name).System) {
		quit 1
	}
	else {
		quit 0
	}
}

/// test if a class is a procedure (dont know source of this code)
ClassMethod isProcedure(procedureName As %String) As %Boolean [ SqlName = is_Procedure, SqlProc ]
{
	&sql(SELECT 1 into :procid FROM %Dictionary.MethodDefinition WHERE (NOT (parent %STARTSWITH '%')) 
	and (SqlName=:procedureName OR Name=:procedureName) and SqlProc=1)
	IF SQLCODE=0 Q procid
	&sql(SELECT 1 into :procid FROM %Dictionary.QueryDefinition WHERE (NOT (parent %STARTSWITH '%')) 
	and (SqlName=:procedureName OR Name=:procedureName) and SqlProc=1)
	IF SQLCODE=0 Q procid
	Quit 0
}

/// Count and display the number of lines in all table
/// who store data for classes whose name start with the filter classname
/// parameters
///  namefilter: the filter for the name of classes ("startwith")
ClassMethod count(namefilter As %String)
{
	set filterlength=$length(namefilter)+1
	set rsClass=##class(%ResultSet).%New("%Dictionary.CompiledClassQuery:Summary")
	quit:'rsClass.Execute()
	// Get each class
	while rsClass.Next() {
		// Ignore system classes
		set className=rsClass.Get("Name")
		continue:rsClass.Get("System")
		continue:('rsClass.Get("Persistent"))
		continue:($find(className,namefilter)'=filterlength)
		set tablesize = ..objTableSize(className)
		write !," Table " _ fultablename _ " size: " _ tablesize
	}
}

/// Return the number of lines in a table
/// parameter: the object name
ClassMethod objTableSize(objectName As %String)
{
	set class=##class(%Dictionary.CompiledClass).%OpenId(objectName)
	set fulltablename = class.SqlSchemaName _"."_ class.SqlTableName
	quit ..tableSize(fulltablename)
}

/// Return the number of lines in a table
/// parameter: the fully qualified name of the table
ClassMethod tableSize(tableName As %String)
{
	set result=##class(%ResultSet).%New()
	set sqltext="select count(*) nb from "_tableName
	do result.Prepare(sqltext)
	do result.Execute()
	set nblines = 0
	while result.Next() {
		set nblines = result.Data("nb")
		//write !,"---"_tablename_": "_nblines	
		continue
	}
	quit nblines
}

/// Optimization of indexes for classes
/// parameters
///  namefilter: the filter for the name of classes ("startwith")
/// 1- tunetable (to know selectivity)
/// 2- for each index call function setIndexType(numrows, selectivity)
ClassMethod optimIndexes(namefilter As %String, tuntb As %Boolean = 0, forceRebuild As %Boolean = 0, display As %Boolean = 0)
{
	set filterlength=$length(namefilter)+1
	// ResultSets for the classe list
	set rsClass=##class(%ResultSet).%New("%Dictionary.CompiledClassQuery:Summary")
	quit:'rsClass.Execute()
	while rsClass.Next() {
		// select the class on which to do optimization
		set className=rsClass.Get("Name")
		continue:rsClass.Get("System")
		continue:('rsClass.Get("Persistent"))
		continue:($find(className,namefilter)'=filterlength)
		set cplclass=##class(%Dictionary.CompiledClass).%OpenId(className)
		set defclass=##class(%Dictionary.ClassDefinition).%OpenId(className)
		set defstorage=##class(%Dictionary.StorageDefinition).%OpenId(defclass.Storages.GetAt(1).%Id())
		write !,"Optimization analysis for classname: " _ className

		// get & rebuild table infos
		set fulltablename = cplclass.SqlSchemaName _"."_ cplclass.SqlTableName
		do:tuntb $SYSTEM.SQL.TuneTable(fulltablename,1,display)
		set tblSize = ..objTableSize(className)
		set compileFlag=forceRebuild

		// loop on existing indices
		for idxid=1:1:defclass.Indices.Count(){
			// select the index on which there is optimisation
			set indexObj=defclass.Indices.GetAt(idxid)
			continue:indexObj.PrimaryKey
			set colname=indexObj.Properties
			continue:($length(colname,",")'=1) // no work on composite index
			
			// find storage for colname
			set storcol=0
			for strid=1:1:defstorage.Properties.Count() {
				set astorcol=defstorage.Properties.GetAt(strid)
				set:(astorcol.Name=colname) storcol=astorcol
			}
			continue:(storcol=0)
			set colselec = storcol.Selectivity
			// we now have selectivity and num of columns in table
			set idxType=..findIDXType(tblSize, colselec)
			if idxType'=indexObj.Type {
				write !,"  index change (" _ indexObj.Name _ ")["_colselec
				write "/"_ tblSize _ "]:" _ indexObj.Type _ "->"_idxType
				set indexObj.Type=idxType
				do indexObj.%Save()
				set compileFlag=1
			}
		}
		if compileFlag=1 {
			do $system.OBJ.Compile(className,"cko3-d")		
			do $zobjclassmethod(className,"%PurgeIndices")
			do $zobjclassmethod(className,"%BuildIndices")
			do $SYSTEM.SQL.TuneTable(fulltablename,1,0)
		}
	}
	do rsClass.Close()
	kill rsClass
	quit
}

/// choose index type depending on selectivity
/// linear per segment
/// EG: for a table of 1000 lines, bitmap if selectivity>2%
/// and for a table of 10000 lines, bitmap if selectivity>.5%
ClassMethod findIDXType(tblSize As %Integer, colselec As %String)
{

	if colselec=1 {
		quit "index"
	}
	if tblSize<10{
		quit "index"
	}
	if tblSize<100{
		// from 33% to 10%
		set minsel = 33 - (tblSize - 10)/4
		if colselec > minsel {
			quit "bitmap"
		}
		quit "index"
	}
	if tblSize<1000{
		// from 10% to 2%
		set minsel = 10 - (tblSize - 100)/112.5
		if colselec > minsel {
			quit "bitmap"
		}
		quit "index"
	}
	if tblSize<10000{
		// from 2% to 0.5%
		set minsel = 2 - (tblSize - 1000)/6000
		if colselec > minsel {
			quit "bitmap"
		}
		quit "index"
	}
	if tblSize<100000{
		// from 0.5% to 0.1%
		set minsel = .5 - (tblSize - 10000)/225000
		if colselec > minsel {
			quit "bitmap"
		}
		quit "index"
	}
	if colselec > 0.1 {
			quit "bitmap"
		}
		quit "index"
}

ClassMethod createAllIndices(namefilter As %String, selectivity As %Integer) As %Status
{
	
	set filterlength=$length(namefilter)
	// ResultSets for walking down the classes and indexes
	set rsClass=##class(%ResultSet).%New("%Dictionary.CompiledClassQuery:Summary")
	set rsIndex=##class(%ResultSet).%New("%Dictionary.CompiledIndexQuery:Summary")
	
	quit:'rsClass.Execute()

		// Get each class
		while rsClass.Next() {
			// Ignore system classes
			// only for classes matching filter name
			if ('rsClass.Get("System"))&&(rsClass.Get("Persistent"))&&($extract(rsClass.Get("Name"),1,filterlength)=namefilter) {
				set className=rsClass.Get("Name")
				write className,!
				set classObj=##class(%Dictionary.ClassDefinition).%OpenId(className)
				set storageObj=##class(%Dictionary.StorageDefinition).%OpenId(classObj.Storages.GetAt(1).%Id())
				for i=1:1:storageObj.Properties.Count() {
					write !, "   property: " _ storageObj.Properties.GetAt(i).Name
					write " select " _storageObj.Properties.GetAt(i).Selectivity
					
					if (storageObj.ExtentSize>$Piece(storageObj.Properties.GetAt(i).Selectivity,".")) && ($Piece(storageObj.Properties.GetAt(i).Selectivity,".")>=selectivity) && ($Piece(storageObj.Properties.GetAt(i).Selectivity,".")<100) {
						if (##class(%Dictionary.PropertyDefinition).%ExistsId(classObj.Name_"||"_storageObj.Properties.GetAt(i).Name))&&(##class(%Dictionary.PropertyDefinition).%OpenId(classObj.Name_"||"_storageObj.Properties.GetAt(i).Name).Collection="") {
							// Type=bitmap
							set indexPropertyName=storageObj.Properties.GetAt(i).Name
							&sql(select Name,Properties into :indexName,:properties
								   from %Dictionary.IndexDefinition
								  where Properties = :indexPropertyName
								    and Parent->Name = :classObj.Name
								)
							if SQLCODE=100 {	
								set indexObj=##class(%Dictionary.IndexDefinition).%New()
								set indexObj.Name=indexPropertyName_"Index"
								set indexObj.parent=classObj
								set indexObj.Type="bitmap"
								set indexObj.Properties=indexPropertyName
								set sc=indexObj.%Save()
								write !,">>> index created:"_indexObj.Name_" "_sc,!
								set ^CEGEDIM(classObj.Name,$i(^CEGEDIM(classObj.Name)))=$LB(indexObj.Name,indexObj.Type,indexObj.Properties,storageObj.ExtentSize,storageObj.Properties.GetAt(i).Selectivity,$zdt($h,3))	
							}
							else {
								write !,"index "_indexName_" already exists",!
							}
						}
					} elseif (storageObj.Properties.GetAt(i).Name'["%")&&($Piece(storageObj.Properties.GetAt(i).Selectivity,".")<100) {
						if (##class(%Dictionary.PropertyDefinition).%ExistsId(classObj.Name_"||"_storageObj.Properties.GetAt(i).Name))&&(##class(%Dictionary.PropertyDefinition).%OpenId(classObj.Name_"||"_storageObj.Properties.GetAt(i).Name).Collection="") {
							// Type=index
							set indexPropertyName=storageObj.Properties.GetAt(i).Name
							&sql(select Name,Properties into :indexName,:properties
								   from %Dictionary.IndexDefinition
								  where Properties = :indexPropertyName
								    and Parent->Name = :classObj.Name
								)
							if SQLCODE=100 {	
								set indexObj=##class(%Dictionary.IndexDefinition).%New()
								set indexObj.Name=indexPropertyName_"Index"
								set indexObj.parent=classObj
								set indexObj.Type="index"
								set indexObj.Properties=indexPropertyName
								set sc=indexObj.%Save()
								write !,">>> index created:"_indexObj.Name_" "_sc,!
								set ^CEGEDIM(classObj.Name,$i(^CEGEDIM(classObj.Name)))=$LB(indexObj.Name,indexObj.Type,indexObj.Properties,storageObj.ExtentSize,storageObj.Properties.GetAt(i).Selectivity,$zdt($h,3))	
							}
							else {
								write !,"index "_indexName_" already exists",!
							}
						}
					}
				}
				do $system.OBJ.Compile(className,"cko3-d")		
				// Now re-populate the indices
				do $zobjclassmethod(className,"%PurgeIndices")
				do $zobjclassmethod(className,"%BuildIndices")
				write !
				
			}
		}
		quit $$$OK
}

ClassMethod addBitmapIndices(namefilter As %String, selectivity As %Integer) As %Status
{
	set filterlength=$length(namefilter)
	// ResultSets for walking down the classes and indexes
	set rsClass=##class(%ResultSet).%New("%Dictionary.CompiledClassQuery:Summary")
	set rsIndex=##class(%ResultSet).%New("%Dictionary.CompiledIndexQuery:Summary")
	
	quit:'rsClass.Execute()

		// Get each class
		while rsClass.Next() {
			// Ignore system classes
			// only for classes matching filter name
			if ('rsClass.Get("System"))&&(rsClass.Get("Persistent"))&&($extract(rsClass.Get("Name"),1,filterlength)=namefilter) {
				set className=rsClass.Get("Name")
				write className,!
				set classObj=##class(%Dictionary.ClassDefinition).%OpenId(className)
				set storageObj=##class(%Dictionary.StorageDefinition).%OpenId(classObj.Storages.GetAt(1).%Id())
				for i=1:1:storageObj.Properties.Count() {
					write !, "   property: " _ storageObj.Properties.GetAt(i).Name
					write " select " _storageObj.Properties.GetAt(i).Selectivity
					
					if (storageObj.ExtentSize>$Piece(storageObj.Properties.GetAt(i).Selectivity,".")) && ($Piece(storageObj.Properties.GetAt(i).Selectivity,".")>selectivity) && ($Piece(storageObj.Properties.GetAt(i).Selectivity,".")<100) {
						set indexPropertyName=storageObj.Properties.GetAt(i).Name
						&sql(select Name,Properties into :indexName,:properties
							   from %Dictionary.IndexDefinition
							  where Properties = :indexPropertyName
							    and Parent->Name = :classObj.Name
							)
						if SQLCODE=100 {	
							set indexObj=##class(%Dictionary.IndexDefinition).%New()
							set indexObj.Name=indexPropertyName_"Index"
							set indexObj.parent=classObj
							set indexObj.Type="bitmap"
							set indexObj.Properties=indexPropertyName
							set sc=indexObj.%Save()
							write !,">>> index created:"_indexObj.Name_" "_sc,!
							set ^CEGEDIM("index added",classObj.Name,$i(^CEGEDIM("index added",classObj.Name)))=$LB(indexObj.Name,indexObj.Properties,storageObj.ExtentSize,storageObj.Properties.GetAt(i).Selectivity)	
						}
						else {
							write !,"index "_indexName_" already exists",!
						}
					}
				}
				do $system.OBJ.Compile(className,"cko3-d")		
				// Now re-populate the indices
				do $zobjclassmethod(className,"%PurgeIndices")
				do $zobjclassmethod(className,"%BuildIndices")
				write !
				
			}
		}
		quit $$$OK
}

/// check if there are non unique and non IdKey indices to convert in bitmap
ClassMethod countIndices()
{
	// ResultSets for walking down the classes
	set rsClass=##class(%ResultSet).%New("%Dictionary.CompiledClassQuery:Summary")
	
	quit:'rsClass.Execute()
		// Get each class
		while rsClass.Next() {
			// Ignore system classes
			if ('rsClass.Get("System"))&&(rsClass.Get("Persistent"))&&($extract(rsClass.Get("Name"),1,4)="dbo.")&&($extract(rsClass.Get("Name"),1,8)'="dbo.Temp") {
				set className=rsClass.Get("Name")
				set classObj=##class(%Dictionary.ClassDefinition).%OpenId(className)
				if classObj.Indices.Count() > 1 {
					for index=1:1:classObj.Indices.Count() {
						set indexObj=##class(%Dictionary.IndexDefinition).%OpenId(classObj.Indices.GetAt(index).%Id())
						if ('indexObj.IdKey) && ('indexObj.Unique) {
							write $i(i)_"-"_classObj.Name_" "_classObj.Indices.Count()_" indices"
							write ">>>"_indexObj.Name_":"_indexObj.Properties,!
							
						}
					}
				}
			}
		}
}

Storage Default
{
<Data name="utilsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<DataLocation>^adm.utilsD</DataLocation>
<DefaultData>utilsDefaultData</DefaultData>
<ExtentSize>100000</ExtentSize>
<IdLocation>^adm.utilsD</IdLocation>
<IndexLocation>^adm.utilsI</IndexLocation>
<StreamLocation>^adm.utilsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
