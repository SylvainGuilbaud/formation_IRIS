/// Mailing addresses for people
Class FCE.MailingAddress Extends (%SerialObject, FCE.Address)
{

Storage Default
{
<Data name="MailingAddressState">
<Value name="1">
<Value>Street</Value>
</Value>
<Value name="2">
<Value>City</Value>
</Value>
<Value name="3">
<Value>State</Value>
</Value>
<Value name="4">
<Value>Zip</Value>
</Value>
</Data>
<State>MailingAddressState</State>
<StreamLocation>^FCE.MailingAddressS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
