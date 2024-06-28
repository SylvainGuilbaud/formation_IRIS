/// 
Class mt.clientVIP Extends mt.client
{

Property gifts As array Of %String;

Property startDate As %Date;

Property category As %Integer(DISPLAYLIST = ",ultra important,very important,important", VALUELIST = ",1,2,3");

Storage Default
{
<Data name="clientVIPDefaultData">
<Subscript>"clientVIP"</Subscript>
<Value name="1">
<Value>startDate</Value>
</Value>
<Value name="2">
<Value>category</Value>
</Value>
</Data>
<Data name="gifts">
<Attribute>gifts</Attribute>
<Structure>subnode</Structure>
<Subscript>"mt.clientVIP.gifts"</Subscript>
</Data>
<DefaultData>clientVIPDefaultData</DefaultData>
<ExtentLocation>^Ddod.Cxyx</ExtentLocation>
<Index name="$clientVIP">
<Location>^Ddod.Cxyx.2</Location>
</Index>
<Type>%Storage.Persistent</Type>
}

}
