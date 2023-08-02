Class prodadmin.responses.GetNamespaces Extends prodadmin.responses.GenericResponse [ ProcedureBlock ]
{

/// Implement operationId : GetNamespaces
/// get /namespaces
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
