Class petshop.bo.Operation Extends Ens.BusinessOperation [ ProcedureBlock ]
{

Parameter ADAPTER = "EnsLib.HTTP.OutboundAdapter";

Property Adapter As EnsLib.HTTP.OutboundAdapter;

/// Implement operationId : addPet
/// post /pet
Method addPet(requestMessage As petshop.requests.addPet, Output responseMessage As petshop.responses.addPet) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.addPet).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "post", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "addPet"))
	Quit sc
}

/// Implement operationId : createUser
/// post /user
Method createUser(requestMessage As petshop.requests.createUser, Output responseMessage As petshop.responses.createUser) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.createUser).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "post", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "createUser"))
	Quit sc
}

/// Implement operationId : createUsersWithListInput
/// post /user/createWithList
Method createUsersWithListInput(requestMessage As petshop.requests.createUsersWithListInput, Output responseMessage As petshop.responses.createUsersWithListInput) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.createUsersWithListInput).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "post", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "createUsersWithListInput"))
	Quit sc
}

/// Implement operationId : deleteOrder
/// delete /store/order/{orderId}
Method deleteOrder(requestMessage As petshop.requests.deleteOrder, Output responseMessage As petshop.responses.deleteOrder) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.deleteOrder).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "delete", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "deleteOrder"))
	Quit sc
}

/// Implement operationId : deletePet
/// delete /pet/{petId}
Method deletePet(requestMessage As petshop.requests.deletePet, Output responseMessage As petshop.responses.deletePet) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.deletePet).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "delete", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "deletePet"))
	Quit sc
}

/// Implement operationId : deleteUser
/// delete /user/{username}
Method deleteUser(requestMessage As petshop.requests.deleteUser, Output responseMessage As petshop.responses.deleteUser) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.deleteUser).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "delete", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "deleteUser"))
	Quit sc
}

/// Implement operationId : findPetsByStatus
/// get /pet/findByStatus
Method findPetsByStatus(requestMessage As petshop.requests.findPetsByStatus, Output responseMessage As petshop.responses.findPetsByStatus) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.findPetsByStatus).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "findPetsByStatus"))
	Quit sc
}

/// Implement operationId : findPetsByTags
/// get /pet/findByTags
Method findPetsByTags(requestMessage As petshop.requests.findPetsByTags, Output responseMessage As petshop.responses.findPetsByTags) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.findPetsByTags).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "findPetsByTags"))
	Quit sc
}

/// Implement operationId : getInventory
/// get /store/inventory
Method getInventory(requestMessage As petshop.requests.getInventory, Output responseMessage As petshop.responses.getInventory) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.getInventory).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "getInventory"))
	Quit sc
}

/// Implement operationId : getOrderById
/// get /store/order/{orderId}
Method getOrderById(requestMessage As petshop.requests.getOrderById, Output responseMessage As petshop.responses.getOrderById) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.getOrderById).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "getOrderById"))
	Quit sc
}

/// Implement operationId : getPetById
/// get /pet/{petId}
Method getPetById(requestMessage As petshop.requests.getPetById, Output responseMessage As petshop.responses.getPetById) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.getPetById).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "getPetById"))
	Quit sc
}

/// Implement operationId : getUserByName
/// get /user/{username}
Method getUserByName(requestMessage As petshop.requests.getUserByName, Output responseMessage As petshop.responses.getUserByName) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.getUserByName).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "getUserByName"))
	Quit sc
}

/// Implement operationId : loginUser
/// get /user/login
Method loginUser(requestMessage As petshop.requests.loginUser, Output responseMessage As petshop.responses.loginUser) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.loginUser).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "loginUser"))
	Quit sc
}

/// Implement operationId : logoutUser
/// get /user/logout
Method logoutUser(requestMessage As petshop.requests.logoutUser, Output responseMessage As petshop.responses.logoutUser) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.logoutUser).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "get", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "logoutUser"))
	Quit sc
}

/// Implement operationId : placeOrder
/// post /store/order
Method placeOrder(requestMessage As petshop.requests.placeOrder, Output responseMessage As petshop.responses.placeOrder) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.placeOrder).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "post", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "placeOrder"))
	Quit sc
}

/// Implement operationId : updatePet
/// put /pet
Method updatePet(requestMessage As petshop.requests.updatePet, Output responseMessage As petshop.responses.updatePet) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.updatePet).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "put", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "updatePet"))
	Quit sc
}

/// Implement operationId : updatePetWithForm
/// post /pet/{petId}
Method updatePetWithForm(requestMessage As petshop.requests.updatePetWithForm, Output responseMessage As petshop.responses.updatePetWithForm) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.updatePetWithForm).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "post", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "updatePetWithForm"))
	Quit sc
}

/// Implement operationId : updateUser
/// put /user/{username}
Method updateUser(requestMessage As petshop.requests.updateUser, Output responseMessage As petshop.responses.updateUser) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.updateUser).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "put", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "updateUser"))
	Quit sc
}

/// Implement operationId : uploadFile
/// post /pet/{petId}/uploadImage
Method uploadFile(requestMessage As petshop.requests.uploadFile, Output responseMessage As petshop.responses.uploadFile) As %Status
{
	Set sc = $$$OK, pHttpRequestIn = ##class(%Net.HttpRequest).%New(), responseMessage = ##class(petshop.responses.uploadFile).%New()
	$$$QuitOnError(requestMessage.LoadHttpRequestObject(pHttpRequestIn))
	$$$QuitOnError(..Adapter.SendFormDataArray(.pHttpResponse, "post", pHttpRequestIn, , , ..Adapter.URL_requestMessage.%URL))
	$$$QuitOnError(responseMessage.LoadFromResponse(pHttpResponse, "uploadFile"))
	Quit sc
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="petshop.requests.addPet">
		<Method>addPet</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.createUser">
		<Method>createUser</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.createUsersWithListInput">
		<Method>createUsersWithListInput</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.deleteOrder">
		<Method>deleteOrder</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.deletePet">
		<Method>deletePet</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.deleteUser">
		<Method>deleteUser</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.findPetsByStatus">
		<Method>findPetsByStatus</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.findPetsByTags">
		<Method>findPetsByTags</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.getInventory">
		<Method>getInventory</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.getOrderById">
		<Method>getOrderById</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.getPetById">
		<Method>getPetById</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.getUserByName">
		<Method>getUserByName</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.loginUser">
		<Method>loginUser</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.logoutUser">
		<Method>logoutUser</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.placeOrder">
		<Method>placeOrder</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.updatePet">
		<Method>updatePet</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.updatePetWithForm">
		<Method>updatePetWithForm</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.updateUser">
		<Method>updateUser</Method>
	</MapItem>
	<MapItem MessageType="petshop.requests.uploadFile">
		<Method>uploadFile</Method>
	</MapItem>
</MapItems>
}

}
