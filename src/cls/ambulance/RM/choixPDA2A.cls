Class ambulance.RM.choixPDA2A Extends (Ens.Request, %JSON.Adaptor, %XML.Adaptor)
{

Property episode As %Integer;

Property adresse As %String(MAXLEN = 256);

Storage Default
{
<Data name="choixPDA2ADefaultData">
<Subscript>"choixPDA2A"</Subscript>
<Value name="1">
<Value>episode</Value>
</Value>
<Value name="2">
<Value>adresse</Value>
</Value>
</Data>
<DefaultData>choixPDA2ADefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
