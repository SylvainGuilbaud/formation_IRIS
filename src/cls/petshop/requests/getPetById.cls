Class petshop.requests.getPetById Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "get";

Parameter URL = "/pet/{petId}";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

/// ID of pet to return
Property pathpetId As %Integer;

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	Set ..%URL = $Replace(..%URL,"{petId}", ..pathpetId)
	Quit sc
}

Storage Default
{
<Data name="getPetByIdDefaultData">
<Subscript>"getPetById"</Subscript>
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
<Value>pathpetId</Value>
</Value>
</Data>
<DefaultData>getPetByIdDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
