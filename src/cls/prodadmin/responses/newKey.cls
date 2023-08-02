Class prodadmin.responses.newKey Extends prodadmin.responses.GenericResponse [ ProcedureBlock ]
{

/// Implement operationId : newKey
/// post /key
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
