/* Copyright (c) 2022 by InterSystems Corporation.
   Cambridge, Massachusetts, U.S.A.  All rights reserved.
   Confidential property of InterSystems Corporation. */

/// <p><b>For details on using this class</b>, see
/// <a target="_top" href="/csp/docbook/Doc.View.cls?FIND=CLASSES+%25Library.Populate">Using the Populate Utility</a>.</p>
/// The <CLASS>%PopulateUtils</CLASS> class contains a number of utility methods used by the 
/// <CLASS>%Populate</CLASS> class.
Class %Library.PopulateUtils [ Not ProcedureBlock, System = 2 ]
{

/// Return a random array element.
ClassMethod ArrayElement(ByRef array) As %String
{
 QUIT $s($g(array):$g(array($$$PRand(array)+1)),1:"")
}

/// Return a random value from a concrete value extent.
ClassMethod ExtentValue(cptr As %Integer, cext As %Integer) As %String
{
 QUIT $s($g(^IRIS.Temp(cptr,cext)):$g(^IRIS.Temp(cptr,cext,$$$PRand(^IRIS.Temp(cptr,cext))+1)),1:"")
}

/// 	Return an array of ids selected randomly from the 
/// 	Extent query of the class in the <var>sample</var> parameter. The array is of the form: 
/// 	sample=n 
/// 	sample(1)=id1,sample(2)=id2,...,sample(n)=idn 
/// 	Parameters: 
/// 	class   - the class to retrieve samples from 
/// 	sample  - the array of samples (returned) 
/// 	size    - the maximum number of samples to retrieve 
/// 	selpct  - the percentage of instances to be randomly selected. 
/// 	for example, 25 means approximately 25% of the instances 
/// 	will be selected (1 in 4).
ClassMethod BuildReferenceSample(class, sample, size = 500, selpct = 25)
{
 New count,density,rs,sc
 Set density=$s(selpct>90:2,selpct>74:4,selpct>49:6,selpct>39:5,selpct>24:36,selpct>12:7,1:29)
 Kill sample
 Set sample=0
 QUIT:$g(class)=""
 Set rs=##class(%ResultSet).%New(class_":Extent")
 QUIT:('$isobject(rs)) ##; The "Extent" query doesn't exist so we cannot populate sample
 Set sc=rs.Execute()
 If $$$ISERR(sc) Set rs="""" QUIT
 For count=1:1 Quit:rs.Next()=0  i '(density#($$$PRand(density)+1)) s sample=sample+1,sample(sample)=rs.GetData(1) Quit:sample=size
 #; If the sample is less than 50% of requested size then select all of the instances...
 If (sample/size)<.5,count>sample DO
 . Do rs.Close()
 . Set sc=rs.Execute()
 . Quit:$$$ISERR(sc)
 . Kill sample
 . Set sample=0
 . For  Quit:rs.Next()=0  s sample=sample+1,sample(sample)=rs.GetData(1) Quit:sample=size
 QUIT
}

/// Populate a value set from a query
ClassMethod BuildValueSetSQL(cptr, cext, table, column, size = 500, verbose As %Integer = 0) As %Status [ ProcedureBlock = 1 ]
{
	If ('$Get(cptr)) || ('$Get(cext)) || ( table = "" ) || ( column = "" ) Quit $$$ERROR($$$GeneralError,"Invalid BuildValueSet parameters")
	Set sql = "select DISTINCT(" _ $Select($$$ucase(column)'["%EXACT":"%EXACT("_column_")",1:column) _ ") from " _ table
	Set rs = ##class(%Library.ResultSet).%New()
	Set sc = rs.Prepare(sql)
	If $$$ISERR(sc) Quit $$$ERROR($$$GeneralError,"Cannot prepare BuildValueSetSQL dynamic query: " _ $Get(%msg))
	Set sc=rs.Execute()
	If $$$ISERR(sc) Quit $$$ERROR($$$GeneralError,"Cannot execute BuildValueSetSQL dynamic query: " _ $Get(%msg))
	Set temp = $Increment(^IRIS.Temp)
	$$$AddTempNode(^IRIS.Temp(temp))
	Set ^IRIS.Temp(temp) = 0
	If verbose { Write !,sql }
	Set next = rs.Next()
	While next {
		Set ^IRIS.Temp(temp,$Increment(^IRIS.Temp(temp))) = rs.GetData(1)
		If verbose && ('(^IRIS.Temp(temp)#1000)) { Write "." }
		Set next = rs.Next()
	}
	Set sc = rs.Close()
	If verbose { Write "(",^IRIS.Temp(temp),")" }
	Set ^IRIS.Temp(cptr,cext) = 0, cextcnt = 0, domainsize = ^IRIS.Temp(temp)
	If size '< domainsize {
		If verbose { Write !," requested number is greater than domain size, taking all values." }
		Merge ^IRIS.Temp(cptr,cext) = ^IRIS.Temp(temp)
	}
	Else {
		If verbose { Write !,"Selecting ",size," random values" }
		While cextcnt < size {
			Set valptr = $$$PRand(domainsize) + 1
			If '$d(^IRIS.Temp(cptr,cext,"u",valptr)) {
				Set val = ^IRIS.Temp(temp,valptr)
				Set cextcnt = $Increment(^IRIS.Temp(cptr,cext)), ^IRIS.Temp(cptr,cext,"u",valptr) = cextcnt, ^IRIS.Temp(cptr,cext,cextcnt) = val
				If verbose && ('(cextcnt#1000)) { Write "." }
			}
		}
		Kill ^IRIS.Temp(cptr,cext,"u")
	}
	Kill ^IRIS.Temp(temp)
	$$$RemoveTempNode(^IRIS.Temp(temp))
	QUIT $$$OK
}

/// Return a random city name.
ClassMethod City() As %String
{
 n t1
 s t1=$lb("Albany","Boston","Bensonhurst","Chicago","Denver","Elmhurst","Fargo","Gansevoort","Hialeah","Islip","Jackson","Larchmont","Miami","Newton","Oak Creek","Pueblo","Queensbury","Reston","St Louis","Tampa","Ukiah","Vail","Washington","Xavier","Youngstown","Zanesville")
 Quit $li(t1,$$$PRand($ll(t1))+1)
}

/// Return a random company name.
ClassMethod Company() As %String
{
 New c1,c2,c3

 Set c1=$LB("Compu","Dyna","Quanta","Hyper","Meta","Kwal","Opti","Robo","Tera","Mega","Giga","Xena","Micro","Macro","Inter","Yoyo","Medi","Pico","Accu","Globa","Octo","Cyber","Tele","Syner","Securi","Bio","Intra")
 Set c2=$LB("Dyne","Sys","Tron","Matix","mo","gy","Sonics","Calc","Tel","Soft","Dynamics","Pedia","Systems","Net","Data","Ware","Glomerate","Lateral","Tech","Plex","Comp")
 Set c3=$LB(" Inc."," Corp."," Media Inc."," Holdings Inc.",".com"," LLC."," Group Ltd."," Associates"," Partners"," Gmbh.")

 Quit $LI(c1,$$$PRand($LL(c1))+1)_$LI(c2,$$$PRand($LL(c2))+1)_$LI(c3,$$$PRand($LL(c3))+1)
}

/// Return a random currency value between <var>min</var> and <var>max</var> (if present).
ClassMethod Currency(min As %Integer = 0, max As %Integer = 10000) As %Integer
{
 Quit ##class(%PopulateUtils).Float(min,max,4)
}

/// Return a random date value in InterSystems IRIS <code>$H</code> format.
ClassMethod Date(min As %Date, max As %Integer) As %Date
{
	if '$Get(min) { set min = 30000 }
	if '$Get(max) { set max = +$h }
	if min>max Quit 0
	quit min+$$$PRand(max-min+1)
}

ClassMethod CDate(format As %Integer = 1, min As %Date = 30000, max As %Date = 55000) As %String
{
 If min>max Quit 0
 Quit $zdate(##class(%Library.PopulateUtils).Date(min,max),format)
}

ClassMethod Counter(counter As %String = "c", initial As %Integer = 1) As %String
{
 If '$Data(^||%Populate("c",counter)) Set ^||%Populate("c",counter) = initial Quit initial
 Quit $Increment(^||%Populate("c",counter))
}

/// Return a string containing a random first name.
/// <p><var>gender</var> is a optional string used to control the 
/// gender of the generated name: 1 is Male, 2 = Female, "" is either.
ClassMethod FirstName(gender As %String = "") As %String
{
 New list
 #; gender is 1:MALE,2:FEMALE
 s:$g(gender)="" gender=$$$PRand(2)+1

 If (gender = 1) {
 Set list = $LB("Al","Alfred","Alvin","Andrew","Angelo","Aviel",
 "Bart","Bill","Bob","Brendan","Brian","Buzz","Chad",
 "Charles","Chris","Clint","Dan","Dave",
 "David","Dick","Dmitry","Ed","Edgar","Edward",
 "Elmo","Elvis","Emilio","Fred","Geoffrey",
 "George","Howard","James","Jeff","Joe","John",
 "Jose","Joshua","Jules","Keith","Kenny","Kevin",
 "Lawrence","Mark","Mario","Martin","Marvin","Michael","Milhouse",
 "Mo","Neil","Norbert","Orson","Patrick","Paul",
 "Peter","Phil","Quentin","Quigley","Ralph",
 "Richard","Rob","Robert","Roger","Sam","Stavros",
 "Stuart","Ted","Terry","Umberto","Vincent",
 "Will","William","Wolfgang","Xavier","Zeke")
 }
 Else {
 Set list = $lb("Agnes","Alexandra","Alice","Amanda","Angela","Ashley",
 "Barb","Barbara","Belinda","Brenda",
 "Charlotte","Chelsea","Christine","Christen",
 "Danielle","Debra","Debby","Diane","Elvira","Emily","Emma",
 "Filomena","Frances","Gertrude","Greta","Hannah","Heloisa","Imelda",
 "Jane","Janice","Jocelyn","Josephine","Juanita","Julie",
 "Kim","Kirsten","Kristen","Kyra","Laura",
 "Linda","Lisa","Liza","Lola","Lydia",
 "Maria","Mary","Maureen","Michelle","Molly",
 "Nataliya","Natasha","Nellie",
 "Olga","Pam","Pat","Patricia","Phyllis",
 "Rhonda","Roberta","Sally","Samantha","Sophia","Susan",
 "Tara","Terry","Thelma",
 "Uma","Usha","Valery","Violet","Wilma","Yan","Zelda","Zoe")
 }

 Quit $LI(list,$$$PRand($LL(list))+1)
}

/// Return a random floating point value between <var>min</var> 
/// and <var>max</var> (if present).
ClassMethod Float(min As %Float = 0, max As %Float = 10000, scale As %Integer = 0) As %Integer [ ProcedureBlock = 1 ]
{
	If max '> min { Quit "" }
	If scale > 17 { Set scale = 17 }
	Set factor = 10 ** scale
		#; Normalize min and max
	Set minn = (min*factor\1)/factor, maxn = (max*factor\1)/factor
	Set range = maxn - minn
		#; smaller values are simpler
	If ($Length(range\1) + scale) < 17 { Quit +(((minn * factor) + $$$PRand(range * factor + 1)) / factor) }
		#; generate large values as two separate random values
		#; This algorithm slightly favors min and max in some cases but allows for floats with large scale values
		#; first, make sure that range and factor don't trigger a function error.
	set range = $Extract(range,1,17), factor = $Extract(factor,1,17)
	Set float = minn + $$$PRand(range) + $Select(scale:+($$$PRand(factor+1)/factor),1:0)
	Quit $Select((float<max)&(float>min):float,float'<max:maxn,1:minn)
}

/// Return a random integer value between <var>min</var> 
/// and <var>max</var> (if present).
ClassMethod Integer(min As %Integer = 0, max As %Integer = 1000000000) As %Integer [ ProcedureBlock = 1 ]
{
	if min > max quit 0
	set range = max - min + 1
	if range '> 1E17 { quit min+$$$PRand(range) }
	set range1 = $$$PRand(1E17)
	set range2 = $$$PRand(range\1E17)
	quit min + (range2*1E17) + range1
}

/// Return a string containing a random last name.
ClassMethod LastName() As %String
{
 New list,x
 Set x = $$$PRand(26)+1

 If (x = 1) 	{ Set list = $LB("Allen","Avery","Adam","Adams","Alton","Ahmed","Anderson") }
 ElseIf (x = 2)	{ Set list = $LB("Baker","Beatty","Burroughs","Bach","Bachman","Black","Brown","Browne","Browning","Braam","Basile","Bukowski","Bush") }
 ElseIf (x = 3)	{ Set list = $LB("Chadbourne","Cheng","Chang","Campos","Cannon","Chadwick","Chesire","Clinton","Clay","Connors","Cooke","Cooper","Cerri","Cunningham") }
 ElseIf (x = 4)	{ Set list = $LB("Diavolo","DeSantis","Djakovic","DeLillo","Drabek","Donaldson","Davis","Dunlap","Duquesnoy") }
 ElseIf (x = 5)	{ Set list = $LB("Evans","Edwards","Eisenstien","Edison","Emerson","Eno","Eastman","Eagleman") }
 ElseIf (x = 6)	{ Set list = $LB("Frith","Fripp","Finn","Faust","Fives","Frost","Feynman") }
 ElseIf (x = 7)	{ Set list = $LB("Gaboriault","Geoffrion","Gomez","Gallant","Goldman","Gore","Gibbs","Gold","Goncharuk","Grabscheid","Garcia") }
 ElseIf (x = 8)	{ Set list = $LB("Houseman","Huff","Hanson","Harrison","Hills","Hertz","Hammel","Humby","Hernandez") }
 ElseIf (x = 9)	{ Set list = $LB("Isaksen","Ironhorse","Ipsen","Ingrahm","Ingersol","Iacobelli","Ingleman","Isaacs","Ihringer") }
 ElseIf (x = 10)	{ Set list = $LB("Jafari","Joyce","Jackson","Jones","Johnson","Jaynes","Jung","Jenkins") }
 ElseIf (x = 11)	{ Set list = $LB("Koivu","Kovalev","King","Klingman","Kelvin","Klein","Klausner","Kratzmann","Koenig") }
 ElseIf (x = 12)	{ Set list = $LB("Larson","Leiberman","Lennon","Lepon","Levinson","Long","LaRocca","Lee","Li","Lubbar","Love","Loveluck","Lopez") }
 ElseIf (x = 13)	{ Set list = $LB("Mara","Massias","Malkovich","Moon","Murphy","Murray","McCormick","Macrakis","Mailer","Munt","Martinez","Mastrolito","Minichillo","Monroe","Malynko","Miller","Marks","McCoy") }
 ElseIf (x = 14)	{ Set list = $LB("Noodleman","Novello","Nagel","Nathanson","Newton","Nelson","North","Ng","Nichols") }
 ElseIf (x = 15)	{ Set list = $LB("O'Donnell","O'Brien","O'Rielly","Orwell","Orlin","Ott","Olsen") }
 ElseIf (x = 16)	{ Set list = $LB("Page","Paladino","Palmer","Pantaleo","Pape","Paraskiv","Pascal","Perez","Peters","Peterson","Petersburg","Pybus","Presley","Press") }
 ElseIf (x = 17)	{ Set list = $LB("Quigley","Quilty","Quince","Quincy","Quine","Quixote") }
 ElseIf (x = 18)	{ Set list = $LB("Ramsay","Ragon","Ravazzolo","Rogers","Rotterman","Roentgen","Rodriguez","Russell") }
 ElseIf (x = 19)	{ Set list = $LB("Smith","Smyth","Schultz","Schulte","Salm","Sato","Schaefer","Simpson","Sands","Solomon","Semmens","Sorenson","Sverdlov") }
 ElseIf (x = 20)	{ Set list = $LB("Tesla","Tsatsulin","Tweed","Thompson","Taylor","Tillem","Townsend") }
 ElseIf (x = 21)	{ Set list = $LB("Ubertini","Uhles","Ueckert","Umansky","Uberoth","Ulman","Underman") }
 ElseIf (x = 22)	{ Set list = $LB("Van De Griek","Vanzetti","Vivaldi","Vonnegut") }
 ElseIf (x = 23)	{ Set list = $LB("Waal","Walker","Wilson","Woo","Wells","Waters","Willeke","Wijnschenk","Waterman","Winters","White","Williams","West") }
 ElseIf (x = 24)	{ Set list = $LB("Xander","Xavier","Ximines","Xerxes","Xenia","Xiang") }
 ElseIf (x = 25)	{ Set list = $LB("Young","Yeats","Yang","Yu","Yancik","Yakulis","Yezek","Yoders") }
 ElseIf (x = 26)	{ Set list = $LB("Zemaitis","Zubik","Zimmerman","Zevon","Zucherro","Zampitello","Zweifelhofer") }

 Quit $LI(list,$$$PRand($LL(list))+1)
}

/// Returns a string containing a randomly generated corporate mission statement.
ClassMethod Mission() As %String
{
 New c1,c2,c3,c4,c5,c6
 Set c1=$LB("Leaders in ","Developers of ","Providers of ","Resellers of ","On-line distributors of ","Experts in ","Specializing in the development and manufacturing of ","Post-sale services for ","Spearheading the next generation of ","The industry leader in ","Enabling individuals and businesses to manage ","Building shareholder value by delivering ")
 Set c2=$LB("","advanced ","cutting-edge ","breakthrough ","complex ","high-performance ","scalable ","just-in-time ","open ","personal ","high-tech ","high-touch ","open-source ","virtual ","interactive ","eco-friendly ","agile ","cloud-based ","premise-based ","sustainable ","intelligent ","innovative ","world-class ","knowledge-based ","compliant ","secure ","standards-based ","disruptive ","non-linear ","dynamic ","enhanced ","real-time ","synergistic ")
 Set c3=$LB("","quantum ","nano-","hyper-","optical ","financial ","multi-media ","object-oriented ","broad-band ","secure ","digital ","enterprise ","crowd-sourced ","genetic ","wireless ","satellite-based ","ISO 9003-ready ","Web 3.0 ","HTML5 ","post-Microsoft ","natural language ","big data ","predictive analytic ","seven-sigma ","distributed ","massively-parallel ","mission-critical ")
 Set c4=$LB("","devices and ","instrumentation ","graphical ","XML ","Internet ","application development ","database ","data warehouse ","forecasting ","voice-enabled ","cold-fusion powered ","platforms for ","advanced ","virtualized ")
 Set c5=$LB("services ","technologies ","media ","content ","middle-ware ","connectivity ","consulting services ","gaming ","models ","productivity tools ","instruments ","marketing services ","apps ")
 Set c6=$LB("for on-line commerce.","for the Financial community.","for discriminating investors.","for the Entertainment industry.","for consumers.","for the Fortune 5.","for the Fortune 50.","for the Fortune 500.","for the Fortune 5000.","for the enterprise.","for the desktop.","for the Health Care community.","for mobile devices.","for social networks.","for industry and government.","for emerging markets.","for industry and academia.","for capital markets.","for high-worth individuals.","for our long-term clients.","for the pharmaceutical industry.","for additive manufacturing.")
 Quit $LI(c1,$$$PRand($LL(c1))+1)_$LI(c2,$$$PRand($LL(c2))+1)_$LI(c3,$$$PRand($LL(c3))+1)_$LI(c4,$$$PRand($LL(c4))+1)_$LI(c5,$$$PRand($LL(c5))+1)_$LI(c6,$$$PRand($LL(c6))+1)
}

/// Return a string containing a random name as <i>lastname,firstname</i>.
/// <p><var>gender</var> is a optional string used to control the 
/// gender of the generated name: 1 is Male, 2 = Female, "" is either.
ClassMethod Name(gender As %String = "") As %String
{
 Quit ..LastName()_","_..FirstName($g(gender))_" "_$C($$$PRand(26)+65)_"."
}

/// Return a random U.S. Social Security Number.
ClassMethod SSN() As %String [ CodeMode = expression ]
{
($$$PRand(899)+100)_"-"_($$$PRand(89)+10)_"-"_($$$PRand(8999)+1000)
}

/// Return a string value of the form <random character>_<random number less than 9999> and whose length
/// does not exceed <var>len</var>.
ClassMethod String(len As %Integer = 1) As %String
{
 QUIT $e($c($$$PRand(26)+65)_$$$PRand(9999),1,$s(len>0:len,1:1))
}

/// Return a random string value whose length is at least <var>minlen</var> and not greater than <var>maxlen</var>.
ClassMethod StringMin(minlen As %Integer = 1, maxlen As %Integer = 1) As %String [ ProcedureBlock = 1 ]
{
	if maxlen '< minlen { set len=$$$PRand(maxlen-minlen+1)+minlen, string="" for i=1:1:len { Set charn=$s($$$PRand(2):$$$PRand(26)+65,1:$$$PRand(26)+97),string=string_$s(charn<123:$c(charn),1:" ") } quit string } else { quit "" }
}

/// Return a random street address.
ClassMethod Street() As %String
{
 n t1,t2
 s t1=$lb("Maple","Ash","Elm","Oak","Main","First","Second","Washington","Franklin","Clinton","Madison"), t2=$lb("Street","Avenue","Blvd","Court","Place","Drive")
 Quit ($$$PRand(9999)+1)_" "_$li(t1,$$$PRand($ll(t1))+1)_" "_$li(t2,$$$PRand($ll(t2))+1)
}

/// 	Return a string of random syllables and spaces. 
/// 	The algorithm uses several syllable 'lists'. First, a list is randomly 
/// 	chosen. Then a syllable from that list is chosen and added to the string. 
/// 	Then, if a random boolean is TRUE, a space is appended. Syllables are added to the 
/// 	string until the string length exceeds a random length less than or equal 
/// 	to the parameter maxlen.
ClassMethod Syllable(maxlen As %Integer = 30) As %String
{
 New len,p,s,string
 Set len=$$$PRand(maxlen)+1
 Set s(1)=$lb("A","I","Am","An","Iso","Ic")
 Set s(2)=$lb("Lo","Ly","Re","Co","To","On","Op")
 Set s(3)=$lb("Com","Syn","Tri","Uni","Via","Geo","Ism","Ion","Ies","Two","Pus","Tech","Quo")
 Set s(4)=$lb("Able","Cycle","Atic","Look","Mili","Nano","Octo","Pyro","Status","Kilo","Dyna","Endo","Ecto","Gyro","Heli","Atic","Able","Look","Much","Graph","Gram","Wave","Sound","Plasm","Physical","Scope","Copter","Morph","Range","Pede","Second","Zeno","Photo","Type","Much","Invent","Thetic")
 Set string=""
 For  q:$l(string)>len  s p=$$$PRand(4)+1 s string=string_$li(s(p),$$$PRand($ll(s(p)))+1) s:$$$PRand(2) string=string_" "
 Quit $extract(string,1,len)
}

/// 	Return a random %PosixTime value that is between the specified <var>min</var> and <var>max</var> %PosixTime values. 
/// 	If either <var>min</var> or <var>max</var> is not a valid %PosixTime value, then the default value is used instead.
///     The default <var>min</var> value is -6919738016441081856 (1900-01-01 00:00:00)
///     The default <var>max</var> value is the current timestamp value
ClassMethod PosixTime(min As %PosixTime = "", max As %PosixTime = "") As %PosixTime [ ProcedureBlock = 1 ]
{
		// If min/max is specified, not the dfault 0001-01-01 00:00:00, and a valid %PosixTime value, convert them to UnixTime
	if min'="" && (min'=-6979664624441081856) && ($zu(1073741926,+min)) { set min=$zu(1073741925,+min) } else { set min=-2208988800 }	// 1900-01-01 00:00:00 is default min value
		// The datatypes default maxval is 9999-12-31 23:59:59.999999.  If the property does not override that, just use today as the max
	if max'="" && (max'=1406323805406846975) && ($zu(1073741926,+max)) { set max=$zu(1073741925,+max) } else { set max=$zu(188),max=(max-47117)*86400+$p(max,",",2) }
		// min/max are now in UnitTime
	set precmin=$l($p(min,".",2)),precmax=$l($p(max,".",2))
	set prec=precmin set:precmax>precmin prec=precmax
	set range=max-min+1
	set value=$$$PRand(range)
	set:prec value=+(value_"."_$$$PRand(10**prec))
	Quit $zu(1073741924,value+min)
}

/// 	Return a random TimeStamp value that is between the specified <var>min</var> and <var>max</var> timestamp values. 
/// 	The default <var>min</var> value is the default <method>Date</method> min date value with time = 0. 
/// The default <var>max</var> value is the default <method>Date</method> max date value with time = 86399 (23:59:59). 
/// 	If either <var>min</var> or <var>max</var> is not a valid %TimeStamp value, then the default value is used instead.
ClassMethod TimeStamp(min As %TimeStamp, max As %TimeStamp) As %String [ ProcedureBlock = 1 ]
{
	try {
		if $Get(min) '= "" { set minh = $zdth(min,3) set mindateh = $Piece(minh,",",1), mintimeh = $Piece(minh,",",2) } else { set mindateh = "", mintimeh = 0 }
		if $Get(max) '= "" { set maxh = $zdth(max,3) set maxdateh = $Piece(maxh,",",1), maxtimeh = $Piece(maxh,",",2) } else { set maxdateh = "", maxtimeh = 86399 }
	}
	catch tException { set mindateh = "", mintimeh = 0, maxdateh = "", maxtimeh = 86399 }
	Set date=##class(%PopulateUtils).Date(mindateh,maxdateh)
	Set time=##class(%PopulateUtils).Integer(mintimeh,maxtimeh)
	Quit $zd(date,3)_" "_$zt(time,1)
}

/// Return a random job title.
ClassMethod Title() As %String
{
 New t1,t2

 Set t1=$LB("","Senior ","Associate ","Assistant ","Strategic ","Global ","Laboratory ","Executive ")
 Set t2=$LB("Engineer","Sales Rep.","Support Engineer","Developer","Marketing Manager","Accounts Rep.","Resources Director","Director","Product Manager","Research Asst.","Systems Engineer","Technician","WebMaster","Administrator","Product Specialist","Accountant","Hygienist")

 Quit $LI(t1,$$$PRand($LL(t1))+1)_$LI(t2,$$$PRand($LL(t2))+1)
}

/// Return a random U.S. phone number.
ClassMethod USPhone() As %String [ CodeMode = expression ]
{
($$$PRand(799)+200)_"-"_($$$PRand(799)+200)_"-"_($$$PRand(8999)+1000)
}

/// Return a random U.S. state abbreviation.
ClassMethod USState() As %String
{
 n t1
 s t1=$lb("AK","AL","AR","AZ","CA","CO","CT","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WI","WV","WY")
 Quit $li(t1,$$$PRand($ll(t1))+1)
}

/// Return a random U.S. Zone Improvement Plan (ZIP) code.
ClassMethod USZip() As %String [ CodeMode = expression ]
{
($$$PRand(89999)+10000)
}

/// Return a random piece from a delimited list. The first character in the list is the delimiter.
ClassMethod ValueList(vallist) As %String
{
 New del
 Set del=$e(vallist,1)
 Quit $piece(vallist,del,$$$PRand($length(vallist,del)-1)+2)
}

/// Return a random string value of random length 
/// up to <var>maxlen</var> characters.
ClassMethod VarString(maxlen As %Integer = 1) As %String
{
 n i,len,string
 s:'$g(maxlen) maxlen=1
 s len=$$$PRand(maxlen)+1
 s string=""
 For i=1:1:len Set string=string_$c($$$PRand(64)+32)
 QUIT string
}

/// Return a random color name (one of 5 possible values).
ClassMethod Color() As %String
{
 n t1
 s t1=$lb("Red","Green","Blue","Yellow","Black")
 Quit $li(t1,$$$PRand($ll(t1))+1)
}

/// Return a random product name (one of 4 possible values).
ClassMethod Product() As %String
{
 n t1
 s t1=$lb("Table","Chair","Lamp","Desk")
 Quit $li(t1,$$$PRand($ll(t1))+1)
}

/// Return a random number from 0-<var>n</var> using a random number generator that is
/// seeded by <class>%Library.Populate</class>.
ClassMethod Random(n As %Integer) As %Integer
{
	Quit ##class(%Populate).Random(n)
}

}
