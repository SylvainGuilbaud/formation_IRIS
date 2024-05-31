Class EDIFACT.msg.array Extends Ens.Request
{

Property documents As array Of EDIFACT.msg.transformed;

Storage Default
{
<Data name="documents">
<Attribute>documents</Attribute>
<Structure>subnode</Structure>
<Subscript>"EDIFACT.msg.array.documents"</Subscript>
</Data>
<Type>%Storage.Persistent</Type>
}

}
