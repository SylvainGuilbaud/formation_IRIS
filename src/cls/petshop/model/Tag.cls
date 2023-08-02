Class petshop.model.Tag Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor) [ Inheritance = right, ProcedureBlock ]
{

Property id As %Integer;

Property name As %String(MAXLEN = "");

Storage Default
{
<Data name="TagDefaultData">
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
<DataLocation>^petshop.model.TagD</DataLocation>
<DefaultData>TagDefaultData</DefaultData>
<IdLocation>^petshop.model.TagD</IdLocation>
<IndexLocation>^petshop.model.TagI</IndexLocation>
<StreamLocation>^petshop.model.TagS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
