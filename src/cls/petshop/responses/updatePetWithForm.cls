Class petshop.responses.updatePetWithForm Extends petshop.responses.GenericResponse [ ProcedureBlock ]
{

/// Implement operationId : updatePetWithForm
/// post /pet/{petId}
Method LoadFromResponse(httpResponse As %Net.HttpResponse, caller As %String = "") As %Status
{
	Set sc = $$$OK
	Do ##super(httpResponse, caller)
	Quit sc
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
