Class petshop.responses.uploadFile Extends petshop.responses.GenericResponse [ ProcedureBlock ]
{

/// http status code = 200 content-type = application/json
/// 
Property ApiResponse As petshop.model.ApiResponse(XMLNAME = "default");

/// Implement operationId : uploadFile
/// post /pet/{petId}/uploadImage
Method LoadFromResponse(httpResponse As %Net.HttpResponse, caller As %String = "") As %Status
{
	Set sc = $$$OK
	Do ##super(httpResponse, caller)
	If $$$LOWER($Piece(httpResponse.ContentType,";",1))="application/json",httpResponse.StatusCode = "200" {
		Set ..ApiResponse = ##class(petshop.model.ApiResponse).%New()
		Do ..ApiResponse.%JSONImport(httpResponse.Data)
		Return sc
	}
	Quit sc
}

Storage Default
{
<Data name="uploadFileDefaultData">
<Subscript>"uploadFile"</Subscript>
<Value name="1">
<Value>ApiResponse</Value>
</Value>
</Data>
<DefaultData>uploadFileDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
