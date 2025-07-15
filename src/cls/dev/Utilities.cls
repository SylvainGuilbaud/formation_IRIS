Class Dev.Utilities
{

/// Reset all storage definitions for a package
ClassMethod ResetStorage(package As %String)
{
	if ($get(package) = "") {
		write !, "Please supply package or sub-package name as argument." quit }
	set resultSet = ##class(%ResultSet).%New()
	set resultSet.ClassName = "%Dictionary.ClassDefinition"
	set resultSet.QueryName = "FormWizard"
	// returns names of persistent classes
	do resultSet.Execute("persistent")
	write !, "Clearing storage definitions for classes:"
	set pattern = "1""" _ package _ """.e"
	
	while resultSet.Next() {
		set className = resultSet.GetData(1)
		continue:(className'?@pattern)
		set class = ##class(%Dictionary.ClassDefinition).%OpenId(className)
		write !, className
		do class.Storages.Clear()
		do class.%Save()
	}
	do resultSet.Close()
	write !, "Compiling classes..."
	do $system.OBJ.CompilePackage(package,"k")
}

/// Rebuild all indices for a package
ClassMethod RebuildIndices(package As %String)
{
	if ($get(package) = "") {
		write !, "Please supply package or sub-package name as argument." quit }
	set resultSet = ##class(%ResultSet).%New()
	set resultSet.ClassName = "%Dictionary.ClassDefinition"
	set resultSet.QueryName = "FormWizard"
	// returns names of persistent classes
	do resultSet.Execute("persistent")
	write !, "Rebuilding indices for classes:"
	set pattern = "1""" _ package _ """.e"
	
	while resultSet.Next() {
		set className = resultSet.GetData(1)
		continue:(className'?@pattern)
		/// 2010.1
		do $CLASSMETHOD(className,"%BuildIndices")
		/// pre-2010.1
		//do $ZOBJCLASSMETHOD(className,"%BuildIndices")
		write !, className
	}
	do resultSet.Close()
}

}
