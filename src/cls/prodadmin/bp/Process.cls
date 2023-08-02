Class prodadmin.bp.Process Extends Ens.BusinessProcess [ ProcedureBlock ]
{

Method OnRequest(pRequest As Ens.Request, pResponse As Ens.Response) As %Status
{
	Return ..SendRequestAsync("prodadmin.bo.Operation", pRequest, 1, pRequest.%ClassName(1))
}

Method OnResponse(request As %Library.Persistent, response As %Library.Persistent, callrequest As %Library.Persistent, callresponse As %Library.Persistent, pCompletionKey As %String) As %Status
{
	Return $$$OK
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
