Class petshop.responses.deleteOrder Extends petshop.responses.GenericResponse [ ProcedureBlock ]
{

/// Implement operationId : deleteOrder
/// delete /store/order/{orderId}
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
