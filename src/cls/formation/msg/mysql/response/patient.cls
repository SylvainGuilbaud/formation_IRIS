Class formation.msg.mysql.response.patient Extends (Ens.Response, %JSON.Adaptor)
{

Property inserted As %Integer;

Property updated As %Integer;

Property status As common.msg.status;

Storage Default
{
<Data name="patientDefaultData">
<Subscript>"patient"</Subscript>
<Value name="1">
<Value>status</Value>
</Value>
<Value name="2">
<Value>inserted</Value>
</Value>
<Value name="3">
<Value>updated</Value>
</Value>
</Data>
<DefaultData>patientDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
