Class data.patient Extends Ens.Request
{

Property lastname As %StringZ [ InitialExpression = {##class(%PopulateUtils).LastName()} ];

Property firstname As %String [ InitialExpression = {##class(%PopulateUtils).FirstName()} ];

Property sendingApp As %String [ InitialExpression = {##class(%PopulateUtils).Company()} ];

Property receivingApp As %String [ InitialExpression = {##class(%PopulateUtils).Company()} ];

Property eventDate As %TimeStamp [ InitialExpression = {$zdt($h,3)} ];

Storage Default
{
<Data name="patientDefaultData">
<Subscript>"patient"</Subscript>
<Value name="1">
<Value>lastname</Value>
</Value>
<Value name="2">
<Value>firstname</Value>
</Value>
<Value name="3">
<Value>sendingApp</Value>
</Value>
<Value name="4">
<Value>receivingApp</Value>
</Value>
<Value name="5">
<Value>eventDate</Value>
</Value>
</Data>
<DefaultData>patientDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
