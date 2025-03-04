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
<ExtentSize>25</ExtentSize>
<IdLocation>^data.CSV.articleD</IdLocation>
<IndexLocation>^data.CSV.articleI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,16,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000"),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320))</Histogram>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(1,2,4,6,8,10,12,14,16,18,20,21,22,23,24,25),$lb(0,0,0,0,0,1,1,1,1,0,1,1,1,1,1),$lb(822083584,822083584,838860800,838860800,872415232,872415232,905969664,905969664,939524096,939524096,825229312,805306368,838860800,838860800,872415232,872415232,905969664,905969664,939524096,825753600,842006528,805306368,822083584,822083584,838860800,838860800,855638016,855638016,872415232,872415232,889192448,842334208))</Histogram>
<Selectivity>1</Selectivity>
</Property>
<Property name="Code">
<AverageFieldSize>8</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" ART001"," ART002"," ART004"," ART006"," ART008"," ART010"," ART012"," ART014"," ART016"," ART018"," ART020"," ART021"," ART022"," ART023"," ART024"," ART025"),$lb(6,6,6,6,5,6,6,6,6,5,6,6,6,6,6),$lb(541151828,822083584,838860800,838860800,872415232,872415232,905969664,905969664,939524096,808976384,825229312,805306368,838860800,838860800,872415232,872415232,905969664,905969664,939524096,825753600,842006528,805306368,822083584,822083584,838860800,838860800,855638016,855638016,872415232,872415232,889192448,541151828))</Histogram>
<Selectivity>4.0000%</Selectivity>
</Property>
<Property name="Description">
<AverageFieldSize>12.84</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" AGENDA"," AGRAFEUSE"," CAHIER A4"," CARTOUCHES D'ENCRE"," CHEMISE CARTONNÉE"," CLASSEUR A4"," CORRECTEUR"," CÂBLE HDMI"," MARQUEURS"," POST-IT"," SOURIS SANS FIL"," STYLO BLEU"," STYLO-PLUME"," TAILLE-CRAYON"," TAPIS DE SOURIS"," TROMBONES"),$lb(3,1,3,2,2,2,2,1,1,1,2,6,1,3,2),$lb(541148997,1162757185,1380009541,1095193153,1128351817,1212761426,1381257045,1095914575,1212501321,1212501321,1279349587,1279349587,1330795077,1330795077,3259124805,1136804428,1296126545,1296126545,1347375956,1347375956,1397708114,1330991689,1415138383,541215813,760237141,1398036812,1413564748,1229737029,1346982688,1095780691,1380928834,542397007))</Histogram>
<Selectivity>4.0000%</Selectivity>
</Property>
<Property name="PrixUnitaire">
<AverageFieldSize>10</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb($double(.5),$double(.75),$double(1.1999999999999999556),$double(2),$double(3),$double(3.5),$double(4.5),$double(5),$double(8),$double(12),$double(15),$double(15),$double(18),$double(22),$double(25),$double(25)),$lb(9,8,8,8,9,8,8,8,8,9,11,9,8,9,11),$lb(775225344,0,0,0,960051513,960051513,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,842334208))</Histogram>
<Selectivity>5.0000%</Selectivity>
</Property>
<Property name="Quantite">
<AverageFieldSize>3</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(1,1,1,1,1,2,2,3,3,5,10,10,10,15,20,20),$lb(1,1,1,1,0,1,0,1,0,0,2,2,1,0,2),$lb(822083584,0,0,0,0,0,0,0,0,822083584,838860800,0,0,838860800,855638016,0,0,855638016,889192448,889192448,825229312,0,0,0,0,805306368,889192448,825556992,842006528,0,0,842006528))</Histogram>
<Selectivity>14.2857%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^data.CSV.articleS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
