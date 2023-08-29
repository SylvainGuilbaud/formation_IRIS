Class ZENETUDE.REST Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/" Method="GET" Call="version"/>
<Route Url="/:episode" Method="GET" Call="getData"/>
</Routes>
}

ClassMethod getData(episode As %String) As %Status
{
    set sc = $$$OK
    set %response.ContentType = ..#CONTENTTYPEJSON
    Try {
        set sql($INCREMENT(sql)) = "SELECT p.patient_no IPP" 
        set sql($INCREMENT(sql)) = ",Admission_No IEP" 
        set sql($INCREMENT(sql)) = ",Nom_de_Nais NOM_NAIS" 
        set sql($INCREMENT(sql)) = ",prenoms PRENOM" 
        set sql($INCREMENT(sql)) = ",$extract(Date_de_Nais, 7, 8)"
        set sql($INCREMENT(sql)) = "||'/'|| $extract(Date_de_Nais, 5, 6)"
        set sql($INCREMENT(sql)) = "||'/'|| $extract(Date_de_Nais, 1, 4) DAT_NAIS" 
        set sql($INCREMENT(sql)) = ",rue ADR_CONT" 
        set sql($INCREMENT(sql)) = ",cp ADR_COD_POS" 
        set sql($INCREMENT(sql)) = ",localite ADR_NOM_VIL" 
        set sql($INCREMENT(sql)) = ",codepaysadr ADR_PAY_COD" 
        set sql($INCREMENT(sql)) = " FROM ClinicomSQL.patient p" 
        set sql($INCREMENT(sql)) = ", ClinicomSQL.episode e" 
        set sql($INCREMENT(sql)) = "WHERE Admission_No = " _ episode 
        set sql($INCREMENT(sql)) = "AND p.patient=e.patient"

        set result = ##class(%SQL.Statement).%ExecDirect(,.sql)
        if result.%SQLCODE = 0 {
            while result.%Next() {
                set json= {
                    "IPP":(result.%Get("IPP"))
                    ,"IEP":(result.%Get("IEP"))
                    ,"NOM_NAIS":(result.%Get("NOM_NAIS"))
                    ,"PRENOM":(result.%Get("PRENOM"))
                    ,"DAT_NAIS":(result.%Get("DAT_NAIS"))
                    ,"ADR_CONT":(result.%Get("ADR_CONT"))
                    ,"ADR_COD_POS":(result.%Get("ADR_COD_POS"))
                    ,"ADR_NOM_VIL":(result.%Get("ADR_NOM_VIL"))
                    ,"ADR_PAY_COD":(result.%Get("ADR_PAY_COD"))  
                }
            }
        } else {
            set json = {
            "SQLCODE": (result.%SQLCODE) 
            ,"Message": (result.%Message) 
            }
        }
        do json.%ToJSON()
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    return sc
}

ClassMethod version() As %Status
{
    set sc = $$$OK
    set %response.ContentType = ..#CONTENTTYPEJSON
    set nls = ##class(%SYS.NLS.Locale).GetLanguage()

    set json = {
         "version": ($zv)
        ,"date": ($zdt($h,3))
        ,"system": ($System)
        ,"username": ($Username)
        ,"roles": ($Roles)
        ,"namespace": ($Namespace)
        ,"country": ($listget(nls,1))
        ,"lang": ($listget(nls,2))
        ,"JavaHomeDirectory": ($SYSTEM.Util.JavaHomeDirectory())
        ,"JavaExe": ($SYSTEM.Util.JavaExe())
    }
    do json.%ToJSON()
    return sc
}

}
