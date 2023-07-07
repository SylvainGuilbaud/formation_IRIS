Class Dev.Utilities
{

/// Reset all storage definitions for a package
ClassMethod ResetStorage(package As %String)
{
	if ($get(package) = "") {
		write !, "Please supply package or sub-package name as argument." return }
	#dim resultSet as %ResultSet
	set resultSet = ##class(%ResultSet).%New()
	set resultSet.ClassName = "%Dictionary.ClassDefinition"
	set resultSet.QueryName = "FormWizard"
	// returns names of persistent classes
	do resultSet.%Execute("persistent")
	write !, "Clearing storage definitions for classes:"
	set pattern = "1""" _ package _ """.e"
	while resultSet.%Next() {
		set className = resultSet.%GetData(1)
		continue:(className'?@pattern)
		#dim class as %Dictionary.ClassDefinition
		set class = ##class(%Dictionary.ClassDefinition).%OpenId(className)
		write !, className
		do class.Storages.Clear()
		do class.%Save()
	}
	do resultSet.Close()
	write !, "Compiling classes..."
	do $system.OBJ.CompilePackage(package,"k")
}

/// Remove all Population code from classes (call with commit=1 to actually save/recompile the classes)
ClassMethod RemovePopulation(package As %String, commit As %Boolean = 0) As %Status
{
	if ($get(package) = "") {
		write !, "Please supply package or sub-package name as argument." return $$$OK }
	if commit {
		read !, "Changes will be saved and classes recompiled. Continue? No=>", cont
		return:($case($extract(cont), "Y":0, "y":0, :1)) $$$OK
	} 
	
	set status = $$$OK
	
	&sql(DECLARE rempop CURSOR FOR
		 SELECT parent, name FROM %Dictionary.PropertyDefinition
		 WHERE (parent %STARTSWITH :package) AND (parameters LIKE '%POPSPEC%')
		 UNION
		 SELECT name, null FROM %Dictionary.ClassDefinition
		 WHERE (name %STARTSWITH :package) AND (super LIKE '%Populate%')
		 ORDER BY parent)
	&sql(OPEN rempop)
	quit:(SQLCODE '= 0) // error -101 if cursor already open
	for {
		&sql(FETCH rempop INTO :classname, :propertyname)
		quit:(SQLCODE '= 0)
		write !, classname, ?20, propertyname
		
		// process superclass list (extends)
		#dim class as %Dictionary.ClassDefinition
		set class = ##class(%Dictionary.ClassDefinition).%OpenId(classname)
		set classes(classname) = ""
		set super = class.Super
		if (super [ "%Populate") || (super [ "%Library.Populate") {
			set superList = $listfromstring(super, ",")
			set loc1 = $listfind(superList, "%Populate")
			set loc2 = $listfind(superList, "%Library.Populate")
			set j = 1, superNew = ""
			for i=1:1:$listlength(superList) {
				if (i = loc1) || (i = loc2) {  } // skip, do nothing
				else {
					set $piece(superNew, ",", j) = $list(superList, i)
					set j = j + 1
				}
			}
			write ?40, superNew
			if 'class.SuperIsModified() { set class.Super = superNew }
		}
		
		// process POPSPEC
		if propertyname '= "" {
			#dim property as %Dictionary.PropertyDefinition
			set property = ##class(%Dictionary.PropertyDefinition).IDKEYOpen(classname,propertyname)
			do property.Parameters.RemoveAt("POPSPEC") 
		}
		
		// save changes or not?
		if commit {
			set stClass = class.%Save()
			set stProp = property.%Save()
		}			
	}
	&sql(CLOSE rempop)
	quit:(SQLCODE '= 0) // error -102 if cursor not open
	
	// comment in if really ready to recompile classes
	/* if commit { do $system.OBJ.Compile(.classes, "ck") }
	else { write ! zw classes } */
	write ! zw classes
	quit status
}

/// Load Person classes (exercise C-1), and update classes programmatically using %Dictionary package
ClassMethod LoadConfigPerson(directory As %String = "c:\Development\Studio\PersonOnly.xml")
{
	set st = $system.OBJ.Load(directory, "ck")
	quit:$$$ISERR(st)
	#dim classAccountHolder, classCurrencyOrder as %Dictionary.ClassDefinition
	set classAccountHolder = ##class(%Dictionary.ClassDefinition).%OpenId("FCE.AccountHolder")
	set classCurrencyOrder = ##class(%Dictionary.ClassDefinition).%OpenId("FCE.CurrencyOrder")
	#dim propAccttoCO as %Dictionary.PropertyDefinition
	set propAccttoCO = ##class(%Dictionary.PropertyDefinition).%New()
	set propAccttoCO.Name = "CurrencyOrders",
	    propAccttoCO.Type = "FCE.CurrencyOrder",
	    propAccttoCO.Relationship = 1,
	    propAccttoCO.Cardinality = "many",
	    propAccttoCO.Inverse = "AccountHolder",
	    propAccttoCO.Description = "Exchanges that this customer made"
	set propAccttoCO.parent = classAccountHolder
	
	#dim propCOtoAcct as %Dictionary.PropertyDefinition
	set propCOtoAcct = ##class(%Dictionary.PropertyDefinition).%New()
	set propCOtoAcct.Name = "AccountHolder",
	    propCOtoAcct.Type = "FCE.AccountHolder",
	    propCOtoAcct.Relationship = 1,
	    propCOtoAcct.Cardinality = "one",
	    propCOtoAcct.Inverse = "CurrencyOrders"
	set propCOtoAcct.parent = classCurrencyOrder
	
	#dim indexAcct as %Dictionary.IndexDefinition
	set indexAcct = ##class(%Dictionary.IndexDefinition).%New()
	set indexAcct.Name = "AccountHolderIndex", indexAcct.Properties = "AccountHolder"
	set indexAcct.parent = classCurrencyOrder
	
	do classAccountHolder.%Save(), classCurrencyOrder.%Save()
	
	set compileList = "FCE.AccountHolder.cls,FCE.CurrencyOrder.cls"
	do $system.OBJ.CompileList(compileList, "ck")
}

}
