Class data.client2 Extends (%Persistent, %Populate, %JSON.Adaptor, %XML.Adaptor)
{

Property name As %String(MAXLEN = 200);

Property code As %String;

Property description As %String(MAXLEN = "");

Storage Default
{
<Data name="client2DefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>code</Value>
</Value>
<Value name="4">
<Value>description</Value>
</Value>
</Data>
<DataLocation>^data.client2D</DataLocation>
<DefaultData>client2DefaultData</DefaultData>
<IdLocation>^data.client2D</IdLocation>
<IndexLocation>^data.client2I</IndexLocation>
<StreamLocation>^data.client2S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
