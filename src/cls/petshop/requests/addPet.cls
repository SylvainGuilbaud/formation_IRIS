Class petshop.requests.addPet Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "post";

Parameter URL = "/pet";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

/// Use this property for body content with content-type = application/json.<br/>
/// Use this property for body content with content-type = application/xml.<br/>
/// Use this property for body content with content-type = application/x-www-form-urlencoded.
Property Pet As petshop.model.Pet(XMLNAME = "pet");

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	If $Piece($$$LOWER(..%ContentType),";",1) = "application/json" Do ..Pet.%JSONExportToStream(httpRequest.EntityBody)
	If $Piece($$$LOWER(..%ContentType),";",1) = "application/xml" Do ..Pet.XMLExportToStream(httpRequest.EntityBody)
	If $Piece($$$LOWER(..%ContentType),";",1) = "application/x-www-form-urlencoded" {
		; To implement.  There is no code generation yet for this case.
		$$$ThrowStatus($$$ERROR($$$NotImplemented))
	}
	Quit sc
}

Storage Default
{
<Data name="addPetDefaultData">
<Subscript>"addPet"</Subscript>
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
<Value>Pet</Value>
</Value>
</Data>
<DefaultData>addPetDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
