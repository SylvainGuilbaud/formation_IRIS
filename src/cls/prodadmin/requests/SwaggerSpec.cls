Class prodadmin.requests.SwaggerSpec Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "get";

Parameter URL = "/_spec";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	Quit sc
}

Storage Default
{
<Data name="SwaggerSpecDefaultData">
<Subscript>"SwaggerSpec"</Subscript>
<Value name="1">
<Value>%Consume</Value>
</Value>
<Value name="2">
<Value>%ContentType</Value>
</Value>
<Value name="3">
<Value>%URL</Value>
</Value>
</Data>
<DefaultData>SwaggerSpecDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
