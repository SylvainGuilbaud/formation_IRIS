Class fromJSON.personne Extends %Persistent
{

Property Nom As %String;

Property Age As %Integer;

Property Adresse As fromJSON.adresse;

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
<DataLocation>^messages.personneD</DataLocation>
<DefaultData>personneDefaultData</DefaultData>
<IdLocation>^messages.personneD</IdLocation>
<IndexLocation>^messages.personneI</IndexLocation>
<StreamLocation>^messages.personneS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
