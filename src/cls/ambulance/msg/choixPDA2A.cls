Class ambulance.msg.choixPDA2A Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor)
{

Property episode As %Integer;

Property adresse As %String(MAXLEN = 256);

Index episodeKey On episode [ IdKey ];

Storage Default
{
<Data name="choixPDA2ADefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>adresse</Value>
</Value>
</Data>
<DataLocation>^ambulance.msg.choixPDA2AD</DataLocation>
<DefaultData>choixPDA2ADefaultData</DefaultData>
<IdLocation>^ambulance.msg.choixPDA2AD</IdLocation>
<IndexLocation>^ambulance.msg.choixPDA2AI</IndexLocation>
<StreamLocation>^ambulance.msg.choixPDA2AS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
