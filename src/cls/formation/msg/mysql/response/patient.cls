Class formation.msg.mysql.response.patient Extends Ens.Response
{

Property inserted As %Integer;

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
</Data>
<DefaultData>patientDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
