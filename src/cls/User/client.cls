Class User.client Extends User.simple
{

Property referenceFournisseur As User.simple;

Property referenceAgent As User.agent;

Property clientPartenaire As User.client;

Property clientPartenaires As array Of User.client;

Property bureau As User.address;

Storage Default
{
<Data name="clientDefaultData">
<Subscript>"client"</Subscript>
<Value name="1">
<Value>referenceFournisseur</Value>
</Value>
<Value name="2">
<Value>referenceAgent</Value>
</Value>
<Value name="3">
<Value>clientPartenaire</Value>
</Value>
<Value name="4">
<Value>bureau</Value>
</Value>
</Data>
<Data name="clientPartenaires">
<Attribute>clientPartenaires</Attribute>
<Structure>subnode</Structure>
<Subscript>"User.client.clientPartenaires"</Subscript>
</Data>
<DefaultData>clientDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
