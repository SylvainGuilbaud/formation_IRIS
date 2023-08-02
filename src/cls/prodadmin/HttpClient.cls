Class prodadmin.HttpClient Extends %RegisteredObject [ ProcedureBlock ]
{

Parameter SERVER = "/admin";

Parameter SSLCONFIGURATION = "DefaultSSL";

Property HttpRequest [ InitialExpression = {##class(%Net.HttpRequest).%New()} ];

Property SSLConfiguration As %String [ InitialExpression = {..#SSLCONFIGURATION} ];

Property Server As %String [ InitialExpression = {..#SERVER} ];

Property URLComponents [ MultiDimensional ];

Method %OnNew(Server As %String, SSLConfiguration As %String) As %Status
{
	Set:$Data(Server) ..Server = Server
	Set:$Data(SSLConfiguration) ..SSLConfiguration = SSLConfiguration
	Quit ..InitializeHttpRequestObject()
}

/// Implement operationId : GetNamespaces
/// get /namespaces
Method GetNamespaces(requestMessage As prodadmin.requests.GetNamespaces, Output responseMessage As prodadmin.responses.GetNamespaces = {##class(prodadmin.responses.GetNamespaces).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "GetNamespaces"))
	Quit sc
}

Method InitializeHttpRequestObject() As %Status
{
	Set ..HttpRequest = ##class(%Net.HttpRequest).%New()
	Do ##class(%Net.URLParser).Decompose(..Server, .components)
	Set:$Data(components("host"), host) ..HttpRequest.Server = host
	Set:$Data(components("port"), port) ..HttpRequest.Port = port
	Set:$$$LOWER($Get(components("scheme")))="https" ..HttpRequest.Https = $$$YES, ..HttpRequest.SSLConfiguration = ..SSLConfiguration
	Merge:$Data(components) ..URLComponents = components
	Quit $$$OK
}

/// Implement operationId : SecurityExport
/// get /security/export
Method SecurityExport(requestMessage As prodadmin.requests.SecurityExport, Output responseMessage As prodadmin.responses.SecurityExport = {##class(prodadmin.responses.SecurityExport).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "SecurityExport"))
	Quit sc
}

/// Implement operationId : SecurityImport
/// get /security/import
Method SecurityImport(requestMessage As prodadmin.requests.SecurityImport, Output responseMessage As prodadmin.responses.SecurityImport = {##class(prodadmin.responses.SecurityImport).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "SecurityImport"))
	Quit sc
}

/// Implement operationId : SwaggerSpec
/// get /_spec
Method SwaggerSpec(requestMessage As prodadmin.requests.SwaggerSpec, Output responseMessage As prodadmin.responses.SwaggerSpec = {##class(prodadmin.responses.SwaggerSpec).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "SwaggerSpec"))
	Quit sc
}

/// Implement operationId : analytics
/// get /sage
Method analytics(requestMessage As prodadmin.requests.analytics, Output responseMessage As prodadmin.responses.analytics = {##class(prodadmin.responses.analytics).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "analytics"))
	Quit sc
}

/// Implement operationId : createNamespace
/// post /namespace
Method createNamespace(requestMessage As prodadmin.requests.createNamespace, Output responseMessage As prodadmin.responses.createNamespace = {##class(prodadmin.responses.createNamespace).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("POST", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "createNamespace"))
	Quit sc
}

/// Implement operationId : createProduction
/// post /production
Method createProduction(requestMessage As prodadmin.requests.createProduction, Output responseMessage As prodadmin.responses.createProduction = {##class(prodadmin.responses.createProduction).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("POST", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "createProduction"))
	Quit sc
}

/// Implement operationId : deleteNamespace
/// delete /namespace
Method deleteNamespace(requestMessage As prodadmin.requests.deleteNamespace, Output responseMessage As prodadmin.responses.deleteNamespace = {##class(prodadmin.responses.deleteNamespace).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("DELETE", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "deleteNamespace"))
	Quit sc
}

/// Implement operationId : disableNamespace
/// get /namespace/disable/{namespace}
Method disableNamespace(requestMessage As prodadmin.requests.disableNamespace, Output responseMessage As prodadmin.responses.disableNamespace = {##class(prodadmin.responses.disableNamespace).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "disableNamespace"))
	Quit sc
}

/// Implement operationId : enableNamespace
/// get /namespace/enable/{namespace}
Method enableNamespace(requestMessage As prodadmin.requests.enableNamespace, Output responseMessage As prodadmin.responses.enableNamespace = {##class(prodadmin.responses.enableNamespace).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "enableNamespace"))
	Quit sc
}

/// Implement operationId : enableNamespace01
/// put /namespace/enable/{namespace}
Method enableNamespace01(requestMessage As prodadmin.requests.enableNamespace01, Output responseMessage As prodadmin.responses.enableNamespace01 = {##class(prodadmin.responses.enableNamespace01).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("PUT", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "enableNamespace01"))
	Quit sc
}

/// Implement operationId : namespaceExists
/// get /namespace/exist/{namespace}
Method namespaceExists(requestMessage As prodadmin.requests.namespaceExists, Output responseMessage As prodadmin.responses.namespaceExists = {##class(prodadmin.responses.namespaceExists).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "namespaceExists"))
	Quit sc
}

/// Implement operationId : newKey
/// post /key
Method newKey(requestMessage As prodadmin.requests.newKey, Output responseMessage As prodadmin.responses.newKey = {##class(prodadmin.responses.newKey).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("POST", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "newKey"))
	Quit sc
}

/// Implement operationId : service
/// get /service
Method service(requestMessage As prodadmin.requests.service, Output responseMessage As prodadmin.responses.service = {##class(prodadmin.responses.service).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "service"))
	Quit sc
}

/// Implement operationId : version
/// get /
Method version(requestMessage As prodadmin.requests.version, Output responseMessage As prodadmin.responses.version = {##class(prodadmin.responses.version).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "version"))
	Quit sc
}

}
