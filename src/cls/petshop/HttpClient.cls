Class petshop.HttpClient Extends %RegisteredObject [ ProcedureBlock ]
{

Parameter SERVER = "https://petstore3.swagger.io/api/v3";

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

/// Implement operationId : addPet
/// post /pet
Method addPet(requestMessage As petshop.requests.addPet, Output responseMessage As petshop.responses.addPet = {##class(petshop.responses.addPet).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("POST", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "addPet"))
	Quit sc
}

/// Implement operationId : createUser
/// post /user
Method createUser(requestMessage As petshop.requests.createUser, Output responseMessage As petshop.responses.createUser = {##class(petshop.responses.createUser).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("POST", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "createUser"))
	Quit sc
}

/// Implement operationId : createUsersWithListInput
/// post /user/createWithList
Method createUsersWithListInput(requestMessage As petshop.requests.createUsersWithListInput, Output responseMessage As petshop.responses.createUsersWithListInput = {##class(petshop.responses.createUsersWithListInput).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("POST", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "createUsersWithListInput"))
	Quit sc
}

/// Implement operationId : deleteOrder
/// delete /store/order/{orderId}
Method deleteOrder(requestMessage As petshop.requests.deleteOrder, Output responseMessage As petshop.responses.deleteOrder = {##class(petshop.responses.deleteOrder).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("DELETE", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "deleteOrder"))
	Quit sc
}

/// Implement operationId : deletePet
/// delete /pet/{petId}
Method deletePet(requestMessage As petshop.requests.deletePet, Output responseMessage As petshop.responses.deletePet = {##class(petshop.responses.deletePet).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("DELETE", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "deletePet"))
	Quit sc
}

/// Implement operationId : deleteUser
/// delete /user/{username}
Method deleteUser(requestMessage As petshop.requests.deleteUser, Output responseMessage As petshop.responses.deleteUser = {##class(petshop.responses.deleteUser).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("DELETE", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "deleteUser"))
	Quit sc
}

/// Implement operationId : findPetsByStatus
/// get /pet/findByStatus
Method findPetsByStatus(requestMessage As petshop.requests.findPetsByStatus, Output responseMessage As petshop.responses.findPetsByStatus = {##class(petshop.responses.findPetsByStatus).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "findPetsByStatus"))
	Quit sc
}

/// Implement operationId : findPetsByTags
/// get /pet/findByTags
Method findPetsByTags(requestMessage As petshop.requests.findPetsByTags, Output responseMessage As petshop.responses.findPetsByTags = {##class(petshop.responses.findPetsByTags).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "findPetsByTags"))
	Quit sc
}

/// Implement operationId : getInventory
/// get /store/inventory
Method getInventory(requestMessage As petshop.requests.getInventory, Output responseMessage As petshop.responses.getInventory = {##class(petshop.responses.getInventory).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "getInventory"))
	Quit sc
}

/// Implement operationId : getOrderById
/// get /store/order/{orderId}
Method getOrderById(requestMessage As petshop.requests.getOrderById, Output responseMessage As petshop.responses.getOrderById = {##class(petshop.responses.getOrderById).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "getOrderById"))
	Quit sc
}

/// Implement operationId : getPetById
/// get /pet/{petId}
Method getPetById(requestMessage As petshop.requests.getPetById, Output responseMessage As petshop.responses.getPetById = {##class(petshop.responses.getPetById).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "getPetById"))
	Quit sc
}

/// Implement operationId : getUserByName
/// get /user/{username}
Method getUserByName(requestMessage As petshop.requests.getUserByName, Output responseMessage As petshop.responses.getUserByName = {##class(petshop.responses.getUserByName).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "getUserByName"))
	Quit sc
}

/// Implement operationId : loginUser
/// get /user/login
Method loginUser(requestMessage As petshop.requests.loginUser, Output responseMessage As petshop.responses.loginUser = {##class(petshop.responses.loginUser).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "loginUser"))
	Quit sc
}

/// Implement operationId : logoutUser
/// get /user/logout
Method logoutUser(requestMessage As petshop.requests.logoutUser, Output responseMessage As petshop.responses.logoutUser = {##class(petshop.responses.logoutUser).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("GET", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "logoutUser"))
	Quit sc
}

/// Implement operationId : placeOrder
/// post /store/order
Method placeOrder(requestMessage As petshop.requests.placeOrder, Output responseMessage As petshop.responses.placeOrder = {##class(petshop.responses.placeOrder).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("POST", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "placeOrder"))
	Quit sc
}

/// Implement operationId : updatePet
/// put /pet
Method updatePet(requestMessage As petshop.requests.updatePet, Output responseMessage As petshop.responses.updatePet = {##class(petshop.responses.updatePet).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("PUT", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "updatePet"))
	Quit sc
}

/// Implement operationId : updatePetWithForm
/// post /pet/{petId}
Method updatePetWithForm(requestMessage As petshop.requests.updatePetWithForm, Output responseMessage As petshop.responses.updatePetWithForm = {##class(petshop.responses.updatePetWithForm).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("POST", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "updatePetWithForm"))
	Quit sc
}

/// Implement operationId : updateUser
/// put /user/{username}
Method updateUser(requestMessage As petshop.requests.updateUser, Output responseMessage As petshop.responses.updateUser = {##class(petshop.responses.updateUser).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("PUT", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "updateUser"))
	Quit sc
}

/// Implement operationId : uploadFile
/// post /pet/{petId}/uploadImage
Method uploadFile(requestMessage As petshop.requests.uploadFile, Output responseMessage As petshop.responses.uploadFile = {##class(petshop.responses.uploadFile).%New()}) As %Status
{
	Set sc = $$$OK
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(..HttpRequest))
	$$$QuitOnError(..HttpRequest.Send("POST", $Get(..URLComponents("path")) _ requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(..HttpRequest.HttpResponse, "uploadFile"))
	Quit sc
}

}
