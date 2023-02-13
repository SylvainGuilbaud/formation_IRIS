Class data.bastide.caisse Extends (%Persistent, %Populate)
{

Property nom As %String(MAXLEN = 200);

Property prenom As %String(MAXLEN = 200);

Property adresseFacturation As data.bastide.adresse;

Property adresseLivraison As data.bastide.adresse;

Property adresseSiege As data.bastide.adresse;

/// autonum
Property phone As list Of %String;

/// key = "pro","perso"
Property emails As array Of %String;

Storage Default
{
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
</Data>
<DataLocation>^data.bastide.clientD</DataLocation>
<DefaultData>clientDefaultData</DefaultData>
<IdLocation>^data.bastide.clientD</IdLocation>
<IndexLocation>^data.bastide.clientI</IndexLocation>
<StreamLocation>^data.bastide.clientS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
