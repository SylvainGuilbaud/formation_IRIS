Class petshop.responses.getPetById Extends petshop.responses.GenericResponse [ ProcedureBlock ]
{

/// http status code = 200 content-type = application/xml
/// http status code = 200 content-type = application/json
/// 
Property Pet As petshop.model.Pet(XMLNAME = "pet");

/// Implement operationId : getPetById
/// get /pet/{petId}
Method LoadFromResponse(httpResponse As %Net.HttpResponse, caller As %String = "") As %Status
{
	Set sc = $$$OK
	Do ##super(httpResponse, caller)
	If $$$LOWER($Piece(httpResponse.ContentType,";",1))="application/xml",httpResponse.StatusCode = "200" {
		Set reader = ##class(%XML.Reader).%New()
		$$$QuitOnError(reader.OpenStream(httpResponse.Data))
		Do reader.Correlate("pet","petshop.model.Pet")
		Do reader.Next(.Pet, .sc)
		If $$$ISERR(sc) Quit sc
		Set ..Pet = Pet
		Return sc
	}
	If $$$LOWER($Piece(httpResponse.ContentType,";",1))="application/json",httpResponse.StatusCode = "200" {
		Set ..Pet = ##class(petshop.model.Pet).%New()
		Do ..Pet.%JSONImport(httpResponse.Data)
		Return sc
	}
	Quit sc
}

Storage Default
{
<Data name="getPetByIdDefaultData">
<Subscript>"getPetById"</Subscript>
<Value name="1">
<Value>Pet</Value>
</Value>
</Data>
<DefaultData>getPetByIdDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
