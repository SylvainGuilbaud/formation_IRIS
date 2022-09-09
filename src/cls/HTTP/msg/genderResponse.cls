Class HTTP.msg.genderResponse Extends Ens.Response
{

Property name As %String;

Property gender As %String;

Property probability As %Numeric;

Property count As %Integer;

Storage Default
{
<Data name="genderResponseDefaultData">
<Subscript>"genderResponse"</Subscript>
<Value name="1">
<Value>name</Value>
</Value>
<Value name="2">
<Value>gender</Value>
</Value>
<Value name="3">
<Value>probability</Value>
</Value>
<Value name="4">
<Value>count</Value>
</Value>
</Data>
<DefaultData>genderResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
