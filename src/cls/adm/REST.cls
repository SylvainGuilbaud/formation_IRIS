Class adm.REST Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

Parameter CHARSET = "UTF-8";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/" Method="GET" Call="GetInfo"/>
<Route Url="/version" Method="GET" Call="version"/>
</Routes>
}

/// Description
ClassMethod GetInfo() As %Status
{
    Set sc = $$$OK
    #; set %response.ContentType = ..#CONTENTTYPEJSON

    write "{""status"":""ok""}",!
    #; write ["Hello World!"]

    Return sc
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
