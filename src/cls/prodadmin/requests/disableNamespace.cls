Class prodadmin.requests.disableNamespace Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "get";

Parameter URL = "/namespace/disable/{namespace}";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

Property pathnamespace As %String;

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	Set ..%URL = $Replace(..%URL,"{namespace}", ..pathnamespace)
	Quit sc
}

Storage Default
{
<Data name="disableNamespaceDefaultData">
<Subscript>"disableNamespace"</Subscript>
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
<Value>pathnamespace</Value>
</Value>
</Data>
<DefaultData>disableNamespaceDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
