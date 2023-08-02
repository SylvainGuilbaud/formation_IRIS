Class petshop.requests.createUser Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "post";

Parameter URL = "/user";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

/// Use this property for body content with content-type = application/json.<br/>
/// Use this property for body content with content-type = application/xml.<br/>
/// Use this property for body content with content-type = application/x-www-form-urlencoded.
Property User As petshop.model.User(XMLNAME = "user");

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	If $Piece($$$LOWER(..%ContentType),";",1) = "application/json" Do ..User.%JSONExportToStream(httpRequest.EntityBody)
	If $Piece($$$LOWER(..%ContentType),";",1) = "application/xml" Do ..User.XMLExportToStream(httpRequest.EntityBody)
	If $Piece($$$LOWER(..%ContentType),";",1) = "application/x-www-form-urlencoded" {
		; To implement.  There is no code generation yet for this case.
		$$$ThrowStatus($$$ERROR($$$NotImplemented))
	}
	Quit sc
}

Storage Default
{
<Data name="createUserDefaultData">
<Subscript>"createUser"</Subscript>
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
<Value>User</Value>
</Value>
</Data>
<DefaultData>createUserDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
