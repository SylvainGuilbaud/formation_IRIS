Class data.EXTERNAL.customer.Record Extends (%SerialObject, %XML.Adaptor)
{

Property id As %String;

Property active As %Boolean;

Property category As %Integer;

Property city As %String;

Property created As %TimeStamp;

Property firstName As %String;

Property lastName As %String;

Property hashtag As %String(MAXLEN = 20);

Property gender As %String;

Property country As %String;

Storage Default
{
<Data name="RecordState">
<Value name="1">
<Value>id</Value>
</Value>
<Value name="2">
<Value>active</Value>
</Value>
<Value name="3">
<Value>category</Value>
</Value>
<Value name="4">
<Value>city</Value>
</Value>
<Value name="5">
<Value>created</Value>
</Value>
<Value name="6">
<Value>firstName</Value>
</Value>
<Value name="7">
<Value>lastName</Value>
</Value>
<Value name="8">
<Value>hashtag</Value>
</Value>
<Value name="9">
<Value>gender</Value>
</Value>
<Value name="10">
<Value>country</Value>
</Value>
</Data>
<State>RecordState</State>
<StreamLocation>^data.EXTERNAL.customer.RecordS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
