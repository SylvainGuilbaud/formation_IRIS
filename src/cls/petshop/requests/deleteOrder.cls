Class petshop.requests.deleteOrder Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "delete";

Parameter URL = "/store/order/{orderId}";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

/// ID of the order that needs to be deleted
Property pathorderId As %Integer;

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	Set ..%URL = $Replace(..%URL,"{orderId}", ..pathorderId)
	Quit sc
}

Storage Default
{
<Data name="deleteOrderDefaultData">
<Subscript>"deleteOrder"</Subscript>
<Value name="1">
<Value>%Consume</Value>
</Value>
<Value name="2">
<Value>%ContentType</Value>
</Value>
<Value name="3">
<Value>%URL</Value>
</Value>
<Value name="4">
<Value>pathorderId</Value>
</Value>
</Data>
<DefaultData>deleteOrderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
