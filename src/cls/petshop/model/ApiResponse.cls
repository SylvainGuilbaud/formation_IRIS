Class petshop.model.ApiResponse Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor) [ Inheritance = right, ProcedureBlock ]
{

Property code As %Integer;

Property message As %String(MAXLEN = "");

Property type As %String(MAXLEN = "");

Storage Default
{
<Data name="ApiResponseDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>code</Value>
</Value>
<Value name="3">
<Value>message</Value>
</Value>
<Value name="4">
<Value>type</Value>
</Value>
</Data>
<DataLocation>^petshop.model.ApiResponseD</DataLocation>
<DefaultData>ApiResponseDefaultData</DefaultData>
<IdLocation>^petshop.model.ApiResponseD</IdLocation>
<IndexLocation>^petshop.model.ApiResponseI</IndexLocation>
<StreamLocation>^petshop.model.ApiResponseS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
