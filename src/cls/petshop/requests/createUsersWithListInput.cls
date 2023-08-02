Class petshop.requests.createUsersWithListInput Extends Ens.Request [ ProcedureBlock ]
{

Parameter METHOD = "post";

Parameter URL = "/user/createWithList";

Property %Consume As %String;

Property %ContentType As %String;

Property %URL As %String [ InitialExpression = {..#URL} ];

/// Use this property for body content with content-type = application/json.
Property listOfUser As list Of petshop.model.User(XMLITEMNAME = "user");

/// Load %Net.HttpRequest with this property object.
Method LoadHttpRequestObject(ByRef httpRequest As %Net.HttpRequest) As %Status
{
	Set sc = $$$OK
	Set httpRequest.ContentType = ..%ContentType
	Do httpRequest.SetHeader("accept", ..%Consume)
	If $Piece($$$LOWER(..%ContentType),";",1) = "application/json"{

		Set key = "", array = []
		For  {
			Set tmpObject = ..listOfUser.GetNext(.key)
			Quit:key=""
			Do tmpObject.%JSONExportToStream(.tmpStream), array.%Push({}.%FromJSON(tmpStream))
			Kill tmpStream
		}

		Do array.%ToJSON(httpRequest.EntityBody)
	}
	Quit sc
}

Storage Default
{
<Data name="createUsersWithListInputDefaultData">
<Subscript>"createUsersWithListInput"</Subscript>
<Value name="1">
<Value>%Consume</Value>
</Value>
<Value name="2">
<Value>%ContentType</Value>
</Value>
<Value name="3">
<Value>%URL</Value>
</Value>
<Value name="4">
<Value>listOfUser</Value>
</Value>
</Data>
<DefaultData>createUsersWithListInputDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
