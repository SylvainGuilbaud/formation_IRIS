Class petshop.model.Category Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor) [ Inheritance = right, ProcedureBlock ]
{

Property id As %Integer;

Property name As %String(MAXLEN = "");

Storage Default
{
<Data name="CategoryDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>id</Value>
</Value>
<Value name="3">
<Value>name</Value>
</Value>
</Data>
<DataLocation>^petshop.model.CategoryD</DataLocation>
<DefaultData>CategoryDefaultData</DefaultData>
<IdLocation>^petshop.model.CategoryD</IdLocation>
<IndexLocation>^petshop.model.CategoryI</IndexLocation>
<StreamLocation>^petshop.model.CategoryS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
