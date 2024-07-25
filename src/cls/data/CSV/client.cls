Class data.CSV.client Extends (%Persistent, %XML.Adaptor)
{

Index NomclientIndex On Nomclient [ Unique ];

Property Nomclient As %String(MAXLEN = "") [ Required ];

Property Adresseclient As %String(MAXLEN = "");

Property Codepostal As %String(MAXLEN = 9);

Property Ville As %String(MAXLEN = "");

Property Pays As %String(MAXLEN = "");

Storage Default
{
<Data name="clientDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nomclient</Value>
</Value>
<Value name="3">
<Value>Adresseclient</Value>
</Value>
<Value name="4">
<Value>Codepostal</Value>
</Value>
<Value name="5">
<Value>Ville</Value>
</Value>
<Value name="6">
<Value>Pays</Value>
</Value>
</Data>
<DataLocation>^data.CSV.clientD</DataLocation>
<DefaultData>clientDefaultData</DefaultData>
<ExtentSize>5</ExtentSize>
<IdLocation>^data.CSV.clientD</IdLocation>
<IndexLocation>^data.CSV.clientI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Adresseclient">
<AverageFieldSize>23</AverageFieldSize>
<Selectivity>20.0000%</Selectivity>
</Property>
<Property name="Codepostal">
<AverageFieldSize>7</AverageFieldSize>
<Selectivity>20.0000%</Selectivity>
</Property>
<Property name="Nomclient">
<AverageFieldSize>14.2</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Pays">
<AverageFieldSize>8</AverageFieldSize>
<OutlierSelectivity>.999999:"France"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="Ville">
<AverageFieldSize>7.4</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="NomclientIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^data.CSV.clientS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
