Class JDBC.demo.msg.customerRequest Extends Ens.Request
{

Property id As %Integer [ InitialExpression = {$random(1000)+1} ];

Property active As %Boolean [ InitialExpression = {$random(2)} ];

Property firstName As %String [ InitialExpression = {##class(%PopulateUtils).FirstName()} ];

Property lastName As %String [ InitialExpression = {##class(%PopulateUtils).LastName()} ];

Property city As %String [ InitialExpression = {##class(%PopulateUtils).City()} ];

Property category As %Integer [ InitialExpression = {$RANDOM(5)+1} ];

Property created As %TimeStamp [ InitialExpression = {$zdt($h-$RANDOM(1000)_","_$random(86400),3)} ];

Property hashtag As %String(MAXLEN = "");

Property gender As %String;

Property country As %String;

Storage Default
{
<Data name="customerRequestDefaultData">
<Subscript>"customerRequest"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
<Value name="2">
<Value>active</Value>
</Value>
<Value name="3">
<Value>firstName</Value>
</Value>
<Value name="4">
<Value>lastName</Value>
</Value>
<Value name="5">
<Value>city</Value>
</Value>
<Value name="6">
<Value>category</Value>
</Value>
<Value name="7">
<Value>created</Value>
</Value>
<Value name="8">
<Value>hashtag</Value>
</Value>
<Value name="9">
<Value>gender</Value>
</Value>
<Value name="10">
<Value>country</Value>
</Value>
</Data>
<DefaultData>customerRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
