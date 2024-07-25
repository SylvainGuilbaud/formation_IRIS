Class data.CSV.client Extends (%Persistent, %XML.Adaptor)
{

Index NomclientIndex On Nomclient [ Unique ];

Property Nomclient As %String(MAXLEN = "") [ Required ];

Property Adresseclient As %String(MAXLEN = "");

Property Codepostal As %String(MAXLEN = 9);

Property Ville As %String(MAXLEN = "");

Property Pays As %String(MAXLEN = "");

Storage Default
{
<Data name="clientDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nomclient</Value>
</Value>
<Value name="3">
<Value>Adresseclient</Value>
</Value>
<Value name="4">
<Value>Codepostal</Value>
</Value>
<Value name="5">
<Value>Ville</Value>
</Value>
<Value name="6">
<Value>Pays</Value>
</Value>
</Data>
<DataLocation>^data.CSV.clientD</DataLocation>
<DefaultData>clientDefaultData</DefaultData>
<IdLocation>^data.CSV.clientD</IdLocation>
<IndexLocation>^data.CSV.clientI</IndexLocation>
<StreamLocation>^data.CSV.clientS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
