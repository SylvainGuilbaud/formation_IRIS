/// Include COMMONMACROS
Class update.REST Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

Parameter CHARSET = "UTF-8";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/" Method="GET" Call="version"/>
<Route Url="/version" Method="GET" Call="version"/>
<Route Url="/import" Method="POST" Call="import"/>
</Routes>
}

ClassMethod import() As %Status
{
    set %response.ContentType=..#CONTENTTYPEJSON
    set sc = $$$OK
    set response = {}
	
    set ns = $NAMESPACE
 
    set payload={}.%FromJSON(%request.Content)
    set response.namespace=payload.namespace
    if response.namespace = "" {
        ; raise on error telling that namespace is required
        set response.error = "namespace is required"
        do response.%ToJSON()
        return sc
    }
    
    zn response.namespace
    set response.directory=payload.directory
    set directory = payload.directory
    if directory = "" {
        ; raise on error telling that directory is required
        set response.error = "directory is required"
        do response.%ToJSON()
        return sc
    }

    set sc = ##class(%SYSTEM.OBJ).Import(directory,"ck-d",,.errors,.imported)
    
    set response.imported = [],key = ""
    do { 
        set key=$order(imported(key),1) 
        quit:key=""
        do response.imported.%Push(key)
    } while key'=""

    set response.errors = []
    set key = ""
    do {
        set key = $order(errors(key),1,nb)
        quit:key=""
        do response.errors.%Push(key_":"_nb)
    } while key '= ""

    if sc {
        set response.status = sc
    } else {
        set response.status = $system.Status.GetErrorText(sc)
    }
  
	do response.%ToJSON()	
    zn ns
	return $$$OK
}

ClassMethod version() As %Status
{
    set sc=$$$OK
    set %response.ContentType= ..#CONTENTTYPEJSON
    set json={}
    set json.classname = (..%ClassName(1))
    set json.version=($zv)
    set json.date=($zdt($h,3))
    set json.system=($System)
    set json.username=($Username)
    set json.roles=($Roles)
    set json.namespace=($Namespace)
    set nls=##class(%SYS.NLS.Locale).GetLanguage()
    set json.country=($listget(nls,1))
    set json.lang=($listget(nls,2))
    set json.JavaHomeDirectory=$SYSTEM.Util.JavaHomeDirectory()
    set json.JavaExe=$SYSTEM.Util.JavaExe()
    do json.%ToJSON()
    #; write "Hello "_$USERNAME
    return sc
}

}
