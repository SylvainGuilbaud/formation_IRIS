Class petshop.responses.logoutUser Extends petshop.responses.GenericResponse [ ProcedureBlock ]
{

/// Implement operationId : logoutUser
/// get /user/logout
Method LoadFromResponse(httpResponse As %Net.HttpResponse, caller As %String = "") As %Status
{
	Set sc = $$$OK
	Do ##super(httpResponse, caller)
	Quit sc
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
