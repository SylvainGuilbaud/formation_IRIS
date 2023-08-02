Class prodadmin.requests.enableNamespace01 Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "put";

Parameter URL = "/namespace/enable/{namespace}";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

/// Use this property for body content with content-type = */*.
Property body As %String;

Property pathnamespace As %String;

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	Set ..%URL = $Replace(..%URL,"{namespace}", ..pathnamespace)
	If $Piece($$$LOWER(..%ContentType),";",1) = "*/*" {
		; To implement.  There is no code generation yet for this case.
		$$$ThrowStatus($$$ERROR($$$NotImplemented))
	}
	Quit sc
}

Storage Default
{
<Data name="enableNamespace01DefaultData">
<Subscript>"enableNamespace01"</Subscript>
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
<Value>pathnamespace</Value>
</Value>
</Data>
<DefaultData>enableNamespace01DefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
