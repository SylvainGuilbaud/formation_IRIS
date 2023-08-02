Class petshop.requests.deletePet Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "delete";

Parameter URL = "/pet/{petId}";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

Property "headerapi_key" As %String;

/// Pet id to delete
Property pathpetId As %Integer;

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	Do httpRequest.SetHeader("api_key", .."headerapi_key")
	Set ..%URL = $Replace(..%URL,"{petId}", ..pathpetId)
	Quit sc
}

Storage Default
{
<Data name="deletePetDefaultData">
<Subscript>"deletePet"</Subscript>
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
<Value>headerapi_key</Value>
</Value>
<Value name="5">
<Value>pathpetId</Value>
</Value>
</Data>
<DefaultData>deletePetDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
