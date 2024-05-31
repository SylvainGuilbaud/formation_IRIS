Class EDIFACT.msg.transformed Extends Ens.Request
{

Property UNH As %String(MAXLEN = "");

Property BGM As %String(MAXLEN = "");

Property FTX As array Of %String(MAXLEN = "");

Property TDT As %String(MAXLEN = "");

Property RFF As array Of %String(MAXLEN = "");

Property LOC As array Of %String(MAXLEN = "");

Property UNT As %String(MAXLEN = "");

Storage Default
{
<Data name="FTX">
<Attribute>FTX</Attribute>
<Structure>subnode</Structure>
<Subscript>"EDIFACT.msg.transformed.FTX"</Subscript>
</Data>
<Data name="LOC">
<Attribute>LOC</Attribute>
<Structure>subnode</Structure>
<Subscript>"EDIFACT.msg.transformed.LOC"</Subscript>
</Data>
<Data name="RFF">
<Attribute>RFF</Attribute>
<Structure>subnode</Structure>
<Subscript>"EDIFACT.msg.transformed.RFF"</Subscript>
</Data>
<Data name="transformedDefaultData">
<Subscript>"transformed"</Subscript>
<Value name="1">
<Value>UNH</Value>
</Value>
<Value name="2">
<Value>BGM</Value>
</Value>
<Value name="3">
<Value>TDT</Value>
</Value>
<Value name="4">
<Value>UNT</Value>
</Value>
</Data>
<DefaultData>transformedDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
