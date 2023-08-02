Class petshop.model.Pet Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor) [ Inheritance = right, ProcedureBlock ]
{

Property category As petshop.model.Category(XMLNAME = "category");

Property id As %Integer;

Property name As %String(MAXLEN = "") [ Required ];

Property photoUrls As list Of %String(MAXLEN = "", XMLITEMNAME = "photoUrl") [ Required ];

/// pet status in the store
Property status As %String(MAXLEN = "", VALUELIST = ",available,pending,sold");

Property tags As list Of petshop.model.Tag(XMLITEMNAME = "tag");

Storage Default
{
<Data name="PetDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>category</Value>
</Value>
<Value name="3">
<Value>id</Value>
</Value>
<Value name="4">
<Value>name</Value>
</Value>
<Value name="5">
<Value>photoUrls</Value>
</Value>
<Value name="6">
<Value>status</Value>
</Value>
<Value name="7">
<Value>tags</Value>
</Value>
</Data>
<DataLocation>^petshop.model.PetD</DataLocation>
<DefaultData>PetDefaultData</DefaultData>
<IdLocation>^petshop.model.PetD</IdLocation>
<IndexLocation>^petshop.model.PetI</IndexLocation>
<StreamLocation>^petshop.model.PetS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
