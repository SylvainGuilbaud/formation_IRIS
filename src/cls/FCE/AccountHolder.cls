/// Customer with accounts
Class FCE.AccountHolder Extends FCE.PersistentPerson
{

/// Current account balance
Property Balance As %Numeric(MINVAL = 0);

/// Type of currency that this account holds
Property Currency As FCE.CurrencyName [ Required ];

/// Exchanges that this customer made
Relationship CurrencyOrders As FCE.CurrencyOrder [ Cardinality = many, Inverse = AccountHolder ];

/// Debit account balance and save account
Method Update(paymentAmount As %Numeric) As %Status
{
	set ..Balance = ..Balance - paymentAmount
	return $$$OK
}

Storage Default
{
<Data name="AccountHolderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Balance</Value>
</Value>
<Value name="3">
<Value>Currency</Value>
</Value>
<Value name="4">
<Value>Email</Value>
</Value>
<Value name="5">
<Value>DOB</Value>
</Value>
<Value name="6">
<Value>Home</Value>
</Value>
<Value name="7">
<Value>Work</Value>
</Value>
<Value name="8">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^FCE.AccountHolderD</DataLocation>
<DefaultData>AccountHolderDefaultData</DefaultData>
<IdLocation>^FCE.AccountHolderD</IdLocation>
<IndexLocation>^FCE.AccountHolderI</IndexLocation>
<StreamLocation>^FCE.AccountHolderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
