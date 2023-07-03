/// Processing for Account payments
Class FCE.AccountPayment Extends FCE.Payment
{

Method Process(order As FCE.CurrencyOrder, Output accountPaymentString As %String = "") As %Status
{
	set status = ##super(order, .paymentString)
	if ($$$ISERR(status)) { return status }
	else {
		#dim branch as FCE.Branch
		set branch = order.Branch
		#dim account as FCE.AccountHolder
		set account = order.AccountHolder
		// debit branch
		set branchStatus = branch.Update(order.CurrencyOut, order.AmountOut)
		// debit account							         
		set accountStatus = account.Update(order.AmountIn)
		
		set paymentSaved = ..%Save()								
		set status = $$$ADDSC(branchStatus, accountStatus)
		set status = $$$ADDSC(status, paymentSaved)
		if $$$ISOK(status) {
			set accountPaymentString = paymentString _ $$$NL
		    	_ "Thank you, " _ account.PrintName
		    	_ ", for your account payment of "
		    	_ order.AmountIn _ " "
		    	_ order.CurrencyIn _ "."
		}
		return status
	}
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
