Class common.msg.status Extends (%SerialObject, %XML.Adaptor, %JSON.Adaptor)
{

Property status As %Status(XMLPROJECTION = "none");

Property text As %String(MAXLEN = "") [ Calculated, SqlComputeCode = {set {text}=$SYSTEM.Status.GetErrorText({status})}, SqlComputed ];

Method textGet() As %String
{
    if ..status {
        return "success"
    } else {
        return $SYSTEM.Status.GetErrorText(..status)
    }
}

Storage Default
{
<Data name="statusState">
<Value name="1">
<Value>status</Value>
</Value>
</Data>
<State>statusState</State>
<StreamLocation>^common.msg.statusS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
