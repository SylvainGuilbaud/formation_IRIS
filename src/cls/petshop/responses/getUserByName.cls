Class petshop.responses.getUserByName Extends petshop.responses.GenericResponse [ ProcedureBlock ]
{

/// http status code = 200 content-type = application/xml
/// http status code = 200 content-type = application/json
/// 
Property User As petshop.model.User(XMLNAME = "user");

/// Implement operationId : getUserByName
/// get /user/{username}
Method LoadFromResponse(httpResponse As %Net.HttpResponse, caller As %String = "") As %Status
{
	Set sc = $$$OK
	Do ##super(httpResponse, caller)
	If $$$LOWER($Piece(httpResponse.ContentType,";",1))="application/xml",httpResponse.StatusCode = "200" {
		Set reader = ##class(%XML.Reader).%New()
		$$$QuitOnError(reader.OpenStream(httpResponse.Data))
		Do reader.Correlate("user","petshop.model.User")
		Do reader.Next(.User, .sc)
		If $$$ISERR(sc) Quit sc
		Set ..User = User
		Return sc
	}
	If $$$LOWER($Piece(httpResponse.ContentType,";",1))="application/json",httpResponse.StatusCode = "200" {
		Set ..User = ##class(petshop.model.User).%New()
		Do ..User.%JSONImport(httpResponse.Data)
		Return sc
	}
	Quit sc
}

Storage Default
{
<Data name="getUserByNameDefaultData">
<Subscript>"getUserByName"</Subscript>
<Value name="1">
<Value>User</Value>
</Value>
</Data>
<DefaultData>getUserByNameDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
