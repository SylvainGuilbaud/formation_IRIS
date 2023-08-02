Class prodadmin.responses.SecurityImport Extends prodadmin.responses.GenericResponse [ ProcedureBlock ]
{

/// Implement operationId : SecurityImport
/// get /security/import
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
