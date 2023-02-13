Class data.bastide.client Extends (%Persistent, %Populate)
{

Property nom As %String(MAXLEN = 200, POPSPEC = "LastName()");

Property prenom As %String(MAXLEN = 200, POPSPEC = "FirstName()");

Property adresseFacturation As data.bastide.adresse;

Property adresseLivraison As data.bastide.adresse;

Property adresseSiege As data.bastide.adresse;

Property type As %Integer(DISPLAYLIST = ",caisse, client, azerty", VALUELIST = ",1,2,3");

/// ayantDroit avec key = "enfant 1","fils - 2", "fille 1","conjoint(e)"
/// select count(*) into :max from data_bastide.client where data_bastide_client.ayantdroit_key %startswith 'fils'
/// set key = "fils" _ $increment(max)
Property ayantDroit As array Of data.bastide.client;

/// autonum
Property phone As list Of %String;

/// key = "pro","perso"
Property emails As array Of %String;

Storage Default
{
<Data name="ayantDroit">
<Attribute>ayantDroit</Attribute>
<Structure>subnode</Structure>
<Subscript>"ayantDroit"</Subscript>
</Data>
<Data name="clientDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>nom</Value>
</Value>
<Value name="3">
<Value>prenom</Value>
</Value>
<Value name="4">
<Value>adresseFacturation</Value>
</Value>
<Value name="5">
<Value>adresseLivraison</Value>
</Value>
<Value name="6">
<Value>adresseSiege</Value>
</Value>
<Value name="7">
<Value>type</Value>
</Value>
<Value name="8">
<Value>phone</Value>
</Value>
</Data>
<Data name="emails">
<Attribute>emails</Attribute>
<Structure>subnode</Structure>
<Subscript>"emails"</Subscript>
</Data>
<DataLocation>^data.bastide.clientD</DataLocation>
<DefaultData>clientDefaultData</DefaultData>
<IdLocation>^data.bastide.clientD</IdLocation>
<IndexLocation>^data.bastide.clientI</IndexLocation>
<StreamLocation>^data.bastide.clientS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
