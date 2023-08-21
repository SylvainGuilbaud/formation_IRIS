Class instruments.msg.analyses Extends (Ens.Request, %JSON.Adaptor)
{

Property nInstrument As %String;

Property nTypeArticle As %String;

Property nTypeMaj As %String [ InitialExpression = {$zdt($h,3)} ];

Property sDateAnalyse As %Date [ InitialExpression = {+$h} ];

Property sOperateur As %String;

Property sCodeEchantillon As %String;

Property tTests As array Of instruments.msg.tTests;

Storage Default
{
<Data name="analysesDefaultData">
<Subscript>"analyses"</Subscript>
<Value name="1">
<Value>nInstrument</Value>
</Value>
<Value name="2">
<Value>nTypeArticle</Value>
</Value>
<Value name="3">
<Value>nTypeMaj</Value>
</Value>
<Value name="4">
<Value>sDateAnalyse</Value>
</Value>
<Value name="5">
<Value>sOperateur</Value>
</Value>
<Value name="6">
<Value>sCodeEchantillon</Value>
</Value>
</Data>
<Data name="tTests">
<Attribute>tTests</Attribute>
<Structure>subnode</Structure>
<Subscript>"instruments.msg.analyses.tTests"</Subscript>
</Data>
<DefaultData>analysesDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
