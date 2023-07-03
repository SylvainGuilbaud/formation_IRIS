Include FCE

/// Utilities for development
Class FCE.Tests.Utilities
{

/// Delete all data and run tests
ClassMethod DestroyAll()
{
	// if FCE.Currency exists but there's no data run FetchRates()
	if $$$ClassExists(FCE.Currency) && $$$MethodExists(FCE.Currency,FetchRates) {
		set sql = "SELECT COUNT(*) as currencies FROM FCE.Currency"
		set rs = ##class(%SQL.Statement).%ExecDirect( , sql)
		set SQLCODE = rs.%SQLCODE
		if (SQLCODE = 0) && (rs.%Next()) && (rs.currencies '= 10) {			
			do ##class(FCE.Currency).FetchRates()
			write !, "Fetched exchange rates"
		}
		elseif (SQLCODE < 0) {
			write !, "SQL error: ", SQLCODE, " ", %msg
		}
	}

	write !, "Deleted all "
	if $$$ClassExists(FCE.CurrencyOrder) {
		do ##class(FCE.CurrencyOrder).%KillExtent()
		write "CurrencyOrders, " 
	}	
	do ##class(FCE.Payment).%KillExtent()
	write "Payments, "
	do ##class(FCE.AccountHolder).%KillExtent()
	write "AccountHolders, "
	do ##class(FCE.Branch).%DeleteExtent()  // also deletes FCE.Branch Notes stream data
	write "Branches, "
	do ##class(FCE.RealEstate).%KillExtent()
	write "RealEstates"
	read !, "Data deleted. Press <Enter> to run tests.", x

	do ##class(FCE.Tests.BasicTests).Run()
	read !, "Press <Enter> to continue.", x
	if $$$ClassExists(FCE.Tests.CurrencyOrderTests) {	
		do ##class(FCE.Tests.CurrencyOrderTests).Run()
		read !, "Press <Enter> to continue.", x
	}
	do ##class(FCE.Tests.PaymentTests).Run()
}

/// Create data and run tests
ClassMethod CreateAll(base As %Integer = 5)
{
	// if FCE.Currency exists but there's no data run FetchRates()
	if $$$ClassExists(FCE.Currency) && $$$MethodExists(FCE.Currency,FetchRates) {
		set sql = "SELECT COUNT(*) as currencies FROM FCE.Currency"
		set rs = ##class(%SQL.Statement).%ExecDirect( , sql)
		set SQLCODE = rs.%SQLCODE
		if (SQLCODE = 0) && (rs.%Next()) && (rs.currencies '= 10) {			
			do ##class(FCE.Currency).FetchRates()
			write !, "Fetched exchange rates"
		}
		elseif (SQLCODE < 0) {
			write !, "SQL error: ", SQLCODE, " ", rs.%Message
		}
	}
	
	write !, "Populated "
	set count = ##class(FCE.RealEstate).Populate(base * 10)
	write count, " RealEstates, "
	set count = ##class(FCE.Branch).Populate(base * 3)
	write count, " Branches, "
	set count = ##class(FCE.AccountHolder).Populate(base * 3)
	write count, " AccountHolders, "
	if $$$ClassExists(FCE.CurrencyOrder) {
		set count = ##class(FCE.CurrencyOrder).Populate(base * 6)
		write count, " CurrencyOrders"
	}
	read !, "Data added. Press <Enter> to run tests.", x

	do ##class(FCE.Tests.BasicTests).Run()
	read !, "Press <Enter> to continue.", x
	if $$$ClassExists(FCE.Tests.CurrencyOrderTests) {
		do ##class(FCE.Tests.CurrencyOrderTests).Run()
		read !, "Press <Enter> to continue.", x
	}
	do ##class(FCE.Tests.PaymentTests).Run()
}

/// Generate currency name for use as collection key
ClassMethod Currency() As FCE.CurrencyName
{
	set abbreviations = ##class(FCE.CurrencyName).#VALUELIST
	return ##class(%PopulateUtils).ValueList(abbreviations)
}

/// Generate credit card numbers
ClassMethod CreditCardNumber() As %String
{
	return ($Random(9000) + 1000) _ "-"
		 _ ($Random(9000) + 1000) _ "-"
		 _ ($Random(9000) + 1000) _ "-"
		 _ ($Random(9000) + 1000)
}

/// helper method for tests
ClassMethod CreateOrder() As FCE.CurrencyOrder
{
	#dim branch as FCE.Branch
	set branch = ##class(FCE.Branch).%New()
	set branch.Phone = ##class(%PopulateUtils).USPhone()
	do branch.CurrencyBalances.SetAt(250, "EUR")
	do branch.CurrencyBalances.SetAt(50, "USD")
	#dim order as FCE.CurrencyOrder
	set order = ##class(FCE.CurrencyOrder).%New(branch,
												"Smith,John",
												"Smith@abcd.com",
												"EUR", "USD", 100)
	set order.ATM = ##class(%PopulateUtils).String(5)_##class(%PopulateUtils).String(5)
	// override %New() AmountOut calculation for testing purposes
	set order.AmountOut = 95
	return order
}

/// helper method for tests
ClassMethod CreateAccount() As FCE.AccountHolder
{
	#dim account as FCE.AccountHolder	
	set account = ##class(FCE.AccountHolder).%New()
	set account.Name = "Smith,John"
	set account.Email = "Smith@zzz.com"
	set account.Home.Street = "10 High St."
	set account.Home.City = "Cambridge"
	set account.Home.State = "MA"
	set account.Home.Zip = "02142"
	set work = account.Home.%ConstructClone()
	set account.Work = work
	set account.DOB = $zdh("01/01/1980")
	set account.Balance = 1000
	set account.Currency = "USD"
	return account
}

}
