Class instruments.msg.tTests Extends (%SerialObject, %XML.Adaptor, %JSON.Adaptor)
{

Property mesure As %Numeric;

Storage Default
{
<Data name="tTestsState">
<Value name="1">
<Value>mesure</Value>
</Value>
</Data>
<State>tTestsState</State>
<StreamLocation>^instruments.msg.tTestsS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
