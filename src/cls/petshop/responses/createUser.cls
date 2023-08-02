Class petshop.responses.createUser Extends petshop.responses.GenericResponse [ ProcedureBlock ]
{

/// http status code = default content-type = application/json
/// http status code = default content-type = application/xml
/// 
Property User As petshop.model.User(XMLNAME = "user");

/// Implement operationId : createUser
/// post /user
Method LoadFromResponse(httpResponse As %Net.HttpResponse, caller As %String = "") As %Status
{
	Set sc = $$$OK
	Do ##super(httpResponse, caller)
	If $$$LOWER($Piece(httpResponse.ContentType,";",1))="application/json",httpResponse.StatusCode = "default" {
		Set ..User = ##class(petshop.model.User).%New()
		Do ..User.%JSONImport(httpResponse.Data)
		Return sc
	}
	If $$$LOWER($Piece(httpResponse.ContentType,";",1))="application/xml",httpResponse.StatusCode = "default" {
		Set reader = ##class(%XML.Reader).%New()
		$$$QuitOnError(reader.OpenStream(httpResponse.Data))
		Do reader.Correlate("user","petshop.model.User")
		Do reader.Next(.User, .sc)
		If $$$ISERR(sc) Quit sc
		Set ..User = User
		Return sc
	}
	Quit sc
}

Storage Default
{
<Data name="createUserDefaultData">
<Subscript>"createUser"</Subscript>
<Value name="1">
<Value>User</Value>
</Value>
</Data>
<DefaultData>createUserDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
