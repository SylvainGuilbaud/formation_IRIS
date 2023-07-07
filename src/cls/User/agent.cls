Class User.agent Extends User.simple
{

Property dateEntree As %TimeStamp;

Property dateSortie As %TimeStamp;

Property entrepot As User.address;

Storage Default
{
<Data name="agentDefaultData">
<Subscript>"agent"</Subscript>
<Value name="1">
<Value>dateEntree</Value>
</Value>
<Value name="2">
<Value>dateSortie</Value>
</Value>
<Value name="3">
<Value>entrepot</Value>
</Value>
</Data>
<DefaultData>agentDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
