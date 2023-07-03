Class FCE.Tests.CurrencyOrderTests Extends FCE.Tests.TestCase
{

/// test unified trigger FCE.CurrencyOrder UpdateDeleteInNotes for updates and deletes
Method TestCOTrigger()
{
 	if '$$$TriggerExists(FCE.CurrencyOrder,UpdateDeleteInNotes) {
		do $$$AssertSkipped("Can't run test yet")
		quit
	}
	
	// create branch
	#dim branch as FCE.Branch
	set branch = ##class(FCE.Branch).%New()
	set branch.Phone = "999-999-0000"
	do branch.CurrencyBalances.SetAt(250, "EUR")
	do branch.CurrencyBalances.SetAt(50, "USD")
	set status = branch.%Save()
	do $$$AssertStatusOK(status, "Branch saved")
	
	// create order
	#dim order as FCE.CurrencyOrder
	set order = ##class(FCE.CurrencyOrder).%New()
	set order.Branch = branch
	set order.ATM = "a111"
	set order.CurrencyOut = "EUR"
	set order.AmountOut = 95
	set order.CurrencyIn = "USD"
	set order.AmountIn = 100
	set order.Requestor = "Smith,John"
	set order.RequestorEmail = "Smith@abcd.com"
	set status = order.%Save()
	do $$$AssertStatusOK(status, "Order saved")
		
	set order.Fee = 50
	set status = order.%Save()
	do $$$AssertStatusOK(status, "Fee changed, Order saved")
	
	#dim notes as %Stream.GlobalCharacter
	set notes = order.Branch.Notes
	set length1 = notes.Size
	do $$$AssertTrue(length1 > 0, "Branch notes got longer")
	set found = notes.FindAt(1, "updated")
	do $$$AssertTrue((found '= -1), "Branch notes contain an ""update"" entry")
	
	// delete order
	set orderID = order.%Id()
	&sql(DELETE FROM fce.currencyorder WHERE ID = :orderID)
	do $$$AssertEquals(SQLCODE, 0, "Order deleted")

	set length2 = notes.Size
	do $$$AssertTrue(length2 > length1, "Branch notes got longer again")
	set found = notes.FindAt(1, "deleted")
	do $$$AssertTrue((found '= -1), "Branch notes contain a ""delete"" entry")

	// delete Branch
	set status = ##class(FCE.Branch).%DeleteId(branch.%Id())
	do $$$AssertStatusOK(status, "Branch deleted")
}

/// test FCE.Operations.Branch.ProcessOrder()
Method TestProcessOrder()
{
	// create order #1
	#dim order1 as FCE.CurrencyOrder
	set order1 = ##class(FCE.Tests.Utilities).CreateOrder()
	#dim payment1 as FCE.Cash
	set payment1 = ##class(FCE.Cash).%New()
	set status = ##class(FCE.Operations.Branch).ProcessOrder(order1, payment1, , .message1)
	do $$$AssertStatusOK(status, "Order #1 processed and saved")
	do $$$AssertNotEquals(message1, "", "Message returned")
	do $$$AssertEquals(order1.Status, "Completed", "Order #1 completed")
	set euros = order1.Branch.CurrencyBalances.GetAt("EUR")
	set dollars = order1.Branch.CurrencyBalances.GetAt("USD")
	do $$$AssertEquals(dollars, 150, "Incoming Currency updated in branch")
	do $$$AssertEquals(euros, 155, "Outgoing Currency updated in branch")

	// create account for order #2
	#dim account as FCE.AccountHolder
	set account = ##class(FCE.Tests.Utilities).CreateAccount()
	
	// create order #2
	#dim order2 as FCE.CurrencyOrder
	set order2 = ##class(FCE.Tests.Utilities).CreateOrder()
	#dim payment2 as FCE.AccountPayment
	set payment2 = ##class(FCE.AccountPayment).%New()
	set order2.AmountIn = 1100 // change incoming amount so it's greater than account balance
	set order2.CurrencyIn = "CHF" // change incoming currency so it doesn't match account
	set status = ##class(FCE.Operations.Branch).ProcessOrder(order2, payment2, account, .message2)
	do $$$AssertStatusOK(status, "Order #2 processed and saved")
	do $$$AssertEquals(message2, "", "Message not returned")
	do $$$AssertEquals(order2.Status, "Rejected", "Order #2 rejected-insufficient funds in account")
	do $$$AssertNotEquals(account.Balance, 900, "Account payment not completed")
	set order2.AmountIn = 100 // change incoming amount back
	set status = ##class(FCE.Operations.Branch).ProcessOrder(order2, payment2, account, .message2)
	do $$$AssertStatusOK(status, "Order #2 processed and saved")
	do $$$AssertEquals(message2, "", "Message not returned")
	do $$$AssertEquals(order2.Status, "Rejected", "Order #2 rejected-account has wrong currency")
	do $$$AssertNotEquals(account.Balance, 900, "Account payment not completed")
	set order2.CurrencyIn = "USD" // correct incoming currency
	set status = ##class(FCE.Operations.Branch).ProcessOrder(order2, payment2, account, .message2)
	do $$$AssertStatusOK(status, "Order #2 processed and saved")
	do $$$AssertEquals(order2.Status, "Completed", "Order #2 completed")
	do $$$AssertNotEquals(message2, "", "Message returned")
	do $$$AssertEquals(account.Balance, 900, "Account payment completed")
	set euros = order2.Branch.CurrencyBalances.GetAt("EUR")
	do $$$AssertEquals(euros, 155, "Outgoing Currency updated in branch")

	// create order #3
	#dim order3 as FCE.CurrencyOrder
	set order3 = ##class(FCE.Tests.Utilities).CreateOrder()
	#dim payment3 as FCE.CreditCard
	set payment3 = ##class(FCE.CreditCard).%New()
	set payment3.Type = "Visa"
	set payment3.Number = "1234-4444-3333-2222"
	set payment3.ExpirationDate = ($h + 1095)
	set status = ##class(FCE.Operations.Branch).ProcessOrder(order3, payment3, , .message3)
	do $$$AssertStatusOK(status, "Order #3 processed and saved")
	do $$$AssertEquals(order3.Status, "Completed", "Order #3 completed")
	do $$$AssertNotEquals(message3, "", "Message returned")
	set euros = order3.Branch.CurrencyBalances.GetAt("EUR")
	do $$$AssertEquals(euros, 155, "Outgoing Currency updated in branch")

	// create order #4 to test rollback
	#dim order4 as FCE.CurrencyOrder
	set order4 = ##class(FCE.Tests.Utilities).CreateOrder()
	set order4.AmountOut = 10000  // this causes a Problem status rather than Rejected
	#dim payment4 as FCE.CreditCard
	set payment4 = ##class(FCE.CreditCard).%New()
	set payment4.Type = "Visa"
	set payment4.Number = "1234-4444-3333-2222"
	set payment4.ExpirationDate = ($h + 1095)
	set status = ##class(FCE.Operations.Branch).ProcessOrder(order4, payment4, , .message4)
	set paymentID = payment4.%Id()
	do $$$AssertNotEquals(paymentID, "", "Order #4 Payment saved")
	do $$$AssertStatusNotOK(status, "Order #4 processed and saved, but has a problem")
	do $$$AssertEquals(order4.Status, "Problem", "Order #4's Status=Problem")
	do $$$AssertEquals(message4, "", "Message not returned")
	&sql(select verificationID from FCE.Payment where ID = :paymentID)
	do $$$AssertEquals(SQLCODE, 100, "Rollback deleted order #4 saved payment")

	// delete orders and payments
	set branch1ID = order1.Branch.%Id()
	set status = ##class(FCE.CurrencyOrder).%DeleteId(order1.%Id())
	do $$$AssertStatusOK(status, "Order #1 deleted")
	set branch2ID = order2.Branch.%Id()
	set status = ##class(FCE.CurrencyOrder).%DeleteId(order2.%Id())	
	do $$$AssertStatusOK(status, "Order #2 deleted")
	set branch3ID = order3.Branch.%Id()
	set status = ##class(FCE.CurrencyOrder).%DeleteId(order3.%Id())	
	do $$$AssertStatusOK(status, "Order #3 deleted")
	set branch4ID = order4.Branch.%Id()
	set status = ##class(FCE.CurrencyOrder).%DeleteId(order4.%Id())	
	do $$$AssertStatusOK(status, "Order #4 deleted")
	// delete branches
	&sql(DELETE FROM FCE.Branch WHERE ID IN (:branch1ID, :branch2ID, :branch3ID, :branch4ID))
	do $$$AssertEquals(SQLCODE, 0, "All branches deleted")
	// delete account
	set status = ##class(FCE.AccountHolder).%DeleteId(account.%Id())	
	do $$$AssertStatusOK(status, "Account deleted")
}

}
