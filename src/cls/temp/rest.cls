Class temp.rest Extends %CSP.REST
{

Parameter CONVERTINPUTSTREAM = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/echo" Method="POST" Call="echo" Cors="true"/>
</Routes>
}

ClassMethod echo() As %Status
{
    set %response.ContentType=..#CONTENTTYPEJSON
    set %response.CharSet="utf-8"
    set data=%request.Content.Read()
    #; set ^foo=$ZCONVERT(data,"I","UTF8")
    set ^foo=data
    set json={
        "classname":(..%ClassName(1))
        ,"from %request": (data)
        ,"from database": (^foo)
        ,"version": ($zv)
        ,"ts": ($zdt($h,3))
    }
    do json.%ToJSON()

    return $$$OK
}

}
