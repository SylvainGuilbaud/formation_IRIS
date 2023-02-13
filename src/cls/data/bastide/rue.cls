Class data.bastide.rue Extends (%SerialObject, %Populate)
{

Property rue As %String(MAXLEN = 252, POPSPEC = "Street()");

Property rue2 As %String(MAXLEN = 252);

Property rue3 As %String(MAXLEN = 252);

Property rue4 As %String(MAXLEN = 252);

Storage Default
{
<Data name="rueState">
<Value name="1">
<Value>rue</Value>
</Value>
<Value name="2">
<Value>rue2</Value>
</Value>
<Value name="3">
<Value>rue3</Value>
</Value>
<Value name="4">
<Value>rue4</Value>
</Value>
</Data>
<State>rueState</State>
<StreamLocation>^data.bastide.rueS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
