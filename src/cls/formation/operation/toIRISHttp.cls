/// Description
Class formation.operation.toIRISHttp Extends Ens.BusinessOperation
{

Property Adapter As EnsLib.HTTP.OutboundAdapter;

Parameter ADAPTER = "EnsLib.HTTP.OutboundAdapter";

Parameter INVOCATION = "Queue";

Property pause As %Numeric(VALUELIST = ",1,0.5,0.1") [ InitialExpression = 0.1 ];

Parameter SETTINGS = "pause:misc";

Method replication(pRequest As formation.msg.replication, Output pResponse As formation.msg.replication.response) As %Status
{
    /*
    <replication xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:s="http://www.w3.org/2001/XMLSchema">
        <sTable>FORMULE1_DECOMPO_SUBST</sTable>
        <nIdentifiant>90269767</nIdentifiant>
        <dhDateCreation>2022-07-27T07:59:39.867Z</dhDateCreation>
        <sAction>HAjoute</sAction>
        <sCle>IDFORMULE1_DECOMPO_SUBST</sCle>
    </replication>

    http://epfrlin02/hftoiris/EMPLOYES/EMPO_ID/1

    */
    hang ..pause
    set sc = $$$OK 
    set pResponse = ##class(formation.msg.replication.response).%New()
    set pResponse.sTable = pRequest.sTable
    set pResponse.nIdentifiant  = pRequest.nIdentifiant
    set pResponse.dhDateCreation  = pRequest.dhDateCreation
    set pResponse.sAction  = pRequest.sAction
    set pResponse.sCle  = pRequest.sCle

    set classname = "formation." _ $replace(pRequest.sTable,"_","")
    if ##class(%Dictionary.ClassDefinition).%ExistsId(classname) {
        if (pRequest.sAction = "HAjoute")
        || (pRequest.sAction = "HModifie")
        || (pRequest.sAction = "HSupprime") {
            if (pRequest.sAction = "HAjoute")
            || (pRequest.sAction = "HModifie") {

                set URL = ..Adapter.URL _ pRequest.sTable _ "/" _ pRequest.sCle _ "/" _ pRequest.nIdentifiant
                $$$TRACE("URL:" _ URL)
                set sc = ..Adapter.GetURL(URL,.pHttpResponse)
                set msg = "getxml:" _ pHttpResponse.StatusLine
                if sc {
                    if $ISOBJECT(pHttpResponse) { 
                        while 'pHttpResponse.Data.AtEnd {
                            set msg = msg _ pHttpResponse.Data.Read()
                        }
                        $$$TRACE("XML:" _  msg)
                        if pHttpResponse.Data.Size > 0 {
                            /// récupération des données à ajouter ou à mettre à jour
                            set httpRequest=##class(%Net.HttpRequest).%New()
                            set httpRequest.Username = "_system"
                            set httpRequest.Password = "SYS"
                            set httpRequest.ContentType="application/xml"
                            do pHttpResponse.Data.Rewind()
                            do httpRequest.EntityBody.CopyFrom(pHttpResponse.Data)
                            
                            set post = "http://localhost/common/import"
                            
                            $$$TRACE("POST:" _ post)
                            $$$TRACE("POST:" _ httpRequest.EntityBody.Read())
                            set sc = httpRequest.Post(post)
                            set msg = "import :" _ httpRequest.HttpResponse.StatusLine
                            if ($$$ISOK(sc))
                            & ($IsObject(httpRequest.HttpResponse.Data)) 
                            { 
                                do httpRequest.HttpResponse.Data.Rewind()
                                
                                while 'httpRequest.HttpResponse.Data.AtEnd {
                                    set msg = msg _ httpRequest.HttpResponse.Data.Read()
                                }
                                $$$TRACE("IMPORT:" _ msg)
                            }
                            if 'sc {
                                set msg = msg _ $system.Status.GetErrorText(sc)
                                $$$TRACE("IMPORT XML FAILED WITH sc:" _ msg _ " StatusLine:" _ httpRequest.HttpResponse.StatusLine)
                            }
                        }
                        else {
                            set msg = "aucune donnée reçue de " _ URL
                            set sc = $SYSTEM.Status.Error(5001,msg)
                        }
                    }
                } 
                else {
                    set msg = $system.Status.GetErrorText(sc)
                    $$$TRACE("GET XML FAILED WITH sc:" _ msg _ " StatusLine:" _ pHttpResponse.StatusLine)

                    if $ISOBJECT(pHttpResponse) { 
                        set error = ""
                        while 'pHttpResponse.Data.AtEnd {
                            set error = error _ pHttpResponse.Data.Read()
                        }
                        $$$TRACE("ERROR:" _  error)
                        set json = {}.%FromJSON(error)
                        set msg = "Erreur:" _ json.fault.faultstring  
                    }
                    set sc = $SYSTEM.Status.Error(5001,msg)
                }
                set pResponse.message = msg 
            }
            // suppression des données dans IRIS
            if pRequest.sAction = "HSupprime" {
                    set sc = $CLASSMETHOD(classname,"%DeleteId",pRequest.nIdentifiant)
                    if sc { 
                        set msg = "Delete " _ pRequest.nIdentifiant _ " in " _ pRequest.sTable _ " successful"
                    } else {
                        set msg = "Error while deleting " _ pRequest.nIdentifiant _ " in " _ pRequest.sTable _ " : " _ $SYSTEM.Status.GetErrorText(sc)
                    }
                    set pResponse.message = msg
                    $$$TRACE("DELETE:" _  pResponse.message)
                
            }
        } else {
            set msg = pRequest.sAction _ " action inconnue"
            set sc = $SYSTEM.Status.Error(5001,msg)
        }
    }
    else {
        set msg = "NOCLASS:" _ classname _ " n'existe pas"
        set sc = $SYSTEM.Status.Error(5001,msg)
    }
    set pResponse.status = sc
    do ##class(common.trace).log("réplication " _ pRequest.sTable ,pRequest.sAction,msg)
    return $$$OK
}

XData MessageMap
{
<MapItems>
   <MapItem MessageType="formation.msg.replication">
    <Method>replication</Method>
  </MapItem>
</MapItems>
}

}
