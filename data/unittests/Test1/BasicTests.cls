Class FCE.Tests.BasicTests Extends FCE.Tests.TestCase
{

/// holds a referenced FCE.RealEstate object, assigned in OnBeforeAllTests()
Property RefdRealEstate As FCE.RealEstate [ Private ];

/// holds an unreferenced FCE.RealEstate object, assigned in OnBeforeAllTests()
Property UnrefdRealEstate As FCE.RealEstate [ Private ];

/// Set up test environment
Method OnBeforeAllTests() As %Status
{
 	// create a Branch with this phone #
 	#dim branch as FCE.Branch
	set branch = ##class(FCE.Branch).%New()
	set branch.Phone = "999-999-9999"
 
 	/* create a dummy RealEstate object, link it to the Branch above
       and save the object in the "global" RefdRealEstate property */
 	#dim realestate as FCE.RealEstate
	set realestate = ##class(FCE.RealEstate).%New()
	set realestate.Street = "10 Main Street"
	set realestate.City = "New York"
	set realestate.State = "NY"
	set realestate.Zip = "99999"
	set status = realestate.%Save()
	set branch.Address = realestate
	set status = branch.%Save()
	return:$$$ISERR(status) status
	set ..RefdRealEstate = realestate
	
	/* create a dummy RealEstate object that *isn't* referenced by a Branch
	   save the object in the "global" UnrefdRealEstate property */
	set realestate = ##class(FCE.RealEstate).%New()
	set realestate.Street = "20 Oak Street"
	set realestate.City = "Boston"
	set realestate.State = "MA"
	set realestate.Zip = "99999"
	set status = realestate.%Save()
	return:$$$ISERR(status) status
	set ..UnrefdRealEstate = realestate
 	return $$$OK
}

/// Clean up test environment
Method OnAfterAllTests() As %Status
{
	/// in case any tests fail to *complete*
	/// remove the leftover branch and the initial branch
	&sql(DELETE FROM FCE.Branch
	     WHERE (Phone = '999-999-9999') OR (Phone = '999-999-0000'))
	return:(SQLCODE < 0) $$$ERROR($$$SQLError,SQLCODE,%msg)
	set ID1 = ..RefdRealEstate.%Id(), ID2 = ..UnrefdRealEstate.%Id()
	&sql(DELETE FROM FCE.RealEstate WHERE ID IN (:ID1, :ID2))
	return:(SQLCODE < 0) $$$ERROR($$$SQLError,SQLCODE,%msg)
	return $$$OK
}

/// Basic tests for FCE.Branch
Method TestBranch()
{
	// assertion 1
 	#dim branch as FCE.Branch
	set branch = ##class(FCE.Branch).%New()
	do $$$AssertTrue($isobject(branch),"Created New Branch")	
	// assertion 2
	set status = branch.%Save()
	do $$$AssertStatusNotOK(status, "Phone is required")	
	// assertion 3
	set branch.Phone = "9999999999" // bad pattern
	set status = branch.%Save()
	do $$$AssertStatusNotOK(status, "Phone doesn't match pattern: ###-###-####")
	// assertion 4
	set branch.Phone = "999-999-9999" // pre-existing number
	set status = branch.%Save()
	do $$$AssertStatusNotOK(status, "Phone must be unique")
	// assertion 5
	set branch.Phone = "999-999-0000"
	set branch.Address = ..RefdRealEstate
	set status = branch.%Save()
	do $$$AssertStatusNotOK(status, "Another Branch already has this address")
	// assertion 6
	set branch.Address = ..UnrefdRealEstate
	set branch.Opens = 18000 // open at 5am
	set status = branch.%Save()
	do $$$AssertStatusNotOK(status, "Opening at 5am too early")	
	// assertion 7
	set branch.Opens = 28800 // open at 8am
	set branch.Closes = 82800 // close at 11pm
	set status = branch.%Save()
	do $$$AssertStatusNotOK(status, "Closing at 11pm too late")
	// assertion 8
	set branch.Closes = 64800 // close at 6pm
	set branch.NationalCurrency = "ABC" // invalid currency
	set status = branch.%Save()
	do $$$AssertStatusNotOK(status, "ABC is invalid currency")
	// assertion 9
	set branch.NationalCurrency = "USD" // valid currency
	set status = branch.%Save()
	do $$$AssertStatusOK(status, "Branch saved")
	// assertion 10
	set branchID = branch.%Id()
	do $$$AssertNotEquals(branchID, "", "ID assigned")
	// assertion 11
	set status = ##class(FCE.Branch).%DeleteId(branchID)
	do $$$AssertStatusOK(status, "Branch deleted")
}

/// SQL tests for FCE.Branch table
Method TestBranchSQL()
{
	set realestateID = ..UnrefdRealEstate.%Id()

	&sql(INSERT INTO FCE.Branch (Address)
	     VALUES (:realestateID))
	do $$$AssertEquals(SQLCODE, -108, "Phone is required")
	&sql(INSERT INTO FCE.Branch (Phone, Address)
	     VALUES ('9999999999',:realestateID))
	do $$$AssertEquals(SQLCODE, -104, "Phone doesn't match pattern: ###-###-####")
	&sql(INSERT INTO FCE.Branch (Phone, Address)
	     VALUES ('999-999-9999',:realestateID))
	do $$$AssertEquals(SQLCODE, -119, "Phone must be unique")
	&sql(INSERT INTO FCE.Branch (Phone, Address, Opens)
	     VALUES ('999-999-0000',:realestateID,18000))
	do $$$AssertEquals(SQLCODE, -104, "Opening at 5am too early")
	&sql(INSERT INTO FCE.Branch (Phone, Address, Opens, Closes)
	     VALUES ('999-999-0000',:realestateID,28800,82800))
	do $$$AssertEquals(SQLCODE, -104, "Closing at 11pm too late")
	&sql(INSERT INTO FCE.Branch (Phone, Address, Opens, Closes, NationalCurrency)
	     VALUES ('999-999-0000',:realestateID,28800,64800,'ABC'))
	do $$$AssertEquals(SQLCODE, -104, "ABC is invalid currency")
	&sql(INSERT INTO FCE.Branch (Phone, Address, Opens, Closes, NationalCurrency)
	     VALUES ('999-999-0000',:realestateID,28800,64800,'USD'))
	do $$$AssertEquals(SQLCODE, 0, "Branch saved")
	set branchID = %ROWID
	do $$$AssertNotEquals(branchID, "", "ID assigned")
	&sql(DELETE FROM FCE.Branch WHERE ID = :branchID)
	do $$$AssertEquals(SQLCODE, 0, "Branch deleted")
}

/// Basic tests for FCE.RealEstate
Method TestRealEstate()
{
 	#dim realestate as FCE.RealEstate
	set realestate = ##class(FCE.RealEstate).%New()
	set status = realestate.%Save()
	do $$$AssertStatusNotOK(status, "Real Estate requires all 4 properties")
	set realestate.Street = "10 Main St."
	set status = realestate.%Save()
	do $$$AssertStatusNotOK(status, "Real Estate requires all 4 properties")
	set realestate.City = "New York"
	set status = realestate.%Save()
	do $$$AssertStatusNotOK(status, "Real Estate requires all 4 properties")
	set realestate.State = "ny"
	set status = realestate.%Save()
	do $$$AssertStatusNotOK(status, "State must be on VALUELIST and must match case")
	set realestate.State = "NY"
	set status = realestate.%Save()
	do $$$AssertStatusNotOK(status, "Real Estate requires all 4 properties")
	set realestate.Zip = "123"
	set status = realestate.%Save()
	do $$$AssertStatusNotOK(status, "ZipCode must be ##### or #####-####")
	set realestate.Zip = "12345-1"
	set status = realestate.%Save()
	do $$$AssertStatusNotOK(status, "ZipCode must be ##### or #####-####")
	set realestate.Zip = "99999-4567"
	set status = realestate.%Save()
	set realestateID = realestate.%Id()
	do $$$AssertStatusOK(status, "Real Estate saved")
 	#dim branch as FCE.Branch
	set branch = ##class(FCE.Branch).%New()
	set branch.Phone = "999-999-0000"
	set branch.Address = realestate
	set status = branch.%Save()
	set branchID = branch.%Id()
	do $$$AssertStatusOK(status, "Branch saved")
	set (branch, realestate) = ""
	do $$$LogMessage("All objects closed")
	set branch = ##class(FCE.Branch).%OpenId(branchID)
	set realestate = ##class(FCE.RealEstate).%OpenId(realestateID)
	do $$$AssertEquals(branch.Address.City, realestate.City, "Branch references Real Estate")
	set (branch, realestate) = ""
	do $$$LogMessage("All objects closed")
	set status = ##class(FCE.RealEstate).%DeleteId(realestateID)
	do $$$AssertStatusOK(status, "Real Estate deleted")
	set realestateID = ##class(FCE.Branch).AddressGetStored(branchID)
	do $$$AssertEquals(realestateID, "", "Branch not linked to Real Estate")
	set status = ##class(FCE.Branch).%DeleteId(branchID)
	do $$$AssertStatusOK(status, "Branch deleted")
}

/// SQL tests for FCE.RealEstate table
Method TestRealEstateSQL()
{
	&sql(INSERT INTO FCE.RealEstate (Street) VALUES ('10 Main St.'))
	do $$$AssertEquals(SQLCODE, -108, "Real Estate requires all 4 properties")
	&sql(INSERT INTO FCE.RealEstate (Street,City) VALUES ('10 Main St.','New York'))
	do $$$AssertEquals(SQLCODE, -108, "Real Estate requires all 4 properties")
	&sql(INSERT INTO FCE.RealEstate (Street,City,State)
             VALUES ('10 Main St.','New York','ny'))
	do $$$AssertEquals(SQLCODE, -104, "State must be on VALUELIST and must match case")
	&sql(INSERT INTO FCE.RealEstate (Street,City,State)
             VALUES ('10 Main St.','New York','NY'))
	do $$$AssertEquals(SQLCODE, -108, "Real Estate requires all 4 properties")
	&sql(INSERT INTO FCE.RealEstate (Street,City,State,Zip) 
             VALUES ('10 Main St.','New York','NY','123'))
	do $$$AssertEquals(SQLCODE, -104, "ZipCode must be ##### or #####-####")
	&sql(INSERT INTO FCE.RealEstate (Street,City,State,Zip) 
             VALUES ('10 Main St.','New York','NY','12345-1'))
	do $$$AssertEquals(SQLCODE, -104, "ZipCode must be ##### or #####-####")
	&sql(INSERT INTO FCE.RealEstate (Street,City,State,Zip)
             VALUES ('10 Main St.','New York','NY','99999-4567'))
	do $$$AssertEquals(SQLCODE, 0, "Real Estate saved")
	set realestateID = %ROWID
	do $$$AssertNotEquals(realestateID, "", "Real Estate ID assigned")
	&sql(INSERT INTO FCE.Branch (Phone,Address) VALUES ('999-999-0000',:realestateID))
	do $$$AssertEquals(SQLCODE, 0, "Branch saved")
	set branchID = %ROWID
	&sql(SELECT Address->City INTO :city FROM FCE.Branch WHERE ID = :branchID)
	do $$$AssertEquals(SQLCODE, 0, "City retrieved")

	do $$$AssertEquals(city, "New York", "Branch references Real Estate")
	&sql(DELETE FROM FCE.RealEstate WHERE ID = :realestateID)
	do $$$AssertEquals(SQLCODE, 0, "Real Estate deleted")
	&sql(SELECT Address INTO :realestateID FROM FCE.Branch WHERE ID = :branchID)
	do $$$AssertEquals(SQLCODE, 0, "Real Estate ID retrieved")

	do $$$AssertEquals(realestateID, "", "Branch not linked to Real Estate")
	&sql(DELETE FROM FCE.Branch WHERE ID = :branchID)
	do $$$AssertEquals(SQLCODE, 0, "Branch deleted")
}

/// Basic tests for FCE.Branch CurrencyBalances and ATMs collections
Method TestCurrenciesATMs()
{
	if '$$$PropertyExists(FCE.Branch,CurrencyBalances) ||
	   '$$$PropertyExists(FCE.Branch,ATMs) {
		do $$$AssertSkipped("Can't run test yet")
		quit
	}

	#dim branch as FCE.Branch
	set branch = ##class(FCE.Branch).%New()
	set branch.Phone = "999-999-0000"
	do branch.CurrencyBalances.SetAt(9999999,"USD")
	set status = branch.%Save()
	do $$$AssertStatusNotOK(status, "Currency Balance must be <= 1000000")
	do branch.CurrencyBalances.SetAt(1000,"USD")
	/// test this AFTER writing %OnValidateObject()
	if $$$MethodExists(FCE.Branch,%OnValidateObject) {
		do branch.CurrencyBalances.SetAt(1000,"ABC")
		set status = branch.%Save()
		do $$$AssertStatusNotOK(status, $system.Status.GetErrorText(status))
		do branch.CurrencyBalances.RemoveAt("ABC")
	}	
	set status = branch.%Save()
	do $$$AssertStatusOK(status, "Branch with Currency Balance saved")
	set count = branch.CurrencyBalances.Count()
	do $$$AssertEquals(count, 1, "Branch has one Currency Balance")
	do branch.CurrencyBalances.RemoveAt("US")
	set count = branch.CurrencyBalances.Count()
	do $$$AssertNotEquals(count, 0, "RemoveAt() requires exact key")
	do branch.CurrencyBalances.RemoveAt("USD")
	set count = branch.CurrencyBalances.Count()
	do $$$AssertEquals(count, 0, "Currency Balance Removed")
	do branch.ATMs.Insert("a111")
	do branch.ATMs.Insert("b222")
	do branch.ATMs.Insert("c333")
	set count = branch.ATMs.Count()
	do $$$AssertEquals(count, 3, "Branch has three ATMs")
	do branch.ATMs.RemoveAt(2)
	set count = branch.ATMs.Count()
	do $$$AssertEquals(count, 2, "Branch's original 2nd ATM deleted")
	set ATM = branch.ATMs.GetAt(2)
	do $$$AssertEquals(ATM, "c333", "Branch's original 3rd ATM now in position 2")
	set status = ##class(FCE.Branch).%DeleteId(branch.%Id())
	do $$$AssertStatusOK(status, "Branch deleted")
}

/// SQL tests for FCE.Branch CurrencyBalances collection
Method TestCurrenciesSQL()
{
	if '$$$PropertyExists(FCE.Branch,CurrencyBalances) {
		do $$$AssertSkipped("Can't run test yet")
		quit
	}

	#sqlcompile mode=deferred
	&sql(INSERT INTO FCE.Branch (Phone) VALUES ('999-999-0000'))
	set branchID = %ROWID
	&sql(INSERT INTO FCE.Branch_Balance (Branch, element_key, Balance)
             VALUES (:branchID, 'USD', '9999999'))
	do $$$AssertEquals(SQLCODE, -104, "Currency Balance must be <= 1000000")
	&sql(INSERT INTO FCE.Branch_Balance (Branch, element_key, Balance)
             VALUES (:branchID, 'USD', '10000'))
	do $$$AssertEquals(SQLCODE, 0, "Branch with Currency Balance saved")
	&sql(SELECT COUNT(*) INTO :count FROM FCE.Branch_Balance WHERE Branch = :branchID)
	do $$$AssertEquals(SQLCODE, 0, "Currency Balance count retrieved")
	do $$$AssertEquals(count, 1, "Branch has one Currency Balance")
	&sql(DELETE FROM FCE.Branch_Balance WHERE (element_key = 'USD') AND (Branch = :branchID))
	do $$$AssertEquals(SQLCODE, 0, "Currency Balance removed")
	&sql(DELETE FROM FCE.Branch WHERE ID = :branchID)
	do $$$AssertEquals(SQLCODE, 0, "Branch deleted")
}

/// Basic tests for 1->M relationship between FCE.Branch and FCE.CurrencyOrder
Method TestCurrencyOrder()
{
 	if '$$$ClassExists(FCE.CurrencyOrder) {
		do $$$AssertSkipped("Can't run test yet")
		quit
	}
	
 	#dim branch as FCE.Branch
	set branch = ##class(FCE.Branch).%New()
	set branch.Phone = "999-999-0000"
	set status = branch.%Save()
	do $$$AssertStatusOK(status, "Branch saved")
	set branchID = branch.%Id()
	set countOfOrders = branch.Orders.Count()
	do $$$AssertEquals(countOfOrders, 0, "No orders yet")
	#dim order1 as FCE.CurrencyOrder
	set order1 = ##class(FCE.CurrencyOrder).%New()
	do $$$AssertTrue($isobject(order1), "Create order 1")
	set order1.ATM = "a111"
	set order1.Branch = branch
	set countOfOrders = branch.Orders.Count()
	do $$$AssertEquals(countOfOrders, 1, "Branch has 1 order")
	set status = order1.%Save()
	do $$$AssertStatusOK(status, "Order 1 saved")
	set order1ID = order1.%Id()
	do $$$AssertNotEquals(order1ID, "", "Order 1 ID assigned")
	#dim order2 as FCE.CurrencyOrder
	set order2 = ##class(FCE.CurrencyOrder).%New()
	do $$$AssertTrue($isobject(order2), "Create order 2")
	set order2.ATM = "b222"
	do branch.Orders.Insert(order2)
	set countOfOrders = branch.Orders.Count()
	do $$$AssertEquals(countOfOrders, 2, "Branch has 2 orders")
	set status = branch.%Save()
	do $$$AssertStatusOK(status, "Branch and order 2 saved")
	set order2ID = order2.%Id()
	do $$$AssertNotEquals(order2ID, "", "Order 2 ID assigned")
	set (branch, order1, order2) = ""
	do $$$LogMessage("All objects closed")
	set order2 = ##class(FCE.CurrencyOrder).%OpenId(order2ID)
	do $$$AssertTrue($isobject(order2), "Order 2 retrieved")
	set branch = order2.Branch
	do $$$AssertEquals(branch.Phone, "999-999-0000", "Branch retrieved")
	set countOfOrders = branch.Orders.Count()
	do $$$AssertEquals(countOfOrders, 2, "Branch has 2 orders")
	set (branch, order1, order2) = ""
	do $$$LogMessage("All objects closed")
	#dim order3 as FCE.CurrencyOrder
	set order3 = ##class(FCE.CurrencyOrder).%New()
	set order3.ATM = "c333"
	set status = order3.%Save()
	do $$$AssertStatusNotOK(status, "Order 3 not saved, branch required")
	set status = ##class(FCE.Branch).%DeleteId(branchID)
	do $$$AssertStatusNotOK(status, "Branch can't be deleted while it has orders")
	set status = ##class(FCE.CurrencyOrder).%DeleteId(order1ID)
	do $$$AssertStatusOK(status, "Order 1 deleted")
	set status = ##class(FCE.CurrencyOrder).%DeleteId(order2ID)
	do $$$AssertStatusOK(status, "Order 2 deleted")
	set status = ##class(FCE.Branch).%DeleteId(branchID)
	do $$$AssertStatusOK(status, "Branch deleted")
}

/// SQL tests for 1->M relationship between FCE.Branch and FCE.CurrencyOrder tables
Method TestCurrencyOrderSQL()
{
 	if '$$$ClassExists(FCE.CurrencyOrder) {
		do $$$AssertSkipped("Can't run test yet")
		quit
	}
	
	#sqlcompile mode=deferred
	&sql(INSERT INTO FCE.Branch (Phone) VALUES ('999-999-0000'))
	do $$$AssertEquals(SQLCODE, 0, "Branch saved")
	set branchID = %ROWID
	do $$$AssertNotEquals(branchID, "", "Branch ID assigned")
	&sql(INSERT INTO FCE.CurrencyOrder (Branch, ATM)
	     VALUES (:branchID, 'a111'))
	do $$$AssertEquals(SQLCODE, 0, "Order 1 linked to Branch and saved")
	set order1ID = %ROWID
	do $$$AssertNotEquals(order1ID, "", "Order 1 ID assigned")
	&sql(INSERT INTO FCE.CurrencyOrder (ATM)
	     VALUES ('b222'))
	do $$$AssertEquals(SQLCODE, -108, "Order 2 not saved, branch required")
	&sql(DELETE FROM FCE.Branch WHERE ID = :branchID)
	do $$$AssertEquals(SQLCODE, -124, "Branch can't be deleted while it has orders")
	&sql(DELETE FROM FCE.CurrencyOrder WHERE ID = :order1ID)
	do $$$AssertEquals(SQLCODE, 0, "Order 1 deleted")
	&sql(DELETE FROM FCE.Branch WHERE ID = :branchID)
	do $$$AssertEquals(SQLCODE, 0, "Branch deleted")
}

/// test FCE.Branch Update()
Method TestUpdateBranch()
{
	// create branch
 	#dim branch as FCE.Branch
	set branch = ##class(FCE.Branch).%New()
	set branch.Phone = "999-999-0000"
	set euros = 150, dollars = 50
	do branch.CurrencyBalances.SetAt(euros, "EUR")
	do branch.CurrencyBalances.SetAt(dollars, "USD")
	
	set currencyOut = "EUR", amountOut   = 1000
	set currencyIn  = "USD", amountIn    = 100
	set status = branch.Update(currencyOut, amountOut, currencyIn, amountIn)
	do $$$AssertStatusNotOK(status, $system.Status.GetErrorText(status))
	set currentEuros = branch.CurrencyBalances.GetAt("EUR")
	set currentDollars = branch.CurrencyBalances.GetAt("USD")
	do $$$AssertEquals(currentEuros, euros, "Outgoing currency remains the same")
	do $$$AssertEquals(currentDollars, dollars, "Incoming currency remains the same")

	set amountIn  = 9999999, amountOut = 100
	set status = branch.Update(currencyOut, amountOut, currencyIn, amountIn)
	do $$$AssertStatusNotOK(status, $system.Status.GetErrorText(status))
	set currentEuros = branch.CurrencyBalances.GetAt("EUR")
	set currentDollars = branch.CurrencyBalances.GetAt("USD")
	do $$$AssertEquals(currentEuros, euros, "Outgoing currency remains the same")
	do $$$AssertEquals(currentDollars, dollars, "Incoming currency remains the same")

	set amountIn = 100
	set status = branch.Update(currencyOut, amountOut, currencyIn, amountIn)
	do $$$AssertStatusOK(status, "Branch updated")
	set currentEuros = branch.CurrencyBalances.GetAt("EUR")
	set currentDollars = branch.CurrencyBalances.GetAt("USD")
	set euros = euros - amountOut, dollars = dollars + amountIn
	do $$$AssertEquals(currentEuros, euros, "Outgoing currency updated correctly")
	do $$$AssertEquals(currentDollars, dollars, "Incoming currency updated correctly")

	set amountOut = 20
	set status = branch.Update(currencyOut, amountOut)
	do $$$AssertStatusOK(status, "Outgoing-only currency allowed (credit card or account payment)")
	set currentEuros = branch.CurrencyBalances.GetAt("EUR")
	set currentDollars = branch.CurrencyBalances.GetAt("USD")
	set euros = euros - amountOut
	do $$$AssertEquals(currentEuros, euros, "Outgoing currency updated correctly")
	do $$$AssertEquals(currentDollars, dollars, "Incoming currency remains the same")

	set amountIn = 20
	set status = branch.Update(,,currencyIn, amountIn)
	do $$$AssertStatusOK(status, "Incoming-only currency allowed (crediting account balance)")
	set currentEuros = branch.CurrencyBalances.GetAt("EUR")
	set currentDollars = branch.CurrencyBalances.GetAt("USD")
	set dollars = dollars + amountIn
	do $$$AssertEquals(currentEuros, euros, "Outgoing currency remains the same")
	do $$$AssertEquals(currentDollars, dollars, "Incoming currency updated correctly")

	set currencyIn = "ABC", amountIn = 20
	set status = branch.Update(,,currencyIn, amountIn)
	do $$$AssertStatusNotOK(status, "Invalid incoming currency")
	set currentEuros = branch.CurrencyBalances.GetAt("EUR")
	set currentDollars = branch.CurrencyBalances.GetAt("USD")
	do $$$AssertEquals(currentEuros, euros, "Outgoing currency remains the same")
	do $$$AssertEquals(currentDollars, dollars, "Incoming currency remains the same")
}

/// Basic tests for FCE.AccountHolder
Method TestAccountHolder()
{
	// assertion 1
	#dim accountHolder as FCE.AccountHolder		
	set accountHolder = ##class(FCE.AccountHolder).%New()
	do $$$AssertTrue($isobject(accountHolder), "Create new account holder")
	// assertion 2
	set status = accountHolder.%Save()
	do $$$AssertStatusNotOK(status, "Name is required")
	set accountHolder.Name = "Smith,John"
	// assertion 3
	set status = accountHolder.%Save()
	do $$$AssertStatusNotOK(status, "Email is required")
	set accountHolder.Email = "Smith@zzz.com"
	// assertion 4
	set status = accountHolder.%Save()
	do $$$AssertStatusNotOK(status, "Home/work address is required")
	set accountHolder.Home.Street = "10 High St."
	set accountHolder.Home.City = "Cambridge"
	set accountHolder.Home.State = "MA"
	set accountHolder.Home.Zip = "02142"
	set work = accountHolder.Home.%ConstructClone()
	set accountHolder.Work = work
	// assertion 5
	set accountHolder.DOB = $zdh("01/01/2100")
	set status = accountHolder.%Save()
	do $$$AssertStatusNotOK(status, "DOB must be in past")
	set accountHolder.DOB = $zdh("01/01/1980")
	// assertion 6
	set accountHolder.Currency = "DKK"
	set status = accountHolder.%Save()
	do $$$AssertStatusNotOK(status, "Invalid currency type")
	set accountHolder.Currency = "INR"
	// assertion 7
	set accountHolder.Balance = -5
	set status = accountHolder.%Save()
	do $$$AssertStatusNotOK(status, "Balance must be >= 0")
	set accountHolder.Balance = 1000
	// assertion 8
	set status = accountHolder.%Save()
	do $$$AssertStatusOK(status, "New account holder saved")
	// assertion 9
	set status = ##class(FCE.AccountHolder).%DeleteId(accountHolder.%Id())
	do $$$AssertStatusOK(status, "New account holder deleted")
}

/// SQL tests for FCE.AccountHolder
Method TestAccountHolderSQL()
{
	&sql(INSERT INTO FCE.AccountHolder (Name) VALUES ('Smith,John'))
	do $$$AssertEquals(SQLCODE, -108, "Email is required")
	&sql(INSERT INTO FCE.AccountHolder (Name, Email)
	     VALUES ('Smith,John', 'Smith@zzz.com'))
	do $$$AssertEquals(SQLCODE, -108, "Home/work addresses required")
	&sql(INSERT INTO FCE.AccountHolder (Name, Email, DOB,
		 Home_Street, Home_City, Home_State, Home_Zip,
		 Work_Street, Work_City, Work_State, Work_Zip)
		 VALUES ('Smith,John', 'Smith@zzz.com', {d '2100-01-01'},
		 '10 High St.', 'Cambridge', 'MA', '02142',
		 '10 High St.', 'Cambridge', 'MA', '02142'))
	do $$$AssertEquals(SQLCODE, -104, "DOB must be in past")
	&sql(INSERT INTO FCE.AccountHolder (Name, Email, DOB, Currency,
		 Home_Street, Home_City, Home_State, Home_Zip,
		 Work_Street, Work_City, Work_State, Work_Zip)
		 VALUES ('Smith,John', 'Smith@zzz.com', {d '1980-01-01'}, 'DKK',
		 '10 High St.', 'Cambridge', 'MA', '02142',
		 '10 High St.', 'Cambridge', 'MA', '02142'))
	do $$$AssertEquals(SQLCODE, -104, "Invalid currency type")
	&sql(INSERT INTO FCE.AccountHolder (Name, Email, DOB, Currency, Balance,
		 Home_Street, Home_City, Home_State, Home_Zip,
		 Work_Street, Work_City, Work_State, Work_Zip)
		 VALUES ('Smith,John', 'Smith@zzz.com', {d '1980-01-01'}, 'INR', -5,
		 '10 High St.', 'Cambridge', 'MA', '02142',
		 '10 High St.', 'Cambridge', 'MA', '02142'))
	do $$$AssertEquals(SQLCODE, -104, "Balance must be >= 0")
	&sql(INSERT INTO FCE.AccountHolder (Name, Email, DOB, Currency, Balance,
		 Home_Street, Home_City, Home_State, Home_Zip,
		 Work_Street, Work_City, Work_State, Work_Zip)
		 VALUES ('Smith,John', 'Smith@zzz.com', {d '1980-01-01'}, 'INR', 100,
		 '10 High St.', 'Cambridge', 'MA', '02142',
		 '10 High St.', 'Cambridge', 'MA', '02142'))
	do $$$AssertEquals(SQLCODE, 0, "New account holder saved:")
	&sql(DELETE FROM FCE.AccountHolder WHERE ID = :%ROWID)
	do $$$AssertEquals(SQLCODE, 0, "New account holder deleted")
}

}
