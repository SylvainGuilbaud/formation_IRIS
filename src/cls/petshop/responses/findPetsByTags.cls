Class petshop.responses.findPetsByTags Extends petshop.responses.GenericResponse [ ProcedureBlock ]
{

/// http status code = 200 content-type = application/xml
/// http status code = 200 content-type = application/json
/// 
Property ListOfPet As list Of petshop.model.Pet;

/// Implement operationId : findPetsByTags
/// get /pet/findByTags
Method LoadFromResponse(httpResponse As %Net.HttpResponse, caller As %String = "") As %Status
{
	Set sc = $$$OK
	Do ##super(httpResponse, caller)
	If $$$LOWER($Piece(httpResponse.ContentType,";",1))="application/xml",httpResponse.StatusCode = "200" {
		Set reader = ##class(%XML.Reader).%New()
		$$$QuitOnError(reader.OpenStream(httpResponse.Data))
		Do reader.Correlate("pet","petshop.model.Pet")
		While reader.Next(.Pet, .sc) {
			Return:$$$ISERR(sc) sc
			Do ..ListOfPet.Insert(Pet)
		}
		Return sc
	}
	If $$$LOWER($Piece(httpResponse.ContentType,";",1))="application/json",httpResponse.StatusCode = "200" {
		Set array = [].%FromJSON(httpResponse.Data), iterator = array.%GetIterator()
		While iterator.%GetNext(.index, .item) {
			Set obj = ##class(petshop.model.Pet).%New()
			Do obj.%JSONImport(item), ..ListOfPet.Insert(obj)
		}
		Return sc
	}
	Quit sc
}

Storage Default
{
<Data name="findPetsByTagsDefaultData">
<Subscript>"findPetsByTags"</Subscript>
<Value name="1">
<Value>ListOfPet</Value>
</Value>
</Data>
<DefaultData>findPetsByTagsDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
