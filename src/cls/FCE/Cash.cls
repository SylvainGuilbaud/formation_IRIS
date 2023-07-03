/// Processing for cash payments
Class FCE.Cash Extends FCE.Payment
{

Method Process(order As FCE.CurrencyOrder, Output cashPaymentString As %String = "") As %Status
{
	set status = ##super(order, .paymentString)
	if ($$$ISERR(status)) { return status }
	else {
		#dim branch as FCE.Branch
		set branch = order.Branch
		// debit and credit branch only
		set status = branch.Update(order.CurrencyOut,
								   order.AmountOut,
								   order.CurrencyIn,
								   order.AmountIn)	
		set paymentSaved = ..%Save()								
		set status = $$$ADDSC(status, paymentSaved)
		if $$$ISOK(status) {
			set cashPaymentString = paymentString _ $$$NL
			    _ "Cash payment of "
			    _ order.AmountIn _ " "
			    _ order.CurrencyIn _ " verified."
		}
		return status
	}
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
