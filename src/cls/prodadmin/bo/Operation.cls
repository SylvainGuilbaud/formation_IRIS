Class prodadmin.bo.Operation Extends Ens.BusinessOperation [ ProcedureBlock ]
{

Parameter ADAPTER = "EnsLib.HTTP.OutboundAdapter";

Property Adapter As EnsLib.HTTP.OutboundAdapter;

/// Implement operationId : GetNamespaces
/// get /namespaces
Method GetNamespaces(requestMessage As prodadmin.requests.GetNamespaces, Output responseMessage As prodadmin.responses.GetNamespaces) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.GetNamespaces).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "GetNamespaces"))
	Quit sc
}

/// Implement operationId : SecurityExport
/// get /security/export
Method SecurityExport(requestMessage As prodadmin.requests.SecurityExport, Output responseMessage As prodadmin.responses.SecurityExport) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.SecurityExport).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "SecurityExport"))
	Quit sc
}

/// Implement operationId : SecurityImport
/// get /security/import
Method SecurityImport(requestMessage As prodadmin.requests.SecurityImport, Output responseMessage As prodadmin.responses.SecurityImport) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.SecurityImport).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "SecurityImport"))
	Quit sc
}

/// Implement operationId : SwaggerSpec
/// get /_spec
Method SwaggerSpec(requestMessage As prodadmin.requests.SwaggerSpec, Output responseMessage As prodadmin.responses.SwaggerSpec) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.SwaggerSpec).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "SwaggerSpec"))
	Quit sc
}

/// Implement operationId : analytics
/// get /sage
Method analytics(requestMessage As prodadmin.requests.analytics, Output responseMessage As prodadmin.responses.analytics) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.analytics).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "analytics"))
	Quit sc
}

/// Implement operationId : createNamespace
/// post /namespace
Method createNamespace(requestMessage As prodadmin.requests.createNamespace, Output responseMessage As prodadmin.responses.createNamespace) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.createNamespace).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "post", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "createNamespace"))
	Quit sc
}

/// Implement operationId : createProduction
/// post /production
Method createProduction(requestMessage As prodadmin.requests.createProduction, Output responseMessage As prodadmin.responses.createProduction) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.createProduction).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "post", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "createProduction"))
	Quit sc
}

/// Implement operationId : deleteNamespace
/// delete /namespace
Method deleteNamespace(requestMessage As prodadmin.requests.deleteNamespace, Output responseMessage As prodadmin.responses.deleteNamespace) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.deleteNamespace).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "delete", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "deleteNamespace"))
	Quit sc
}

/// Implement operationId : disableNamespace
/// get /namespace/disable/{namespace}
Method disableNamespace(requestMessage As prodadmin.requests.disableNamespace, Output responseMessage As prodadmin.responses.disableNamespace) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.disableNamespace).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "disableNamespace"))
	Quit sc
}

/// Implement operationId : enableNamespace
/// get /namespace/enable/{namespace}
Method enableNamespace(requestMessage As prodadmin.requests.enableNamespace, Output responseMessage As prodadmin.responses.enableNamespace) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.enableNamespace).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "enableNamespace"))
	Quit sc
}

/// Implement operationId : enableNamespace01
/// put /namespace/enable/{namespace}
Method enableNamespace01(requestMessage As prodadmin.requests.enableNamespace01, Output responseMessage As prodadmin.responses.enableNamespace01) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.enableNamespace01).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "put", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "enableNamespace01"))
	Quit sc
}

/// Implement operationId : namespaceExists
/// get /namespace/exist/{namespace}
Method namespaceExists(requestMessage As prodadmin.requests.namespaceExists, Output responseMessage As prodadmin.responses.namespaceExists) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.namespaceExists).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "namespaceExists"))
	Quit sc
}

/// Implement operationId : newKey
/// post /key
Method newKey(requestMessage As prodadmin.requests.newKey, Output responseMessage As prodadmin.responses.newKey) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.newKey).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "post", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "newKey"))
	Quit sc
}

/// Implement operationId : service
/// get /service
Method service(requestMessage As prodadmin.requests.service, Output responseMessage As prodadmin.responses.service) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.service).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "service"))
	Quit sc
}

/// Implement operationId : version
/// get /
Method version(requestMessage As prodadmin.requests.version, Output responseMessage As prodadmin.responses.version) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(prodadmin.responses.version).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "version"))
	Quit sc
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="prodadmin.requests.GetNamespaces">
		<Method>GetNamespaces</Method>
	</MapItem>
	<MapItem MessageType="prodadmin.requests.SecurityExport">
		<Method>SecurityExport</Method>
	</MapItem>
	<MapItem MessageType="prodadmin.requests.SecurityImport">
		<Method>SecurityImport</Method>
	</MapItem>
	<MapItem MessageType="prodadmin.requests.SwaggerSpec">
		<Method>SwaggerSpec</Method>
	</MapItem>
	<MapItem MessageType="prodadmin.requests.analytics">
		<Method>analytics</Method>
	</MapItem>
	<MapItem MessageType="prodadmin.requests.createNamespace">
		<Method>createNamespace</Method>
	</MapItem>
	<MapItem MessageType="prodadmin.requests.createProduction">
		<Method>createProduction</Method>
	</MapItem>
	<MapItem MessageType="prodadmin.requests.deleteNamespace">
		<Method>deleteNamespace</Method>
	</MapItem>
	<MapItem MessageType="prodadmin.requests.disableNamespace">
		<Method>disableNamespace</Method>
	</MapItem>
	<MapItem MessageType="prodadmin.requests.enableNamespace">
		<Method>enableNamespace</Method>
	</MapItem>
	<MapItem MessageType="prodadmin.requests.enableNamespace01">
		<Method>enableNamespace01</Method>
	</MapItem>
	<MapItem MessageType="prodadmin.requests.namespaceExists">
		<Method>namespaceExists</Method>
	</MapItem>
	<MapItem MessageType="prodadmin.requests.newKey">
		<Method>newKey</Method>
	</MapItem>
	<MapItem MessageType="prodadmin.requests.service">
		<Method>service</Method>
	</MapItem>
	<MapItem MessageType="prodadmin.requests.version">
		<Method>version</Method>
	</MapItem>
</MapItems>
}

}
