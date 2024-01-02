/// Request map.
Class Fileserver.Broker Extends %CSP.REST
{

XData UrlMap
{
<Routes>
<Route Url="/getfilelist" Method="GET" Call="Fileserver.JSON:FileListToJSON"/> 
<Route Url="/requestfile/:fileid" Method="GET" Call="Fileserver.JSON:RequestFile"/>
<Route Url="/download/:downloadid" Method="GET" Call="Fileserver.JSON:DownloadFile"/>
<Route Url="/upload" Method="POST" Call="Fileserver.JSON:UploadFile"/>
<Route Url="/files" Method="GET" Call="csp.files:OnPage"/>

<Route Url="/test" Method="GET" Call="Test"/>  
 </Routes>
}

ClassMethod Test() As %Status
{
	&html<<h1>Status: OK!</h1><br>>
	zw %request
	&html<<br><br>>
	zw %response
	quit $$$OK
}

}
