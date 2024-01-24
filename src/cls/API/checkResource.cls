Class API.checkResource Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
		<Route Url="/test" Method="GET" Call="Test"/>
	</Routes>
}

ClassMethod Test() As %Status [ Requires = "myResource:Use" ]
{
  #; do ..info()
  Do ##class(%REST.Impl).%WriteResponse("api method test : OK")
  Return $$$OK
}

ClassMethod info() As %Status
{
  set json = {
      "username":($username),
      "roles":($roles)
  }
  write json.%ToJSON()
  Return $$$OK
}

}
