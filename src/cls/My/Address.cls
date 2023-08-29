Class My.Address Extends %Persistent
{

Property Country;

Property City;

Storage Default
{
<Data name="AddressDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Country</Value>
</Value>
<Value name="3">
<Value>City</Value>
</Value>
</Data>
<DataLocation>^My.AddressD</DataLocation>
<DefaultData>AddressDefaultData</DefaultData>
<IdLocation>^My.AddressD</IdLocation>
<IndexLocation>^My.AddressI</IndexLocation>
<StreamLocation>^My.AddressS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
