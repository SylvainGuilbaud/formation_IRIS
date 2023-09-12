Class mydata.clients4 Extends (%Persistent, %Populate, %JSON.Adaptor, %XML.Adaptor)
{

Property name As %String(MAXLEN = 200);

Property code As %String;

Property description As %String(MAXLEN = "");

Relationship commandes As data.commande [ Cardinality = many, Inverse = client ];

Storage Default
{
<Data name="clients4DefaultData">
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
<DataLocation>^mydata.clients4D</DataLocation>
<DefaultData>clients4DefaultData</DefaultData>
<IdLocation>^mydata.clients4D</IdLocation>
<IndexLocation>^mydata.clients4I</IndexLocation>
<StreamLocation>^mydata.clients4S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
