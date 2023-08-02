Class petshop.requests.loginUser Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "get";

Parameter URL = "/user/login";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

/// The password for login in clear text
Property querypassword As %String;

/// The user name for login
Property queryusername As %String;

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	Do httpRequest.SetParam("username",..queryusername)
	Do httpRequest.SetParam("password",..querypassword)
	Quit sc
}

Storage Default
{
<Data name="loginUserDefaultData">
<Subscript>"loginUser"</Subscript>
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
<Value>querypassword</Value>
</Value>
<Value name="5">
<Value>queryusername</Value>
</Value>
</Data>
<DefaultData>loginUserDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
