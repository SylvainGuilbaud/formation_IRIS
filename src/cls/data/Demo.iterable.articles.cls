Class Demo.iterable.articles Extends (%SerialObject, %Populate)
{

/// Name
Property Name As %String;

/// Description
Property Description As %String;

/// Price
Property Price As %Numeric;

Storage Default
{
<Data name="articlesState">
<Value name="1">
<Value>Name</Value>
</Value>
<Value name="2">
<Value>Description</Value>
</Value>
<Value name="3">
<Value>Price</Value>
</Value>
</Data>
<State>articlesState</State>
<StreamLocation>^Demo.iterable.articlesS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
