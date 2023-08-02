Class petshop.requests.findPetsByTags Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "get";

Parameter URL = "/pet/findByTags";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

/// Tags to filter by
Property querytags As list Of %String;

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	Set key = ""
	For  {
		Set tmpValue = ..querytags.GetNext(.key)
		Quit:key=""
		Do httpRequest.SetParam("tags", tmpValue, key)
	}
	Quit sc
}

Storage Default
{
<Data name="findPetsByTagsDefaultData">
<Subscript>"findPetsByTags"</Subscript>
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
<Value>querytags</Value>
</Value>
</Data>
<DefaultData>findPetsByTagsDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
