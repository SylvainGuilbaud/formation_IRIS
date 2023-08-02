Class prodadmin.responses.GenericResponse Extends (%Persistent, Ens.Response) [ Inheritance = left, ProcedureBlock ]
{

Property body As %Stream.GlobalBinary;

Property headers As array Of %String(MAXLEN = 128, TRUNCATE = 1);

Property httpStatusCode As %Integer;

Property operation As %String(MAXLEN = 128, TRUNCATE = 1);

Method LoadFromResponse(httpResponse As %Net.HttpResponse, caller As %String = "") As %Status
{
	Set sc = $$$OK
	Do ..body.CopyFrom(httpResponse.Data)
	Set ..httpStatusCode = httpResponse.StatusCode
	Set ..operation = caller
	Set key = ""
	For  {
		Set key = $Order(httpResponse.Headers(key), 1, headerValue)
		Quit:key=""
		Do ..headers.SetAt(headerValue, key)
	}
	Quit sc
}

Storage Default
{
<Data name="GenericResponseDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>body</Value>
</Value>
<Value name="3">
<Value>httpStatusCode</Value>
</Value>
<Value name="4">
<Value>operation</Value>
</Value>
</Data>
<Data name="headers">
<Attribute>headers</Attribute>
<Structure>subnode</Structure>
<Subscript>"headers"</Subscript>
</Data>
<DataLocation>^prodadminE816.GenericResp16D5D</DataLocation>
<DefaultData>GenericResponseDefaultData</DefaultData>
<IdLocation>^prodadminE816.GenericResp16D5D</IdLocation>
<IndexLocation>^prodadminE816.GenericResp16D5I</IndexLocation>
<StreamLocation>^prodadminE816.GenericResp16D5S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
