Class API.requireResource Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
		<Route Url="/test" Method="GET" Call="Test" />
	</Routes>
}

ClassMethod Test() As %Status [ Requires = "myResource:Use" ]
{
  Do ##class(%REST.Impl).%WriteResponse("api method test : OK")
  Return $$$OK
}

}
