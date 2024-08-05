Class fromJSON.adresse Extends %SerialObject
{

Property Rue As %String(MAXLEN = 500);

Property Ville As %String(MAXLEN = 250);

Property CodePostal As %String(MAXLEN = 9);

Storage Default
{
<Data name="adresseState">
<Value name="1">
<Value>Rue</Value>
</Value>
<Value name="2">
<Value>Ville</Value>
</Value>
<Value name="3">
<Value>CodePostal</Value>
</Value>
</Data>
<State>adresseState</State>
<StreamLocation>^messages.adresseS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
