Class prodadmin.responses.namespaceExists Extends prodadmin.responses.GenericResponse [ ProcedureBlock ]
{

/// Implement operationId : namespaceExists
/// get /namespace/exist/{namespace}
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
