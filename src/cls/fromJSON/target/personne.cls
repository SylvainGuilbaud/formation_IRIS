Class fromJSON.target.personne Extends (%Persistent, %XML.Adaptor)
{

Property Nom As %String(MAXLEN = "");

Property Age As %Integer;

Property Adresse As fromJSON.target.adresse;

Property Interets As list Of %String;

Property Telephone As %String;

Storage Default
{
<Data name="personneDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nom</Value>
</Value>
<Value name="3">
<Value>Age</Value>
</Value>
<Value name="4">
<Value>Adresse</Value>
</Value>
<Value name="5">
<Value>Interets</Value>
</Value>
<Value name="6">
<Value>Telephone</Value>
</Value>
</Data>
<DataLocation>^fromJSON.target.personneD</DataLocation>
<DefaultData>personneDefaultData</DefaultData>
<IdLocation>^fromJSON.target.personneD</IdLocation>
<IndexLocation>^fromJSON.target.personneI</IndexLocation>
<StreamLocation>^fromJSON.target.personneS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
