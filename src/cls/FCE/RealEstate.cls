/// Addresses for branches
Class FCE.RealEstate Extends (%Persistent, FCE.Address)
{

ClassMethod ByZip(state As %String = "", Output status As %Status) As %SQL.StatementResult [ ReturnResultsets, SqlProc ]
{
	#dim %sqlcontext as %ProcedureContext
	#dim resultSet as %SQL.StatementResult
	set resultSet = $$$NULLOREF
	#dim statement as %SQL.Statement
	set statement = ##class(%SQL.Statement).%New()
	set sql = "SELECT zip, street, city, state FROM fce.realestate"
	if (state '= "") {
		set sql = sql _ " WHERE state = ?"
	}
	set sql = sql _ " ORDER BY zip"
	set status = statement.%Prepare(sql)
	if $$$ISOK(status) {
		if (state '= "") {
			set resultSet = statement.%Execute(state)
		}
		else {
			set resultSet = statement.%Execute()
		}
		if (resultSet.%SQLCODE = 0) {
			// successful %Execute

			// for testing using Terminal
			do resultSet.%Display()

			// for ODBC/JDBC
			// do %sqlcontext.AddResultSet(resultSet)
		}
		else {
			// error during %Execute
			set %sqlcontext.%SQLCODE = resultSet.%SQLCODE
			set %sqlcontext.%Message = resultSet.%Message
		}
	}
	else {
		// error during %Prepare: bad SQL
		#dim ex as %Exception.StatusException
		set ex = ##class(%Exception.StatusException).CreateFromStatus(status)
		set %sqlcontext.%SQLCODE = ex.AsSQLCODE()
		// 4th ":" piece contains %msg value
		set %sqlcontext.%Message = $piece(ex.AsSQLMessage(), ":", 4)
	}
	return resultSet  // return results to other server-side code
}

Storage Default
{
<Data name="RealEstateDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Street</Value>
</Value>
<Value name="3">
<Value>City</Value>
</Value>
<Value name="4">
<Value>State</Value>
</Value>
<Value name="5">
<Value>Zip</Value>
</Value>
</Data>
<DataLocation>^FCE.RealEstateD</DataLocation>
<DefaultData>RealEstateDefaultData</DefaultData>
<IdLocation>^FCE.RealEstateD</IdLocation>
<IndexLocation>^FCE.RealEstateI</IndexLocation>
<StreamLocation>^FCE.RealEstateS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
