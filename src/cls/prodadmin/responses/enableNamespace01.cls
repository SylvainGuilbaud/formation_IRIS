Class prodadmin.responses.enableNamespace01 Extends prodadmin.responses.GenericResponse [ ProcedureBlock ]
{

/// Implement operationId : enableNamespace01
/// put /namespace/enable/{namespace}
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
