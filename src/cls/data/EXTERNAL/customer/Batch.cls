Class data.EXTERNAL.customer.Batch Extends Ens.Request
{

Property records As array Of data.EXTERNAL.customer.Record;

Storage Default
{
<Data name="records">
<Attribute>records</Attribute>
<Structure>subnode</Structure>
<Subscript>"data.EXTERNAL.customer.Batch.records"</Subscript>
</Data>
<Type>%Storage.Persistent</Type>
}

}
