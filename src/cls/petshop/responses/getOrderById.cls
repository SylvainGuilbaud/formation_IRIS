Class petshop.responses.getOrderById Extends petshop.responses.GenericResponse [ ProcedureBlock ]
{

/// http status code = 200 content-type = application/xml
/// http status code = 200 content-type = application/json
/// 
Property Order As petshop.model.Order(XMLNAME = "order");

/// Implement operationId : getOrderById
/// get /store/order/{orderId}
Method LoadFromResponse(httpResponse As %Net.HttpResponse, caller As %String = "") As %Status
{
	Set sc = $$$OK
	Do ##super(httpResponse, caller)
	If $$$LOWER($Piece(httpResponse.ContentType,";",1))="application/xml",httpResponse.StatusCode = "200" {
		Set reader = ##class(%XML.Reader).%New()
		$$$QuitOnError(reader.OpenStream(httpResponse.Data))
		Do reader.Correlate("order","petshop.model.Order")
		Do reader.Next(.Order, .sc)
		If $$$ISERR(sc) Quit sc
		Set ..Order = Order
		Return sc
	}
	If $$$LOWER($Piece(httpResponse.ContentType,";",1))="application/json",httpResponse.StatusCode = "200" {
		Set ..Order = ##class(petshop.model.Order).%New()
		Do ..Order.%JSONImport(httpResponse.Data)
		Return sc
	}
	Quit sc
}

Storage Default
{
<Data name="getOrderByIdDefaultData">
<Subscript>"getOrderById"</Subscript>
<Value name="1">
<Value>Order</Value>
</Value>
</Data>
<DefaultData>getOrderByIdDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
