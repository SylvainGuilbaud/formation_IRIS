Class HTTP.msg.genderRequest Extends Ens.Request
{

Property firstName As %String;

Storage Default
{
<Data name="genderRequestDefaultData">
<Subscript>"genderRequest"</Subscript>
<Value name="1">
<Value>firstName</Value>
</Value>
</Data>
<DefaultData>genderRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
