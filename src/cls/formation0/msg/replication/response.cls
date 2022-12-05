Class formation.msg.replication.response Extends Ens.Response
{

Property sTable As %String;

Property nIdentifiant As %Integer;

Property dhDateCreation As %TimeStamp;

Property sAction As %String;

Property sCle As %String;

Property message As %String(MAXLEN = "");

Property status As common.msg.status;

Storage Default
{
<Data name="responseDefaultData">
<Subscript>"response"</Subscript>
<Value name="1">
<Value>sTable</Value>
</Value>
<Value name="2">
<Value>nIdentifiant</Value>
</Value>
<Value name="3">
<Value>dhDateCreation</Value>
</Value>
<Value name="4">
<Value>sAction</Value>
</Value>
<Value name="5">
<Value>sCle</Value>
</Value>
<Value name="6">
<Value>message</Value>
</Value>
<Value name="7">
<Value>status</Value>
</Value>
</Data>
<DefaultData>responseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
