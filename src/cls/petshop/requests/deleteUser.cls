Class petshop.requests.deleteUser Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "delete";

Parameter URL = "/user/{username}";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

/// The name that needs to be deleted
Property pathusername As %String;

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	Set ..%URL = $Replace(..%URL,"{username}", ..pathusername)
	Quit sc
}

Storage Default
{
<Data name="deleteUserDefaultData">
<Subscript>"deleteUser"</Subscript>
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
<Value>pathusername</Value>
</Value>
</Data>
<DefaultData>deleteUserDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
