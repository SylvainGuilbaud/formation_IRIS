Class data.test Extends (%Persistent, %XML.Adaptor, %JSON.Adaptor, %Populate) [ ClassType = persistent ]
{

Parameter IDPROPERTY = "String";

Property MT As %String;

Property String As %String(MAXLEN = "", POPSPEC = "Mission()");

Property BStream As %Stream.GlobalBinary(POPSPEC = "##class(data.test).BStreamPop()");

Property CStream As %Stream.GlobalCharacter(POPSPEC = "##class(data.test).CStreamPop()");

Property Numeric As %Numeric;

Property Integer As %Integer;

Property Float As %Float;

Property Double As %Double;

Property Date As %Date;

Property Timestamp As %TimeStamp;

Property Boolean As %Boolean;

Property extension As %String [ InitialExpression = "png" ];

Property created As %TimeStamp [ InitialExpression = {$zdt($now(),3,,6)} ];

Property rawString As %RawString;

Index StringIndex On String;

Index BStreamIndex On BStream;

Index CStreamIndex On CStream;

Index NumericIndex On Numeric;

Index IntegerIndex On Integer;

Index FloatIndex On Float;

Index DoubleIndex On Double;

Index DateIndex On Date;

Index TimestampIndex On Timestamp;

Index BooleanIndex On Boolean;

ClassMethod add(filename As %String = "") As %Status
{
    set sc=$$$OK
    Try {
        // default value if filename parameter is null
        set:filename="" filename = $system.Util.DataDirectory()_"docs/copyright.pdf"
        if ##class(%File).Exists(filename) {
            set a = ..%New()
            set a.String = $random(10000) _ $PIECE(filename,"/",*)
            set a.extension = $PIECE(a.String,".",*)
            set file=##class(%Stream.FileBinary).%New()
            set sc=file.LinkToFile(filename)
            do a.BStream.CopyFrom(file)
            do a.CStream.Write("<hello>\0é&&&éooiiàçç?%^$$*```£€$$$@#</hello>")
            set a.Numeric = a.BStream.Size
            set a.Integer = a.BStream.Size
            set a.Float = a.BStream.Size
            set a.Double = a.BStream.Size
            set a.Date = +$H
            set a.Timestamp = $zdt($h,3)
            set a.Boolean = 1
            set sc = a.%Save()
        } else {
            set sc = $system.Status.Error("5001",filename _ " doesn't exist")
        }
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    
    return sc
}

ClassMethod BStreamPop() As %Stream.GlobalBinary
{
    set file=##class(%Stream.FileBinary).%New()
    #; set filename=$system.Util.DataDirectory()_"docs/copyright.pdf"
    #; set filename=$system.Util.DataDirectory()_"docs/images/classroom2.svg"
    set filename="/data/images/iris.png"
	set sc=file.LinkToFile(filename)
    set stream=##class(%Stream.GlobalBinary).%New()
    do stream.CopyFrom(file)
    return stream
}

ClassMethod CStreamPop() As %Stream.GlobalCharacter
{
    set file=##class(%Stream.FileCharacter).%New()
    set filename=$system.Util.InstallDirectory()_"iris.cpf"
	set sc=file.LinkToFile(filename)
    set stream=##class(%Stream.GlobalCharacter).%New()
    do stream.CopyFrom(file)
    return stream
}

ClassMethod extractBinary(id As %Integer, extension As %String = "pdf", directory As %String = "tmp") As %Status
{
    set sc=$$$OK
    if ..%ExistsId(id) {
        set data=..%OpenId(id)
        set directory=##class(%File).NormalizeDirectory($system.Util.DataDirectory()_directory)
        do:'##class(%File).DirectoryExists(directory) ##class(%File).CreateDirectoryChain(directory)
        set filename=directory_id_"_BStream."_extension
        set file=##class(%Stream.FileBinary).%New()
        set sc= file.LinkToFile(filename)
        set sc=file.CopyFrom(data.BStream)
        set sc=file.%Save()
        write:sc filename," successfully extracted (",data.BStream.Size,")",file.Size,!
    } else {
        set sc=$SYSTEM.Status.Error(5001,id_" doesn't exist")
    }
    return sc
}

ClassMethod extractCharacter(id As %Integer, extension As %String = "txt", directory As %String = "tmp") As %Status
{
    set sc=$$$OK
    if ..%ExistsId(id) {
        set data=..%OpenId(id)
        set directory=##class(%File).NormalizeDirectory($system.Util.DataDirectory()_directory)
        do:'##class(%File).DirectoryExists(directory) ##class(%File).CreateDirectoryChain(directory)
        set filename=directory_id_"_CStream."_extension
        set file=##class(%Stream.FileCharacter).%New()
        set sc= file.LinkToFile(filename)
        set sc=file.CopyFrom(data.CStream)
        set sc=file.%Save()
        write:sc filename," successfully extracted (",data.CStream.Size,")",file.Size,!
    } else {
        set sc=$SYSTEM.Status.Error(5001,id_" doesn't exist")
    }
    return sc
}

ClassMethod kill() As %Status
{
    set status = $$$OK
    kill ^data.testD
    kill ^data.testS
    kill ^data.testI("BStreamIndex")
    kill ^data.testI("BooleanIndex")
    kill ^data.testI("CStreamIndex")
    kill ^data.testI("DateIndex")
    kill ^data.testI("DoubleIndex")
    kill ^data.testI("FloatIndex")
    kill ^data.testI("IntegerIndex")
    kill ^data.testI("NumericIndex")
    kill ^data.testI("StringIndex")
    kill ^data.testI("TimestampIndex")

    set status = ..%BuildIndices()

    return status
}

Storage Default
{
<Data name="testDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>String</Value>
</Value>
<Value name="3">
<Value>BStream</Value>
</Value>
<Value name="4">
<Value>CStream</Value>
</Value>
<Value name="5">
<Value>Numeric</Value>
</Value>
<Value name="6">
<Value>Integer</Value>
</Value>
<Value name="7">
<Value>Float</Value>
</Value>
<Value name="8">
<Value>Double</Value>
</Value>
<Value name="9">
<Value>Date</Value>
</Value>
<Value name="10">
<Value>Timestamp</Value>
</Value>
<Value name="11">
<Value>Boolean</Value>
</Value>
<Value name="12">
<Value>extension</Value>
</Value>
<Value name="13">
<Value>created</Value>
</Value>
<Value name="14">
<Value>MT</Value>
</Value>
<Value name="15">
<Value>rawString</Value>
</Value>
</Data>
<DataLocation>^data.testD</DataLocation>
<DefaultData>testDefaultData</DefaultData>
<ExtentSize>16</ExtentSize>
<IdLocation>^data.testD</IdLocation>
<IndexLocation>^data.testI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,16,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000"),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320))</Histogram>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(12,13,14,15,16,19,20,21,22,23,24,25,26,27,28,29),$lb(1,1,1,1,1,0,1,1,1,1,1,1,1,1,1),$lb(825360384,838860800,855638016,855638016,872415232,872415232,889192448,889192448,905969664,905969664,956301312,825819136,842006528,805306368,822083584,822083584,838860800,838860800,855638016,855638016,872415232,872415232,889192448,889192448,905969664,905969664,922746880,922746880,939524096,939524096,956301312,842596352))</Histogram>
<Selectivity>1</Selectivity>
</Property>
<Property name="BStream">
<Histogram>$lb(.06666666666666666667,1,6,$lb(-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,0,0,0,0,0,0,0,0,0,0),$lb(21,21,21,21,21,0,1,1,1,1,1,1,1,1,1),$lb(758198320,0,0,0,0,0,0,0,0,0,0,758198320,805306368,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,805306368))</Histogram>
<OutlierSelectivity>.375:</OutlierSelectivity>
<Selectivity>6.2500%</Selectivity>
</Property>
<Property name="Boolean">
<AverageFieldSize>2.38</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,6,$lb(-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,0,0,0,0,1,1,1,1,1,1),$lb(21,21,21,21,21,0,1,1,1,0,1,1,1,1,1),$lb(758198320,0,0,0,0,0,0,0,0,0,0,758198320,805306368,0,0,0,0,0,0,805306368,822083584,0,0,0,0,0,0,0,0,0,0,822083584))</Histogram>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="CStream">
<Histogram>$lb(.06666666666666666667,1,6,$lb(-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,0,0,0,0,0,0,0,0,0,0),$lb(21,21,21,21,21,0,1,1,1,1,1,1,1,1,1),$lb(758198320,0,0,0,0,0,0,0,0,0,0,758198320,805306368,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,805306368))</Histogram>
<OutlierSelectivity>.375:</OutlierSelectivity>
<Selectivity>6.2500%</Selectivity>
</Property>
<Property name="Date">
<AverageFieldSize>3.25</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,6,$lb(-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,31228,31608,34044,34371,37266,37878,42307,50802,55123,57835),$lb(21,21,21,21,21,0,2,1,2,1,2,0,0,1,1),$lb(758198320,0,0,0,0,0,0,0,0,0,0,758198320,858862130,842151936,909129728,825634872,875574324,808727552,859255040,875771697,926037558,842413568,943142912,859256887,875705136,875705136,892352560,808988722,892416563,892416563,926430005,892811315))</Histogram>
<OutlierSelectivity>.375:</OutlierSelectivity>
<Selectivity>6.2500%</Selectivity>
</Property>
<Property name="Double">
<AverageFieldSize>7</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,6,$lb(-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,$double(578),$double(590),$double(951),$double(998),$double(1146),$double(2559),$double(3024),$double(3194),$double(8983),$double(9932)),$lb(21,21,21,21,21,0,9,8,9,8,8,8,9,8,8),$lb(758198320,0,0,0,0,0,0,0,0,0,0,758198320,892811264,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,960049970))</Histogram>
<OutlierSelectivity>.375:</OutlierSelectivity>
<Selectivity>6.2500%</Selectivity>
</Property>
<Property name="Float">
<AverageFieldSize>3.25</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,6,$lb(-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,730,944,1400,2092,2199,2924,3883,5644,5718,9695),$lb(21,21,21,21,21,0,0,0,0,1,1,0,0,1,0),$lb(758198320,0,0,0,0,0,0,0,0,0,0,758198320,926101504,926101504,959722496,959722496,825503792,825503792,842021170,809054720,825833728,825833728,959591424,842609204,859322419,859322419,892744756,909390848,925972480,892809528,959854901,959854901))</Histogram>
<OutlierSelectivity>.375:</OutlierSelectivity>
<Selectivity>6.2500%</Selectivity>
</Property>
<Property name="Integer">
<AverageFieldSize>4.5</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,6,$lb(-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,150553924,169306676,236042246,246956065,468503186,496616922,508805363,632878490,650720338,788174552),$lb(21,21,21,21,21,0,1,0,1,0,1,0,0,1,0),$lb(758198320,0,0,0,0,0,0,0,0,0,0,758198320,825569333,892351797,909718320,825637171,842217008,859189300,875968821,842282553,875968565,909653296,959854129,876164662,892352568,892352568,909324856,858929207,892352306,909455415,926431281,926431281))</Histogram>
<OutlierSelectivity>.375:</OutlierSelectivity>
<Selectivity>6.2500%</Selectivity>
</Property>
<Property name="MT">
<AverageFieldSize>6.44</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" A787"," AAAA"," AAAA"," AAAA"," AAAA"," AAAA"," BAAA"," E1544"," F905"," G9977"," J7950"," R9191"," T7377"," W8004"," X9227"," Z818"),$lb(2,6,6,6,6,1,1,1,1,1,1,1,1,1,1),$lb(541144888,926430976,1094795520,0,0,0,0,0,0,0,0,1094795585,1111572801,1111572801,1160852788,1160852788,1178153013,1178153013,1194932535,1194932535,1245133109,1245133109,1379479865,1379479865,1412903735,1412903735,1463300144,1463300144,1480143410,1480143410,1513632056,542783537))</Histogram>
<Selectivity>8.3333%</Selectivity>
</Property>
<Property name="Numeric">
<AverageFieldSize>4.44</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,6,$lb(-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,185.81,783.49,1267.01,1653.7,2660.28,5541.48,5632.43,6970.38,7867.32,9590.76),$lb(21,21,21,21,21,0,0,0,1,0,0,1,0,0,0),$lb(758198320,0,0,0,0,0,0,0,0,0,0,758198320,825767214,825767214,926429998,926429998,825374263,842413870,909456174,825636147,842413616,842413616,892679217,892612910,909324846,892744498,909719344,909719344,926430775,926430775,959789360,959789360))</Histogram>
<OutlierSelectivity>.375:</OutlierSelectivity>
<Selectivity>6.2500%</Selectivity>
</Property>
<Property name="String">
<AverageFieldSize>56.31</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," "," "," "," "," DEVELOPERS OF HIGH-TOUCH SECURE DATA WAREHOUSE GAMING FOR SOCIAL NETWORKS."," ENABLING INDIVIDUALS AND BUSINESSES TO MANAGE COMPLEX GENETIC ADVANCED MEDIA FOR THE FORTUNE 5."," EXPERTS IN INNOVATIVE QUANTUM DEVICES AND PRODUCTIVITY TOOLS FOR DISCRIMINATING INVESTORS."," EXPERTS IN NON-LINEAR FINANCIAL DEVICES AND MODELS FOR THE PHARMACEUTICAL INDUSTRY."," EXPERTS IN VIRTUAL OPTICAL GRAPHICAL APPS FOR MOBILE DEVICES."," LEADERS IN OPEN-SOURCE FINANCIAL DATA WAREHOUSE SERVICES FOR ON-LINE COMMERCE."," RESELLERS OF INNOVATIVE SEVEN-SIGMA GRAPHICAL CONTENT FOR THE FORTUNE 5."," SPECIALIZING IN THE DEVELOPMENT AND MANUFACTURING OF WORLD-CLASS WIRELESS PLATFORMS FOR MIDDLE-WARE FOR DISCRIMINATING "," THE INDUSTRY LEADER IN INTERACTIVE INSTRUMENTATION INSTRUMENTS FOR THE ENTERTAINMENT INDUSTRY."," THE INDUSTRY LEADER IN VIRTUAL GENETIC GRAPHICAL CONNECTIVITY FOR THE ENTERTAINMENT INDUSTRY."),$lb(2,2,2,2,2,1,1,2,12,12,1,1,1,1,24),$lb(536870912,0,0,0,0,0,0,0,0,0,0,0,1145394757,1145394757,1162756418,1312899660,1481655634,1229868623,1313820205,1313820205,1447645780,1163415621,1279607108,1279607108,1380275013,1380275013,1397769539,1397769539,1414022432,1229870149,1447645780,542394437))</Histogram>
<OutlierSelectivity>.375:</OutlierSelectivity>
<Selectivity>6.2500%</Selectivity>
</Property>
<Property name="Timestamp">
<AverageFieldSize>13.88</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,6,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","1937-10-10 00:12:06","1945-01-06 19:57:49","1953-05-11 03:26:32","1961-10-10 17:02:52","1966-02-18 10:56:05","1972-07-13 14:06:57","1983-10-29 00:09:39","2001-02-27 18:16:07","2015-02-19 19:29:55","2016-08-23 20:14:06"),$lb(21,21,21,21,21,0,2,2,2,3,2,2,0,2,3),$lb(758198320,0,0,0,0,0,0,0,0,0,0,758198320,825832247,859254065,875900208,875900208,892546352,892546352,909192497,825045296,908931122,909520176,926035248,926035248,942878001,825833523,842018865,808529200,825568560,892153906,908931128,842019126))</Histogram>
<OutlierSelectivity>.375:</OutlierSelectivity>
<Selectivity>6.2500%</Selectivity>
</Property>
<Property name="created">
<AverageFieldSize>27.94</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb("2024-04-25 13:30:15.642997","2024-04-25 13:30:16.372492","2024-04-25 13:30:17.823155","2024-04-25 13:30:18.532583","2024-04-25 13:30:19.23084","2024-04-25 13:32:52.264508","2024-04-25 13:37:23.981167","2024-04-25 13:37:23.999436","2024-04-25 13:37:24.004319","2024-04-25 13:37:24.006987","2024-04-25 13:37:24.009793","2024-04-25 13:37:24.014097","2024-04-25 13:37:24.016904","2024-04-25 13:37:24.021078","2024-04-25 13:37:24.024736","2024-04-25 13:37:24.028518"),$lb(18,18,18,18,15,15,21,18,22,22,21,22,21,22,22),$lb(842019380,892220980,908997431,908997431,925775922,925775922,942552371,942552371,959328819,809120057,842675506,842675506,926560819,942747958,960050227,858667321,875442224,875770169,909719607,909719607,959920435,809056057,825503801,875575607,909717556,825637168,842084407,825243448,876032822,876032822,943010104,842019380))</Histogram>
<Selectivity>6.2500%</Selectivity>
</Property>
<Property name="extension">
<AverageFieldSize>5</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" SVG"," SVG"," SVG"," SVG"," SVG"," SVG"," SVG"," SVG"," SVG"," SVG"," SVG"," SVG"," SVG"," SVG"," SVG"," SVG"),$lb(5,5,5,5,5,5,5,5,5,5,5,5,5,5,5),$lb(542332487,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,542332487))</Histogram>
<OutlierSelectivity>.999999:"svg"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="rawString">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,16,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000"),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320))</Histogram>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<SQLMap name="BStreamIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="BooleanIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="CStreamIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="DateIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="DoubleIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="FloatIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IntegerIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="NumericIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="StringIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="TimestampIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^data.testS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
