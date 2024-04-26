Class formation.msg.mysql.batch Extends interop.msg.JSONMessage
{

Property list As array Of formation.msg.mysql.personne;

Storage Default
{
<Data name="list">
<Attribute>list</Attribute>
<Structure>subnode</Structure>
<Subscript>"formation.msg.mysql.batch.list"</Subscript>
</Data>
<Type>%Storage.Persistent</Type>
}

}
