/// 
Class mt.clientPlatinum Extends mt.client
{

Property turnover As %Numeric;

Storage Default
{
<Data name="clientPlatinumDefaultData">
<Subscript>"clientPlatinum"</Subscript>
<Value name="1">
<Value>turnover</Value>
</Value>
</Data>
<DefaultData>clientPlatinumDefaultData</DefaultData>
<ExtentLocation>^Ddod.EPHr</ExtentLocation>
<Index name="$clientPlatinum">
<Location>^Ddod.EPHr.2</Location>
</Index>
<Type>%Storage.Persistent</Type>
}

}
