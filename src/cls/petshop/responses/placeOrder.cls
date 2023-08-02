Class petshop.responses.placeOrder Extends petshop.responses.GenericResponse [ ProcedureBlock ]
{

/// http status code = 200 content-type = application/json
/// 
Property Order As petshop.model.Order(XMLNAME = "order");

/// Implement operationId : placeOrder
/// post /store/order
Method LoadFromResponse(httpResponse As %Net.HttpResponse, caller As %String = "") As %Status
{
	Set sc = $$$OK
	Do ##super(httpResponse, caller)
	If $$$LOWER($Piece(httpResponse.ContentType,";",1))="application/json",httpResponse.StatusCode = "200" {
		Set ..Order = ##class(petshop.model.Order).%New()
		Do ..Order.%JSONImport(httpResponse.Data)
		Return sc
	}
	Quit sc
}

Storage Default
{
<Data name="placeOrderDefaultData">
<Subscript>"placeOrder"</Subscript>
<Value name="1">
<Value>Order</Value>
</Value>
</Data>
<DefaultData>placeOrderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
