Class common.person Extends Ens.Request
{

Property names As list Of %String(MAXLEN = "");

Storage Default
{
<Data name="personDefaultData">
<Subscript>"person"</Subscript>
<Value name="1">
<Value>names</Value>
</Value>
</Data>
<DefaultData>personDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
