Class formation.REST Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/" Method="GET" Call="version"/>
<Route Url="/patient" Method="GET" Call="service" />
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

	set tSC=##class(Ens.Director).CreateBusinessService("from Patients REST",.tService)

	set request=##class(formation.msg.mysql.patient).%New()
	set sc = request.%JSONImport(payload.Read())

	set sc=tService.ProcessInput(request,.response)
	#; set retour={}
	#; set retour.data=response.StringValue
	#; write retour.%ToJSON()
    set sc = response.%JSONExport()
    #; write str.%ToJSON()
	} catch e {
		throw e
	}
	return sc
}

}
