Class data.CSV.facture Extends (%Persistent, %XML.Adaptor)
{

Property Numérofacture As %String [ Required ];

Property Datefacture As %Date(FORMAT = 3) [ Required ];

Property client As data.CSV.client;

Property Articles As array Of data.CSV.article;

Property MontanttotalHT As %Double(SCALE = 2);

Property TVA As %Decimal(SCALE = 2);

Property MontanttotalTTC As %Double(SCALE = 2);

Storage Default
{
<Data name="Articles">
<Attribute>Articles</Attribute>
<Structure>subnode</Structure>
<Subscript>"Articles"</Subscript>
</Data>
<Data name="factureDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Numérofacture</Value>
</Value>
<Value name="3">
<Value>Datefacture</Value>
</Value>
<Value name="4">
<Value>client</Value>
</Value>
<Value name="5">
<Value>MontanttotalHT</Value>
</Value>
<Value name="6">
<Value>TVA</Value>
</Value>
<Value name="7">
<Value>MontanttotalTTC</Value>
</Value>
</Data>
<DataLocation>^data.CSV.factureD</DataLocation>
<DefaultData>factureDefaultData</DefaultData>
<IdLocation>^data.CSV.factureD</IdLocation>
<IndexLocation>^data.CSV.factureI</IndexLocation>
<StreamLocation>^data.CSV.factureS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
