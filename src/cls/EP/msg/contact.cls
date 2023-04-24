Class EP.msg.contact Extends Ens.Request
{

/// Description
Property nom As %String;

/// Description
Property prenom As %String;

/// Description
Property email As %String;

Storage Default
{
<Data name="contactDefaultData">
<Subscript>"contact"</Subscript>
<Value name="1">
<Value>nom</Value>
</Value>
<Value name="2">
<Value>prenom</Value>
</Value>
<Value name="3">
<Value>email</Value>
</Value>
</Data>
<DefaultData>contactDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
