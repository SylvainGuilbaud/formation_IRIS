Class User.address Extends (%SerialObject, %Populate)
{

Property rue As %String(MAXLEN = 500);

Property cp As %String(MAXLEN = 5);

Property ville As %String(MAXLEN = 200, POPSPEC = "City()");

Property pays As %String(MAXLEN = 200);

Storage Default
{
<Data name="addressState">
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
</Data>
<State>addressState</State>
<StreamLocation>^User.addressS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
