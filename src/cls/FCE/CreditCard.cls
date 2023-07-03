/// Processing for credit card payments
Class FCE.CreditCard Extends FCE.Payment
{

Property Number As %String(PATTERN = "3(4n1""-"")4n", POPSPEC = "##class(FCE.Tests.Utilities).CreditCardNumber()");

Property Type As %String(VALUELIST = "-Visa-MC-AmEx-Discover-Diners");

///  expires within next 5 years 
Property ExpirationDate As %Date(MAXVAL = "$zdh(""t+1825"",5)", MINVAL = "$zdh(""t"",5)");

Method Process(order As FCE.CurrencyOrder, Output creditCardString As %String = "") As %Status
{
	set status = ##super(order, .paymentString)
	if ($$$ISERR(status)) { return status }
	else {
		#dim branch as FCE.Branch
		set branch = order.Branch
		// debit branch
		set status = branch.Update(order.CurrencyOut, order.AmountOut)
		set paymentSaved = ..%Save()								
		set status = $$$ADDSC(status, paymentSaved)
		if $$$ISOK(status) {
			set creditCardString = paymentString _ $$$NL
		        _ ..Type _ " transaction for "
		        _ order.AmountIn _ " "
		        _ order.CurrencyIn _ " completed"
		    	_ " (card ending in " _ $piece(..Number, "-", 4) _ ")."
		}
		return status
	}
}

Storage Default
{
<Data name="CreditCardDefaultData">
<Subscript>"CreditCard"</Subscript>
<Value name="1">
<Value>Number</Value>
</Value>
<Value name="2">
<Value>Type</Value>
</Value>
<Value name="3">
<Value>ExpirationDate</Value>
</Value>
</Data>
<DefaultData>CreditCardDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
