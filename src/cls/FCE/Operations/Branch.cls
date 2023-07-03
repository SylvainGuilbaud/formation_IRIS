Include (%occStatus, %occConstant)

/// Facade for branch operations
Class FCE.Operations.Branch
{

Parameter FEERATE = .025;

/// Perform calculations for a request
ClassMethod GetAmountOutAndFee(amountIn As %Numeric, exchangeRate As %Decimal, Output fee As %Numeric, Output amountOut As %Numeric) As %Status [ SqlProc ]
{
	set fee = amountIn * ..#FEERATE
	set amountOut = (amountIn - fee) * exchangeRate
	return $$$OK
}

/// Process an order, with a payment (optionally made from an account)
/// 1. Link objects
/// 2. Prepare for transaction
/// 3. Tstart, process payment, Tcommit
/// 4. Report errors, set error status
ClassMethod ProcessOrder(order As FCE.CurrencyOrder, payment As FCE.Payment, account As FCE.AccountHolder = "", ByRef message As %String) As %Status
{
	if $IsObject(account) { set order.AccountHolder = account }
	
	set UTCTimeStamp = $system.SYS.TimeStamp()
	set order.DateStamp = $p(UTCTimeStamp, ",", 1)
	set order.TimeStamp = $p(UTCTimeStamp, ",", 2)
	set status = $$$OK, message = "" // initialize
	

	// check that account has valid and sufficient currency
	if $IsObject(account) &&
	       ( (account.Currency '= order.CurrencyIn) ||
	         (account.Balance < order.AmountIn) ) {
		set order.Status = "Rejected"
	}
	else {
		tstart // start a nested transaction
		set status = payment.Process(order, .message)

		if $$$ISERR(status)
		{
			set order.Status = "Problem"
			trollback 1
		}
		else {
			set order.Payment = payment
			set order.Status = "Completed"
			tcommit
		}
	}
	set orderSaved = order.%Save()
	set finalStatus = $$$ADDSC(status, orderSaved)
	if ($$$ISERR(finalStatus)) {return finalStatus}
	else {
		do ..SendConfirmation(order)
		return $$$OK
	}
}

/// Send email confirmation for processed order
ClassMethod SendConfirmation(order As FCE.CurrencyOrder) As %Status
{
	//disabled for now; comment following line to enable
	return 1
	// define an smtp server
	#dim mailServer as %Net.SMTP
	set mailServer = ##class(%Net.SMTP).%New()
	set mailServer.smtpserver = "localhost" ; use MailSlurper in ReadyTech VM by default
	set mailServer.timezone = "-0500"  ; your timezone
	// define a message
	#dim message as %Net.MailMessage
	set message = ##class(%Net.MailMessage).%New()
	set message.Subject = "Confirmation of " _ order.Status _ " currency exchange"
	set message.From = "auto-confirm@fcxbank.com"
	do message.To.Insert(order.RequestorEmail)
	// add text
	set line(1) = "Hello " _ order.Requestor
	set line(2) = $$$NL _ $$$NL _ "Your exchange of " _ order.AmountIn _ " " _ order.CurrencyIn
	set line(3) = $$$NL _ $justify("for ",17) _ order.AmountOut _ " " _ order.CurrencyOut
	set line(4) = $$$NL _ "has been " _ order.Status _ "."
	for i=1:1:4 {
		do message.TextData.Write(line(i))
	}
	// send the email
	set status = mailServer.Send(message)
	return status
}

}
