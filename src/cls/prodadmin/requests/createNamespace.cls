Class prodadmin.requests.createNamespace Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "post";

Parameter URL = "/namespace";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

/// Use this property for body content with content-type = */*.
Property body As %String;

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	If $Piece($$$LOWER(..%ContentType),";",1) = "*/*" {
		; To implement.  There is no code generation yet for this case.
		$$$ThrowStatus($$$ERROR($$$NotImplemented))
	}
	Quit sc
}

Storage Default
{
<Data name="createNamespaceDefaultData">
<Subscript>"createNamespace"</Subscript>
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
</Data>
<DefaultData>createNamespaceDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
