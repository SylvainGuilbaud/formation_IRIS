Class data.CSV.article Extends (%Persistent, %XML.Adaptor)
{

Property Code As %String(MAXLEN = "");

Property Description As %String(MAXLEN = "");

Property Quantite As %Integer;

Property PrixUnitaire As %Double(SCALE = 2);

Storage Default
{
<Data name="articleDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Code</Value>
</Value>
<Value name="3">
<Value>Description</Value>
</Value>
<Value name="4">
<Value>Quantite</Value>
</Value>
<Value name="5">
<Value>PrixUnitaire</Value>
</Value>
</Data>
<DataLocation>^data.CSV.articleD</DataLocation>
<DefaultData>articleDefaultData</DefaultData>
<IdLocation>^data.CSV.articleD</IdLocation>
<IndexLocation>^data.CSV.articleI</IndexLocation>
<StreamLocation>^data.CSV.articleS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
