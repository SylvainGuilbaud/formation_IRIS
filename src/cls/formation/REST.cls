Class formation.REST Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/" Method="GET" Call="version"/>
<Route Url="/personne" Method="POST" Call="service" />
</Routes>
}

ClassMethod version() As %Status
{
    set sc = $$$OK
    set %response.ContentType = ..#CONTENTTYPEJSON
    set json = {}
    set json.version = ($zv)
    set json.date = ($zdt($h,3))
    set json.system = ($System)
    set json.username = ($Username)
    set json.roles = ($Roles)
    set json.namespace = ($Namespace)
    set nls = ##class(%SYS.NLS.Locale).GetLanguage()
    set json.country = ($listget(nls,1))
    set json.lang = ($listget(nls,2))
    set json.JavaHomeDirectory = $SYSTEM.Util.JavaHomeDirectory()
    set json.JavaExe = $SYSTEM.Util.JavaExe()
    do json.%ToJSON()
    return sc
}

ClassMethod service() As %Status
{
 try {
	set sc=$$$OK
	set %response.ContentType="application/json"

	set payload=%request.Content

	set tSC=##class(Ens.Director).CreateBusinessService("de EXPARF REST",.tService)

	set request=##class(formation.RM.personne.Record).%New()
    #; set request = ##class(NomProjet.RM.personne.Record).%New()
	set sc = request.%JSONImport(payload.Read())

    set retour={}

    if 'sc {
         set retour.importJSON = ($system.Status.GetErrorText(sc))
    } else {

        set sc=tService.ProcessInput(request,.response)

        #dim response as formation.msg.mysql.response.personne
        
        if 'response.status {
            set retour.status = ($system.Status.GetErrorText(response.status))
        } else {
            set retour.status = "OK"
        }
        if response.inserted {
        set retour.action = "inserted"
        } 
        if response.updated {
        set retour.action = "updated"
        } 
    }
	write retour.%ToJSON()
	} catch e {
		throw e
	}
	return sc
}

}
