Class petshop.responses.loginUser Extends petshop.responses.GenericResponse [ ProcedureBlock ]
{

/// Implement operationId : loginUser
/// get /user/login
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
