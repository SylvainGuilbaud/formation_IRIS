Class data.article Extends (%SerialObject, %Populate)
{

Property name As %String(MAXLEN = 200, MINLEN = 10);

Property code As %String(MAXLEN = 5, MINLEN = 5);

Property description As %String(MAXLEN = "");

Property unitPrice As %Currency;

Property valid As %Boolean [ InitialExpression = 1 ];

Storage Default
{
<Data name="articleState">
<Value name="1">
<Value>name</Value>
</Value>
<Value name="2">
<Value>code</Value>
</Value>
<Value name="3">
<Value>description</Value>
</Value>
<Value name="4">
<Value>unitPrice</Value>
</Value>
<Value name="5">
<Value>valid</Value>
</Value>
</Data>
<State>articleState</State>
<StreamLocation>^data.articleS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
