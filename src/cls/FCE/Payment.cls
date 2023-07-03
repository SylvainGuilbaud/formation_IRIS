/// Abstract class for payments for exchanges
Class FCE.Payment Extends (%Persistent, %Populate, %XML.Adaptor) [ Abstract ]
{

Property VerificationID As %String [ InitialExpression = {##class(%PopulateUtils).String(5)} ];

Method Process(order As FCE.CurrencyOrder, Output paymentString As %String = "") As %Status
{
	if (order = "") { 
	    return $$$ERROR($$$GeneralError, "No associated currency order")}
	elseif (order.Branch = "") {
		return $$$ERROR($$$GeneralError, "No associated branch")}
	else {
		set paymentString = "Re: your request of: "
		    _ order.AmountOut _ " " 
        	_ order.CurrencyOut _ ", at an exchange rate of: "
        	_ order.ExchangeRate _ " "
        	_ order.CurrencyOut _ " per 1 "
        	_ order.CurrencyIn _ " (Verification ID: "
        	_ ..VerificationID _ ")..."
        return $$$OK
	}
}

/// Automatically creates indexes of subclass extents
Index BitmapExtent [ Extent, Type = bitmap ];

Storage Default
{
<Data name="PaymentDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>VerificationID</Value>
</Value>
</Data>
<DataLocation>^FCE.PaymentD</DataLocation>
<DefaultData>PaymentDefaultData</DefaultData>
<IdLocation>^FCE.PaymentD</IdLocation>
<IndexLocation>^FCE.PaymentI</IndexLocation>
<StreamLocation>^FCE.PaymentS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
