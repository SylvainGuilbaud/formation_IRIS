Class common.msg.errors Extends (%SerialObject, %XML.Adaptor)
{

Property errors As array Of common.msg.status;

Storage Default
{
<Data name="errorsState">
<Value name="1">
<Value>errors</Value>
</Value>
</Data>
<State>errorsState</State>
<StreamLocation>^common.msg.errorsS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
