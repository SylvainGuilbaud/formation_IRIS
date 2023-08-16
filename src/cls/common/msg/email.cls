Class common.msg.email Extends Ens.Request
{

Property Source As %String(MAXLEN = "");

Property Content As %Stream.GlobalBinary;

Property SourceFileName As %String(MAXLEN = "");

Storage Default
{
<Data name="emailDefaultData">
<Subscript>"email"</Subscript>
<Value name="1">
<Value>Source</Value>
</Value>
<Value name="2">
<Value>Content</Value>
</Value>
<Value name="3">
<Value>SourceFileName</Value>
</Value>
</Data>
<DefaultData>emailDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
