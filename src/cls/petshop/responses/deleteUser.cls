Class petshop.responses.deleteUser Extends petshop.responses.GenericResponse [ ProcedureBlock ]
{

/// Implement operationId : deleteUser
/// delete /user/{username}
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
