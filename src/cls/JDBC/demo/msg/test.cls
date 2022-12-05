Class JDBC.demo.msg.test Extends Ens.Request
{

Property tablename As %String [ InitialExpression = "customer" ];

Storage Default
{
<Data name="testDefaultData">
<Subscript>"test"</Subscript>
<Value name="1">
<Value>tablename</Value>
</Value>
</Data>
<DefaultData>testDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
