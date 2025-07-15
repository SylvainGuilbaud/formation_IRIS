Class adm.utils Extends %Persistent
{

ClassMethod buildAllIndices()
{
	// ResultSets for walking down the classes
	set rsClass=##class(%ResultSet).%New("%Dictionary.CompiledClassQuery:Summary")
	if rsClass.Execute() {
		// Get each class
		while rsClass.Next() {
			// Ignore system classes
			if ('rsClass.Get("System"))&&(rsClass.Get("Persistent")) {
				set className=rsClass.Get("Name")
				// check if class exists and contains indices
				if (##class(%Dictionary.ClassDefinition).%ExistsId(className)) && (##class(%Dictionary.ClassDefinition).%OpenId(className).Indices.Count()>0) {
					write $i(nb)_"-"_className
					// re-populate the indices
					set start=$zh
					do $zobjclassmethod(className,"%PurgeIndices")
					do $zobjclassmethod(className,"%BuildIndices")
					set duration=$zh-start
					write " - done "_duration_" seconds",!
				}
			}
		}
	}	
	quit
}

ClassMethod tableNotSystem(name As %String) As %Boolean [ SqlName = table_Not_System, SqlProc ]
{
	if (##class(%Dictionary.ClassDefinition).%ExistsId(name)) && ('##class(%Dictionary.ClassDefinition).%OpenId(name).System) {
		quit 1
	}
	else {
		quit 0
	}
}

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

ClassMethod count()
{
	set rsClass=##class(%ResultSet).%New("%Dictionary.CompiledClassQuery:Summary")
	if rsClass.Execute() {
		// Get each class
		while rsClass.Next() {
			// Ignore system classes
			if ('rsClass.Get("System"))&&(rsClass.Get("Persistent")) {
				if $extract(rsClass.Get("Name"),1,4)="dbo." {
					set result=##class(%ResultSet).%New()
					set class=##class(%Dictionary.CompiledClass).%OpenId(rsClass.Get("Name"))
					set sqltext="select count(*) nb from "_class.SqlTableName
					do result.Prepare(sqltext)
					do result.Execute()
					while result.Next() {
						;do ..storeNb(class.SqlTableName,result.Data("nb"))
						if result.Data("nb") > 1000 {
							write $i(i)_"---"_rsClass.Get("Name")_":"_result.Data("nb"),!	
						}
					}
				}
			}
		}
	}
}

ClassMethod bitmap()
{
	// ResultSets for walking down the classes
	set rsClass=##class(%ResultSet).%New("%Dictionary.CompiledClassQuery:Summary")
	set rsIndex=##class(%ResultSet).%New("%Dictionary.CompiledIndexQuery:Summary")
 
	if rsClass.Execute() {
		// Get each class
		while rsClass.Next() {
			// Ignore system classes
			if ('rsClass.Get("System"))&&(rsClass.Get("Persistent"))&&($extract(rsClass.Get("Name"),1,4)="dbo.") {
				set className=rsClass.Get("Name")
				// Delete all the indices for this class
				do $zobjclassmethod(className,"%PurgeIndices")
				// Find all the indices for this class
				if rsIndex.Execute(className) {
					// This variable will indicate whether the class will need to be re-compiled
					set compileFlag=0
					while rsIndex.Next() {
						// Get the name of the index
						set indexName = rsIndex.Get("Name")
						kill indexObj
 
						// Open up the index
						set indexObj = ##class(%Dictionary.IndexDefinition).%OpenId(className_"||"_indexName)
 
						// Variable will be null string if this is a system assigned index (IDKEY)
						// Ignore unique indices and those already set to bitmaps
						if (indexObj'="")&&('indexObj.Unique)&&(indexObj.Type'="bitmap") {
							write className_":"_indexObj.Name,!
							set indexObj.Type="bitmap"
							// Save the new definition
							set sc=indexObj.%Save()
							if sc {
								// Indicate that this class needs to be re-compiled
								set compileFlag=1
							}
							else {
								break
							}
						}
					}
				}
				// Close the index resultset
				do rsIndex.Close()
 
				// Compile the class if necessary
				if compileFlag do $system.OBJ.Compile(className,"cko3")
				
				// Now re-populate the indices
				do $zobjclassmethod(className,"%BuildIndices")
			}
		}
	}
 
	kill rsClass, rsIndex
	
	quit
}

ClassMethod addBitmapIndices()
{
	// ResultSets for walking down the classes
	set rsClass=##class(%ResultSet).%New("%Dictionary.CompiledClassQuery:Summary")
	
	if rsClass.Execute() {
		// Get each class
		while rsClass.Next() {
			// Ignore system classes
			if ('rsClass.Get("System"))&&(rsClass.Get("Persistent"))&&($extract(rsClass.Get("Name"),1,4)="dbo.")&&($extract(rsClass.Get("Name"),1,8)'="dbo.Temp") {
				set className=rsClass.Get("Name")
				write $i(nb)_"-"_className,!
				set classObj=##class(%Dictionary.ClassDefinition).%OpenId(className)
				set storageObj=##class(%Dictionary.StorageDefinition).%OpenId(classObj.Storages.GetAt(1).%Id())
				for i=1:1:storageObj.Properties.Count() {
					if (storageObj.ExtentSize>$Piece(storageObj.Properties.GetAt(i).Selectivity,".")) && ($Piece(storageObj.Properties.GetAt(i).Selectivity,".")>9) && ($Piece(storageObj.Properties.GetAt(i).Selectivity,".")<100) {
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
							write ">>> index created:"_indexObj.Name_" "_sc,!
							set ^IGEXAO("index added",classObj.Name,$i(^IGEXAO("index added",classObj.Name)))=$LB(indexObj.Name,indexObj.Properties,storageObj.ExtentSize,storageObj.Properties.GetAt(i).Selectivity)	
						}
						/*else {
							write "index "_indexName_" already exists",!
						}*/
					}
				}
				do $system.OBJ.Compile(className,"cko3-d")		
				// Now re-populate the indices
				do $zobjclassmethod(className,"%PurgeIndices")
				do $zobjclassmethod(className,"%BuildIndices")
				write !
				
			}
		}
	}	
	quit
}

/// check if there are non unique and non IdKey indices to convert in bitmap
ClassMethod countIndices()
{
	// ResultSets for walking down the classes
	set rsClass=##class(%ResultSet).%New("%Dictionary.CompiledClassQuery:Summary")
	
	if rsClass.Execute() {
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
	quit
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
<IdLocation>^adm.utilsD</IdLocation>
<IndexLocation>^adm.utilsI</IndexLocation>
<StreamLocation>^adm.utilsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
