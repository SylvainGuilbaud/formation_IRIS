Class JDBC.demo.msg.init Extends Ens.Request
{

Property nb As %Integer [ InitialExpression = 50 ];

Storage Default
{
<Data name="initDefaultData">
<Subscript>"init"</Subscript>
<Value name="1">
<Value>nb</Value>
</Value>
</Data>
<DefaultData>initDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
