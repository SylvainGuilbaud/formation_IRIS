Class formation.msg.mysql.response.personne Extends (Ens.Response, %JSON.Adaptor)
{

Property inserted As %Integer;

Property updated As %Integer;

Property status As %Status;

Storage Default
{
<Data name="personneDefaultData">
<Subscript>"personne"</Subscript>
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
<DefaultData>personneDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
