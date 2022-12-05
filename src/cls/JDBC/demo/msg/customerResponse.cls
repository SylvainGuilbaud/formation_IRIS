Class JDBC.demo.msg.customerResponse Extends Ens.Response
{

Property result As %String(MAXLEN = "");

Storage Default
{
<Data name="customerResponseDefaultData">
<Subscript>"customerResponse"</Subscript>
<Value name="1">
<Value>result</Value>
</Value>
</Data>
<DefaultData>customerResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
