Class JDBC.demo.msg.testBatch Extends Ens.Request
{

Property nb As %Integer [ InitialExpression = 50 ];

Storage Default
{
<Data name="testBatchDefaultData">
<Subscript>"testBatch"</Subscript>
<Value name="1">
<Value>nb</Value>
</Value>
</Data>
<DefaultData>testBatchDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
