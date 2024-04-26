Class dc.data.Country Extends %Library.Persistent [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property country As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 2 ];

Property latitude As %Library.Currency [ SqlColumnNumber = 3 ];

Property longitude As %Library.Currency [ SqlColumnNumber = 4 ];

Property name As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 5 ];

ClassMethod Import(pSelectMode As %Library.Integer = {$zu(115,5)}, pFileName As %Library.String(MAXLEN=""), pDelimiter As %String = ",", pQuote As %String = """", pHeaders As %Integer = 0, ByRef pRecordCount As %Integer, pAppend As %Boolean = 0) As %Library.Integer [ SqlProc ]
{
	set tStatementId = $SYSTEM.Util.CreateGUID(), tCounter = 0, pRecordCount = 0
	set tPreparedStatement = ##class(%SQL.DynamicStatement).Prepare(tStatementId,..#ROWTYPE,pDelimiter,pQuote,,,0,"CSV")
	if $Isobject(tPreparedStatement) {
		set tImporter = tPreparedStatement.%New(tPreparedStatement,,pFileName,pDelimiter,pQuote)
		if $Isobject(tImporter) {
			if 'pAppend do ..%DeleteExtent(,.tDeleted,.tInstances,1)
				// burn the column headers
			for tPtr = 1:1:pHeaders { do tImporter.%Next() }
			while tImporter.%Next() {
				set tMe = ..%New()
				if 'pSelectMode {
					set tMe.country = tImporter.%GetData(1)
					set tMe.latitude = tImporter.%GetData(2)
					set tMe.longitude = tImporter.%GetData(3)
					set tMe.name = tImporter.%GetData(4)
				}
				elseif pSelectMode = 1 {
					set tMe.country = $s('$system.CLS.IsMthd("countryOdbcToLogical"):tImporter.%GetData(1),1:tMe.countryOdbcToLogical(tImporter.%GetData(1)))
					set tMe.latitude = $s('$system.CLS.IsMthd("latitudeOdbcToLogical"):tImporter.%GetData(2),1:tMe.latitudeOdbcToLogical(tImporter.%GetData(2)))
					set tMe.longitude = $s('$system.CLS.IsMthd("longitudeOdbcToLogical"):tImporter.%GetData(3),1:tMe.longitudeOdbcToLogical(tImporter.%GetData(3)))
					set tMe.name = $s('$system.CLS.IsMthd("nameOdbcToLogical"):tImporter.%GetData(4),1:tMe.nameOdbcToLogical(tImporter.%GetData(4)))
				}
				elseif pSelectMode = 2 {
					set tMe.country = $s('$system.CLS.IsMthd("countryDisplayToLogical"):tImporter.%GetData(1),1:tMe.countryDisplayToLogical(tImporter.%GetData(1)))
					set tMe.latitude = $s('$system.CLS.IsMthd("latitudeDisplayToLogical"):tImporter.%GetData(2),1:tMe.latitudeDisplayToLogical(tImporter.%GetData(2)))
					set tMe.longitude = $s('$system.CLS.IsMthd("longitudeDisplayToLogical"):tImporter.%GetData(3),1:tMe.longitudeDisplayToLogical(tImporter.%GetData(3)))
					set tMe.name = $s('$system.CLS.IsMthd("nameDisplayToLogical"):tImporter.%GetData(4),1:tMe.nameDisplayToLogical(tImporter.%GetData(4)))
				}
				set tStatus = tMe.%Save()
				if $$$ISOK(tStatus) { set tCounter = tCounter + 1 }
			}
		}
	}
	set %sqlcontext.%SQLCODE = 0
	set %sqlcontext.%ROWCOUNT = tCounter
	set pRecordCount = tCounter
	quit tCounter
}

Parameter ROWTYPE = "country VARCHAR(250),latitude MONEY,longitude MONEY,name VARCHAR(250)";

Storage Default
{
<Data name="CountryDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>country</Value>
</Value>
<Value name="3">
<Value>latitude</Value>
</Value>
<Value name="4">
<Value>longitude</Value>
</Value>
<Value name="5">
<Value>name</Value>
</Value>
</Data>
<DataLocation>^dc.data.CountryD</DataLocation>
<DefaultData>CountryDefaultData</DefaultData>
<ExtentSize>245</ExtentSize>
<IdLocation>^dc.data.CountryD</IdLocation>
<IndexLocation>^dc.data.CountryI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,16,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000"),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320))</Histogram>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="country">
<AverageFieldSize>4</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" AD"," BA"," BY"," CX"," FJ"," GQ"," IL"," KM"," LV"," MS"," NP"," PT"," SI"," TH"," UY"," ZW"),$lb(1,2,1,1,1,1,1,1,1,1,1,1,1,1,1),$lb(541148160,1094975488,1111556096,1090519040,1493172224,1113128960,1129840640,1129840640,1179254784,1179254784,1196490752,1196490752,1229717504,1229717504,1263337472,1263337472,1280704512,1280704512,1297285120,1297285120,1313865728,1313865728,1347682304,1347682304,1397293056,1397293056,1414004736,1414004736,1431896064,1431896064,1515651072,542791424))</Histogram>
<Selectivity>0.4082%</Selectivity>
</Property>
<Property name="latitude">
<AverageFieldSize>5.85</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,1,$lb("-10000000000000000000",-24.7036,-15.3767,-6.369,1.6508,7.8731,12.5211,15.415,18.2208,23.6345,31.0461,36.2048,41.9029,46.9419,53.4129,77.5536),$lb(1,1,1,0,0,0,1,1,0,0,1,0,1,0,0),$lb(758198320,825241648,842280503,842280503,825568819,825568819,908997430,758525491,825112117,825112117,925775927,925775927,825372213,841889074,892220465,892220465,942551602,825765426,842214966,842214966,858861104,825110580,908997168,859188786,875638329,825112880,908998964,875966009,892546612,892546612,926363189,926363189))</Histogram>
<Selectivity>0.4082%</Selectivity>
</Property>
<Property name="longitude">
<AverageFieldSize>5.89</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,1,$lb("-10000000000000000000",-88.4977,-69.0601,-61.0242,-14.4524,-2.5853,8.0817,14.9955,20.9394,28.2336,35.2433,46.8691,69.3451,102.4955,127.7669,179.4144),$lb(1,1,2,1,1,0,0,0,1,0,0,0,0,1,1),$lb(758198320,825241648,943205940,943205940,909717040,959328310,825110578,909192752,825503284,825503284,841889080,758263349,942551096,942551096,825503289,825503289,842018361,808335667,942551603,842542642,859123250,859123250,875966008,875966008,909717043,909717043,825242158,808594996,842477111,842477111,926494260,825702702))</Histogram>
<Selectivity>0.4082%</Selectivity>
</Property>
<Property name="name">
<AverageFieldSize>11.86</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" AFGHANISTAN"," BAHRAIN"," BULGARIA"," CONGO [REPUBLIC]"," ESTONIA"," GREECE"," INDIA"," KUWAIT"," MALDIVES"," MOZAMBIQUE"," NORWAY"," RUSSIA"," SLOVAKIA"," SÃO TOMÉ AND PRÍNCIPE"," U.S. VIRGIN ISLANDS"," ZIMBABWE"),$lb(1,2,1,1,1,1,1,1,2,1,1,1,2,1,1),$lb(541148743,1095124808,1111574610,1095258689,1431062337,1112886343,1129270855,1129270855,1163088975,1163088975,1196574021,1196574021,1229866057,1229866057,1263884097,1263884097,1296124996,1095517257,1331315021,1297046081,1313821271,1313821271,1381323603,1381323603,1397509974,1280267841,3276742740,1405308704,1429099310,1429099310,1514753346,542787917))</Histogram>
<Selectivity>0.4082%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-8</BlockCount>
</SQLMap>
<StreamLocation>^dc.data.CountryS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
