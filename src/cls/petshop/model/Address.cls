Class petshop.model.Address Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor) [ Inheritance = right, ProcedureBlock ]
{

Property city As %String(MAXLEN = "");

Property state As %String(MAXLEN = "");

Property street As %String(MAXLEN = "");

Property zip As %String(MAXLEN = "");

Storage Default
{
<Data name="AddressDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>city</Value>
</Value>
<Value name="3">
<Value>state</Value>
</Value>
<Value name="4">
<Value>street</Value>
</Value>
<Value name="5">
<Value>zip</Value>
</Value>
</Data>
<DataLocation>^petshop.model.AddressD</DataLocation>
<DefaultData>AddressDefaultData</DefaultData>
<IdLocation>^petshop.model.AddressD</IdLocation>
<IndexLocation>^petshop.model.AddressI</IndexLocation>
<StreamLocation>^petshop.model.AddressS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
