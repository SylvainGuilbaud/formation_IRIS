Class data.client Extends (%Persistent, %Populate, %JSON.Adaptor, %XML.Adaptor)
{

Property name As %String(MAXLEN = 200);

Property code As %String;

Property description As %String(MAXLEN = "");

Relationship commandes As data.commande [ Cardinality = many, Inverse = client ];

Storage Default
{
<Data name="clientDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>code</Value>
</Value>
<Value name="4">
<Value>description</Value>
</Value>
</Data>
<DataLocation>^data.clientD</DataLocation>
<DefaultData>clientDefaultData</DefaultData>
<IdLocation>^data.clientD</IdLocation>
<IndexLocation>^data.clientI</IndexLocation>
<StreamLocation>^data.clientS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
