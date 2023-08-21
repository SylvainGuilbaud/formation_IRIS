Class instruments.code Extends Ens.BusinessOperation
{

/// Description
Method importerAnalyses(pRequest As instruments.msg.analyses, Output pResponse As instruments.msg.retourMaj) As %Status
{
        Set sc = $$$OK
        Set tHttpRequest = ##class(%Net.HttpRequest).%New()
        Set tHttpResponse = ##class(%Net.HttpResponse).%New()
 
        /// Methode plus simple à écrire :
        /// si tPayload < 3.6Mo
        Set sc = pRequest.%JSONExportToString(.tPayload)

        Set tHttpRequest.ContentType = "application/json"
        Set tHttpRequest.SentChars = "UTF-8"
        Set tsc = ..Adapter.SendFormData(.tHttpResponse,"POST",tHttpRequest,,tPayload)
}

ClassMethod a(pRequest As instruments.msg.analyses) As %Status
{
        Set sc = $$$OK
 
        /// Methode plus simple à écrire :
        /// si tPayload < 3.6Mo

        Set sc = pRequest.%JSONExportToString(.tPayload)
        
        #; write !!,"payload:",!,tPayload,!

        write !!,"size:",!,$LENGTH(tPayload),!
        set now = $translate($zdt($h,3)," :","__")
        set file = ##class(%File).%New("/data/instruments_"_now_".json")
        do file.Open("WSN")
        do file.Write(tPayload)
        do file.Close()
        Return sc
}

ClassMethod init(nb As %Integer = 10) As %Status
{
    set sc = $$$OK
    set a = ##class(instruments.msg.analyses).%New()
    Set a.nInstrument = "instrument "_($RANDOM(10)+1)
    Set a.nTypeArticle = ##class(%PopulateUtils).StringMin(10,10)
    Set a.nTypeMaj = $zdt($h,3)
    Set a.sDateAnalyse = +$h
    Set a.sOperateur = "Operateur "_ ##class(%PopulateUtils).StringMin(3,3)
    set a.sCodeEchantillon = ##class(%PopulateUtils).StringMin(30,30)
    for i=1:1:nb {
        set tTest = ##class(instruments.msg.tTests).%New()
        set tTest.mesure=$num(($random(1000000)+10000)/($random(100)+2.5),5)
        do a.tTests.SetAt(tTest,i)
    }
    #; write !,"in init:",a.%JSONExport(),!
    #; write !,"XML in init:",a.XMLExport(),!
    set sc = ..a(a)
    return sc
}

}
