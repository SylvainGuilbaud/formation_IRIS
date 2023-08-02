Class petshop.requests.getUserByName Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "get";

Parameter URL = "/user/{username}";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

/// The name that needs to be fetched. Use user1 for testing. 
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
<Data name="getUserByNameDefaultData">
<Subscript>"getUserByName"</Subscript>
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
<DefaultData>getUserByNameDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
