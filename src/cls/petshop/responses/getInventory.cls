Class petshop.responses.getInventory Extends petshop.responses.GenericResponse [ ProcedureBlock ]
{

/// Implement operationId : getInventory
/// get /store/inventory
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
