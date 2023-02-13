Class data.bastide.adresse Extends (%SerialObject, %Populate)
{

Property rue As data.bastide.rue;

Property cp As %String(MAXLEN = 5, POPSPEC = "USZip()");

Property ville As %String(MAXLEN = 252, POPSPEC = "City()");

Property pays As %String(MAXLEN = 252);

Property type As %Integer(DISPLAYLIST = ",normalisée, libre, SAP", VALUELIST = ",1,2,3,4,5");

Storage Default
{
<Data name="adresseState">
<Value name="1">
<Value>rue</Value>
</Value>
<Value name="2">
<Value>cp</Value>
</Value>
<Value name="3">
<Value>ville</Value>
</Value>
<Value name="4">
<Value>pays</Value>
</Value>
<Value name="5">
<Value>type</Value>
</Value>
</Data>
<State>adresseState</State>
<StreamLocation>^data.bastide.adresseS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
