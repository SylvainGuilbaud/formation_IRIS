Class dc.axiell
{

Query data(p1 As %String) As %Query(ROWSPEC = "key1:%String,key2:%String,key3:%String,key4:%String,key5:%String,key6:%String,datavalue:%String") [ SqlProc ]
{
}

ClassMethod dataExecute(ByRef qHandle As %Binary, p1 As %String) As %Status
{
    Set qHandle("node") = p1
    Quit $$$OK
}

ClassMethod dataFetch(ByRef qHandle As %Binary, ByRef Row As %List, ByRef AtEnd As %Boolean) As %Status [ PlaceAfter = dataExecute ]
{
    Set sc = $$$OK
    Set qHandle("node") = $Query(@qHandle("node"), 1, data)

    If qHandle("node") = "" Set Row = "", AtEnd = $$$YES Quit $$$OK
    ; feeds the key x fields based on the subscripts of the global
    For i=1:1:$QLength(qHandle("node")) Set $List(Row, i) = $QSubscript(qHandle("node"), i)

    If i < 6 {  ; if we do not have 6 subscripts, we feed the rest with an empty string
        For j = i+1:1:6 Set $List(Row, j) = ""
    }

    Set $List(Row, 7) = data, AtEnd = $$$NO
    Quit sc
}

ClassMethod dataClose(ByRef qHandle As %Binary) As %Status [ PlaceAfter = dataExecute ]
{
	Kill qHandle Quit $$$OK
}

/// just for some test data
ClassMethod set() As %Status
{
    set sc = $$$OK

    kill ^AFO

    s ^AFO("Site","Ville")="66722,3743"
    s ^AFO("Site","Ville","111BB","OBT")=",MMM,XXX,"
    s ^AFO("Site","Ville","111OW","OBT")=",XXX,MMM,"
    s ^AFO("Site","Ville","AANVRBIBS","zzz")    =    "1^^1"
    s ^AFO("Site","Ville","AANVRBIBS","zzz","*","dut")    =    "*afhalen waar gevonden"
    s ^AFO("Site","Ville","AANVRBIBS","zzz","*","eng")    =    "*Pickup where found"
    s ^AFO("Site","Ville","AANVRBIBS","zzz","*","fre")    =    "*Lieu où trouvé"

    kill ^AAA

    s ^AAA(1,2)="66722,3743"
    s ^AAA(1,2,"3","4")         =",MMM,XXX,"
    s ^AAA(1,2,"4","5")         =",XXX,MMM,"
    s ^AAA(1,2,3,4)             =    "1^^1"
    s ^AAA(1,2,3,4,"*","dut")   =    "*afhalen waar gevonden"
    s ^AAA(1,2,3,4,"*","eng")   =    "*Pickup where found"
    s ^AAA(1,2,3,4,"*","fre")   =    "*Lieu où trouvé"

    kill ^BBB

    s ^BBB("en")                ="Hello"
    s ^BBB("en","sub")          ="World"
    s ^BBB(1,2,3)               ="BBB"
    s ^BBB(1,2,3,4)             =    "BBB^^BBB"

    kill ^CCC

    s ^CCC("fr")                ="Bonjour"
    s ^CCC("fr","sub")          ="la Communauté"
    s ^CCC(1,2,3,"QUATRE","CINQ","SIX")   ="6"
    s ^CCC(1,2,3,4,"5","6")     ="6"
    s ^CCC("UN","DEUX","TROIS")               ="3"
    return sc
}

}
