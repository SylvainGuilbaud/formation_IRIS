Class petshop.requests.uploadFile Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "post";

Parameter URL = "/pet/{petId}/uploadImage";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

/// Use this property for body content with content-type = application/octet-stream.
Property body As %Stream.GlobalBinary;

/// ID of pet to update
Property pathpetId As %Integer;

/// Additional Metadata
Property queryadditionalMetadata As %String;

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	Set ..%URL = $Replace(..%URL,"{petId}", ..pathpetId)
	Do httpRequest.SetParam("additionalMetadata",..queryadditionalMetadata)
	If $Piece($$$LOWER(..%ContentType),";",1) = "application/octet-stream" Do httpRequest.EntityBody.CopyFrom(..body)
	Quit sc
}

Storage Default
{
<Data name="uploadFileDefaultData">
<Subscript>"uploadFile"</Subscript>
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
<Value>body</Value>
</Value>
<Value name="5">
<Value>pathpetId</Value>
</Value>
<Value name="6">
<Value>queryadditionalMetadata</Value>
</Value>
</Data>
<DefaultData>uploadFileDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
