Class petshop.requests.updatePetWithForm Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "post";

Parameter URL = "/pet/{petId}";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

/// ID of pet that needs to be updated
Property pathpetId As %Integer;

/// Name of pet that needs to be updated
Property queryname As %String;

/// Status of pet that needs to be updated
Property querystatus As %String;

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	Set ..%URL = $Replace(..%URL,"{petId}", ..pathpetId)
	Do httpRequest.SetParam("name",..queryname)
	Do httpRequest.SetParam("status",..querystatus)
	Quit sc
}

Storage Default
{
<Data name="updatePetWithFormDefaultData">
<Subscript>"updatePetWithForm"</Subscript>
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
<Value name="5">
<Value>queryname</Value>
</Value>
<Value name="6">
<Value>querystatus</Value>
</Value>
</Data>
<DefaultData>updatePetWithFormDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
