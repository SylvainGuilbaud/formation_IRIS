Class instruments.code
{

/// Description
ClassMethod a(pRequest As instruments.msg.analyses) As %Status
{
        Set sc = $$$OK
        #; Set tRequest = ##class(%DynamicObject).%New()
        #; set tRequest = {} ; {} est équivalent à ##class(%DynamicObject).%New()
 
        #; /// les propriétés de la classe msg.analyses sont celles du pRequest
        #; Set tRequest.nInstrument = pRequest.nInstrument
        #; Set tRequest.nTypeArticle = pRequest.nTypeArticle
        #; Set tRequest.nTypeMaj = pRequest.nTypeMaj
        #; Set tRequest.sDateAnalyse = pRequest.sDateAnalyse
        #; Set tRequest.sOperateur = pRequest.sOperateur
        #; set tRequest.sCodeEchantillon = pRequest.sCodeEchantillon
        #; set tRequest.tTests=[]  ; [] est équivalent à ##class(%DynamicArray).%New()
          
        #; for i=1:1:pRequest.tTests.Count() {  
        #;     #; set tTest = {}
        #;     #; set tTest.mesure = pRequest.tTests.GetAt(i).mesure
        #;     #; #; do tRequest.tTests.%Push(tTest)
        #;     do tRequest.tTests.%Push(pRequest.tTests.GetAt(i).mesure)
        #; }

        #; set tPayload = tRequest.%ToJSON()
        /// Methode plus simple à écrire :
        Set sc = pRequest.%JSONExportToStream(.stream)
        set tPayload="" ; n'est plus un JSON mais une simple chaîne à passer en POST
        while 'stream.AtEnd { ; boucle sur stream au cas où le stream > 32Ko
            set tPayload = tPayload _ stream.Read()
        }
        
        write !!,"payload:",!,tPayload,!

        Return sc
}

ClassMethod init() As %Status
{
    set sc = $$$OK
    set a = ##class(instruments.msg.analyses).%New()
    Set a.nInstrument = "instrument"
    Set a.nTypeArticle = "nTypeArticle"
    Set a.nTypeMaj = "nTypeMaj"
    Set a.sDateAnalyse = "sDateAnalyse"
    Set a.sOperateur = "sOperateur"
    set a.sCodeEchantillon = "sCodeEchantillon"
    for i=1:1:$r(5)+3 {
        set tTest = ##class(instruments.msg.tTests).%New()
        set tTest.mesure=$num(($random(1000000)+10000)/($random(100)+2.5),5)
        do a.tTests.SetAt(tTest,i)
    }
    write !,"in init:",a.%JSONExport(),!
    #; write !,"XML in init:",a.XMLExport(),!
    set sc = ..a(a)
    return sc
}

}
