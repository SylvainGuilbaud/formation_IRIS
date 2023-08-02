Class petshop.model.Order Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor) [ Inheritance = right, ProcedureBlock ]
{

Property complete As %Boolean;

Property id As %Integer;

Property petId As %Integer;

Property quantity As %Integer;

Property shipDate As %TimeStamp;

/// Order Status
Property status As %String(MAXLEN = "", VALUELIST = ",placed,approved,delivered");

Storage Default
{
<Data name="OrderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>complete</Value>
</Value>
<Value name="3">
<Value>id</Value>
</Value>
<Value name="4">
<Value>petId</Value>
</Value>
<Value name="5">
<Value>quantity</Value>
</Value>
<Value name="6">
<Value>shipDate</Value>
</Value>
<Value name="7">
<Value>status</Value>
</Value>
</Data>
<DataLocation>^petshop.model.OrderD</DataLocation>
<DefaultData>OrderDefaultData</DefaultData>
<IdLocation>^petshop.model.OrderD</IdLocation>
<IndexLocation>^petshop.model.OrderI</IndexLocation>
<StreamLocation>^petshop.model.OrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
