Class temp.page Extends %CSP.Page
{

Parameter CONVERTINPUTSTREAM = 1;

Parameter CONTENTTYPE = "application/json";

Parameter CHARSET = "utf-8";

ClassMethod OnPage() As %Status [ ServerOnly = 1 ]
{
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
