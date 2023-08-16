Class world.data.Record Extends (%Persistent, %XML.Adaptor, %JSON.Adaptor)
{

Property Country As %String [ SqlColumnNumber = 2 ];

Property DensityPKm2 As %String [ SqlColumnNumber = 3 ];

Property Abbreviation As %String [ SqlColumnNumber = 4 ];

Property AgriculturalLand As %String [ SqlColumnNumber = 5 ];

Property LandAreaKm2 As %String [ SqlColumnNumber = 6 ];

Property ArmedForcessize As %String [ SqlColumnNumber = 7 ];

Property BirthRate As %String [ SqlColumnNumber = 8 ];

Property CallingCode As %String [ SqlColumnNumber = 9 ];

Property CapitalMajorCity As %String [ SqlColumnNumber = 10 ];

Property Co2Emissions As %String [ SqlColumnNumber = 11 ];

Property CPI As %String [ SqlColumnNumber = 12 ];

Property CPIChange As %String [ SqlColumnNumber = 13 ];

Property CurrencyCode As %String [ SqlColumnNumber = 14 ];

Property FertilityRate As %String [ SqlColumnNumber = 15 ];

Property ForestedArea As %String [ SqlColumnNumber = 16 ];

Property GasolinePrice As %String [ SqlColumnNumber = 17 ];

Property GDP As %String [ SqlColumnNumber = 18 ];

Property Grossprimaryeducationenrollment As %String [ SqlColumnNumber = 19 ];

Property Grosstertiaryeducationenrollment As %String [ SqlColumnNumber = 20 ];

Property Infantmortality As %String [ SqlColumnNumber = 21 ];

Property Largestcity As %String [ SqlColumnNumber = 22 ];

Property Lifeexpectancy As %String [ SqlColumnNumber = 23 ];

Property Maternalmortalityratio As %String [ SqlColumnNumber = 24 ];

Property Minimumwage As %String [ SqlColumnNumber = 25 ];

Property Officiallanguage As %String [ SqlColumnNumber = 26 ];

Property Outofpockethealthexpenditure As %String [ SqlColumnNumber = 27 ];

Property Physiciansperthousand As %String [ SqlColumnNumber = 28 ];

Property Population As %String [ SqlColumnNumber = 29 ];

Property PopulationLaborforceparticipation As %String [ SqlColumnNumber = 30 ];

Property Taxrevenue As %String [ SqlColumnNumber = 31 ];

Property Totaltaxrate As %String [ SqlColumnNumber = 32 ];

Property Unemploymentrate As %String [ SqlColumnNumber = 33 ];

Property Urbanpopulation As %String [ SqlColumnNumber = 34 ];

Property Latitude As %String [ SqlColumnNumber = 35 ];

Property Longitude As %String [ SqlColumnNumber = 36 ];

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Country</Value>
</Value>
<Value name="3">
<Value>DensityPKm2</Value>
</Value>
<Value name="4">
<Value>Abbreviation</Value>
</Value>
<Value name="5">
<Value>AgriculturalLand</Value>
</Value>
<Value name="6">
<Value>LandAreaKm2</Value>
</Value>
<Value name="7">
<Value>ArmedForcessize</Value>
</Value>
<Value name="8">
<Value>BirthRate</Value>
</Value>
<Value name="9">
<Value>CallingCode</Value>
</Value>
<Value name="10">
<Value>CapitalMajorCity</Value>
</Value>
<Value name="11">
<Value>Co2Emissions</Value>
</Value>
<Value name="12">
<Value>CPI</Value>
</Value>
<Value name="13">
<Value>CPIChange</Value>
</Value>
<Value name="14">
<Value>CurrencyCode</Value>
</Value>
<Value name="15">
<Value>FertilityRate</Value>
</Value>
<Value name="16">
<Value>ForestedArea</Value>
</Value>
<Value name="17">
<Value>GasolinePrice</Value>
</Value>
<Value name="18">
<Value>GDP</Value>
</Value>
<Value name="19">
<Value>Grossprimaryeducationenrollment</Value>
</Value>
<Value name="20">
<Value>Grosstertiaryeducationenrollment</Value>
</Value>
<Value name="21">
<Value>Infantmortality</Value>
</Value>
<Value name="22">
<Value>Largestcity</Value>
</Value>
<Value name="23">
<Value>Lifeexpectancy</Value>
</Value>
<Value name="24">
<Value>Maternalmortalityratio</Value>
</Value>
<Value name="25">
<Value>Minimumwage</Value>
</Value>
<Value name="26">
<Value>Officiallanguage</Value>
</Value>
<Value name="27">
<Value>Outofpockethealthexpenditure</Value>
</Value>
<Value name="28">
<Value>Physiciansperthousand</Value>
</Value>
<Value name="29">
<Value>Population</Value>
</Value>
<Value name="30">
<Value>PopulationLaborforceparticipation</Value>
</Value>
<Value name="31">
<Value>Taxrevenue</Value>
</Value>
<Value name="32">
<Value>Totaltaxrate</Value>
</Value>
<Value name="33">
<Value>Unemploymentrate</Value>
</Value>
<Value name="34">
<Value>Urbanpopulation</Value>
</Value>
<Value name="35">
<Value>Latitude</Value>
</Value>
<Value name="36">
<Value>Longitude</Value>
</Value>
</Data>
<DataLocation>^world.data.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<IdLocation>^world.data.RecordD</IdLocation>
<IndexLocation>^world.data.RecordI</IndexLocation>
<StreamLocation>^world.data.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
