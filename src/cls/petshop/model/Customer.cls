Class petshop.model.Customer Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor) [ Inheritance = right, ProcedureBlock ]
{

Property address As list Of petshop.model.Address(XMLITEMNAME = "address", XMLNAME = "addresses");

Property id As %Integer;

Property username As %String(MAXLEN = "");

Storage Default
{
<Data name="CustomerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>address</Value>
</Value>
<Value name="3">
<Value>id</Value>
</Value>
<Value name="4">
<Value>username</Value>
</Value>
</Data>
<DataLocation>^petshop.model.CustomerD</DataLocation>
<DefaultData>CustomerDefaultData</DefaultData>
<IdLocation>^petshop.model.CustomerD</IdLocation>
<IndexLocation>^petshop.model.CustomerI</IndexLocation>
<StreamLocation>^petshop.model.CustomerS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
