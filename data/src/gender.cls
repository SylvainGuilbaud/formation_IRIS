Class data.gender Extends (%Persistent, %XML.Adaptor, %JSON.Adaptor)
{

Property firstname As %String(MAXLEN = 500);

Property value As %String;

Property ts As %TimeStamp [ InitialExpression = {$zdt($h,3)} ];

Storage Default
{
<Data name="genderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>firstname</Value>
</Value>
<Value name="3">
<Value>value</Value>
</Value>
<Value name="4">
<Value>ts</Value>
</Value>
</Data>
<DataLocation>^data.genderD</DataLocation>
<DefaultData>genderDefaultData</DefaultData>
<ExtentSize>6</ExtentSize>
<IdLocation>^data.genderD</IdLocation>
<IndexLocation>^data.genderI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="firstname">
<AverageFieldSize>6.67</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="ts">
<AverageFieldSize>21</AverageFieldSize>
<Selectivity>16.6667%</Selectivity>
</Property>
<Property name="value">
<AverageFieldSize>7</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^data.genderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
