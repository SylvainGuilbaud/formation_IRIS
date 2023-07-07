/// An order for currency.
Class FCE.CurrencyOrder Extends (%Persistent, %Populate, %XML.Adaptor, %JSON.Adaptor)
{

/// Generate more performant globals
Parameter USEEXTENTSET = 1;

Parameter FEERATE = .025;

Property ATM As %String(POPSPEC = "##class(%PopulateUtils).String(5)_##class(%PopulateUtils).String(5)");

/// name of requestor
Property Requestor As %String(POPSPEC = "Name()");

Property RequestorEmail As %String;

Property AmountOut As %Numeric(MINVAL = 0);

Property CurrencyOut As FCE.CurrencyName;

/// AmountIn reduced by transaction fee
Property AmountIn As %Numeric(MINVAL = 0);

Property CurrencyIn As FCE.CurrencyName;

Property ExchangeRate As %Decimal(MINVAL = 0, SCALE = 3);

Property Fee As %Numeric;

Property DateStamp As %Date(MAXVAL = "+$system.SYS.TimeStamp()", MINVAL = 59901);

Property TimeStamp As %Time;

/// Satisfaction with the service on this order
Property Satisfaction As %EnumString(DISPLAYLIST = "-Great-Good-OK-Bad-Horrible", VALUELIST = "-1-2-3-4-5");

/// Requested: initial request<br>
/// Pending:   only if awaiting approval<br>
/// Rejected:  not approved by bank<br>
/// Paid:      currency received by ATM, outgoing currency to be picked up<br>
/// Completed: outgoing currency paid to customer<br>
/// Problem:   problem in system<br>
/// Canceled:  canceled by customer<br>
Property Status As %String(VALUELIST = "-Requested-Pending-Rejected-Paid-Completed-Problem-Canceled");

Relationship Branch As FCE.Branch [ Cardinality = one, Inverse = Orders, Required ];

Index BranchIndex On Branch [ Type = bitmap ];

Index StatusIndex On Status [ Type = bitmap ];

Index OutIndex On CurrencyOut [ Type = bitmap ];

Index InIndex On CurrencyIn [ Type = bitmap ];

/// If this order is for a account holder,
/// both requestor fields contain Customer information
Relationship AccountHolder As FCE.AccountHolder [ Cardinality = one, Inverse = CurrencyOrders ];

Index AccountHolderIndex On AccountHolder;

/// Unique reference to FCE.Payment
Property Payment As FCE.Payment;

Index PaymentIndex On Payment [ Unique ];

ForeignKey PaymentFK(Payment) References FCE.Payment();

/// OVERRIDE: custom constructor
Method %OnNew(branch As FCE.Branch = "", requestor As %String = "", requestorEmail As %String = "", currencyOut As FCE.CurrencyName = "", currencyIn As FCE.CurrencyName = "", amountIn As %Numeric = 0, Output valid As %Status) As %Status [ Private ]
{
	set ..Requestor = requestor
	set ..RequestorEmail = requestorEmail
	set ..CurrencyOut = currencyOut
	set ..CurrencyIn = currencyIn
	set ..Branch = branch
	set ..AmountIn = amountIn
	set ..Fee = amountIn * ..#FEERATE		

	// compute AmountOut		
	if (amountIn '= 0) {
		set ..ExchangeRate = ##class(FCE.Currency).ComputeRate(currencyOut, currencyIn)
		set ..AmountOut = (amountIn - ..Fee) * ..ExchangeRate
	}
	// check available stock
	if $isobject(branch) {
		set stockAmountOut = branch.CurrencyBalances.GetAt(currencyOut)
		if (..AmountOut > stockAmountOut) {
			set custom = "Not enough stock in branch for " _ currencyOut
			set valid = $$$ERROR($$$GeneralError, custom)			
		}
	}
	return $$$OK
}

/// OVERRIDE: custom population
Method OnPopulate() As %Status
{
	// link this order to one of its Branch's ATMs (if the Branch has any)
	// otherwise, this CurrencyOrder happened at the Branch itself (no ATM)
	set ATMs = ..Branch.ATMs
	set count = ATMs.Count()
	if (count > 0) {
		set rand = $random(count) + 1
		set serialNumber = ATMs.GetAt(rand)
		set ..ATM = serialNumber
	}
	else {
		set ..ATM = ""
	}
	// 70% of CurrencyOrders are Status = Completed
	if ($random(10) > 2) {
		set ..Status = "Completed"
	}
	else {
		set ..Status = ##class(%PopulateUtils).ValueList("-Requested-Pending-Rejected-Paid-Problem-Canceled")
	}
	// make sure CurrencyIn and CurrencyOut are different
	while (..CurrencyIn = ..CurrencyOut) {
		set ..CurrencyOut = ##class(FCE.Tests.Utilities).Currency()
	}
	// set fee
	set ..Fee = ..AmountIn * ..#FEERATE
	// get exchange rate
	set rate = ##class(FCE.Currency).ComputeRate(..CurrencyIn, ..CurrencyOut)
	set ..ExchangeRate = rate
	// set correct AmountOut
	set ..AmountOut = (..AmountIn - ..Fee) * rate

	// assign a random payment to this CurrencyOrder
	set rand = $random(3), payment = 1
	if (rand = 0) { do ##class(FCE.Cash).Populate(1,,, .payment) }
	elseif (rand = 1) { do ##class(FCE.CreditCard).Populate(1,,, .payment)}
	elseif (rand = 2) { do ##class(FCE.AccountPayment).Populate(1,,, .payment)}
	set ..Payment = payment(1)
	// only CurrencyOrders with AccountPayments have an AccountHolder
	if (rand '= 2) { set ..AccountHolder = "" }
	return $$$OK
}

/// Display all orders in a given status, sorted by branch city
ClassMethod OrdersByCity(orderStatus As %String = "Pending") As %Status
{
	// check for SELECT privileges on FCE.CurrencyOrder and -> referenced tables
	if '$system.SQL.Security.CheckPrivilege($username, 1, "FCE.CurrencyOrder", "s") ||
	   '$system.SQL.Security.CheckPrivilege($username, 1, "FCE.Branch", "s") ||
	   '$system.SQL.Security.CheckPrivilege($username, 1, "FCE.RealEstate", "s") {
		set message = "User " _ $username _ " is not privileged for the operation"
		set status = $$$ERROR($$$SQLCode, -99, message)
		return status
	}
	#sqlcompile SELECT = odbc
	&sql(DECLARE bycity CURSOR FOR
		 SELECT Branch->Address->City, AmountIn, CurrencyIn, AmountOut, CurrencyOut,
				DateStamp, TimeStamp
		 FROM FCE.CurrencyOrder
		 WHERE Status = :orderStatus
		 ORDER BY Branch->Address->City)
	&sql(OPEN bycity)
	quit:(SQLCODE '= 0) // error -101 if cursor already open
	write !, orderStatus, " Orders"
	write !, "City", ?20, "Amount In", ?30, "Currency In", ?55, "Amount Out", ?70,
			 "Currency Out", ?95, "Date Stamp", ?110, "Time Stamp"
	for {
		&sql(FETCH bycity INTO :city, :amountIn, :currencyIn, :amountOut,
							   :currencyOut, :dateStamp, :timeStamp)
		quit:(SQLCODE '= 0)
		write !, city, ?20, amountIn, ?30, currencyIn, ?55, amountOut, ?70,
				 currencyOut, ?95, dateStamp, ?110, timeStamp
	}

	if SQLCODE = 100 {
		write !!, %ROWCOUNT, " row(s) returned."
		set status = $$$OK
	}
	else { set status = $$$ERROR($$$GeneralError, "SQLCODE: " _ SQLCODE _ " " _ %msg) }
	&sql(CLOSE bycity)
	quit:(SQLCODE '= 0) // error -102 if cursor not open
    return status
}

/// When a CurrencyOrder is updated or deleted, record that in the branch Notes
Trigger UpdateDeleteInNotes [ Event = UPDATE/DELETE, Foreach = row/object, Time = AFTER ]
{
	new action, note, auditNote, branch, st // ensure variables are private to trigger
	set action = $case({%%OPERATION}, "DELETE":"deleted", "UPDATE":"updated")
	set note = "At " _ $zdt($h) _ ", " _ $username _ " " _ action _ " Order #"
			   _ {ID} _ " originally requested by " _ {Requestor}
	           _ " (for " _ {AmountOut} _ " " _ {CurrencyOut} _ ")"
	set auditNote = "Order #" _ {ID} _ " " _ action
	#dim branch as FCE.Branch
	set branch = ##class(FCE.Branch).%OpenId({Branch}, 4, .st)
	if $$$ISOK(st) {
		do branch.Notes.MoveToEnd()
		do branch.Notes.WriteLine(note)
		set st = branch.%Save()
	}
	if ($$$ISERR(st)) { set %msg = "Couldn't update branch notes." }
	do $system.Security.Audit("Application", "FCE.CurrencyOrder", "Change", auditNote , "UpdateDelete")
}

/// When a currency order row/object is deleted, delete its payment
Trigger DeletePayment [ Event = DELETE, Foreach = row/object, Time = AFTER ]
{
	return:({Payment} = "")
    new SQLCODE // ensure SQLCODE is private to trigger
    &sql(DELETE FROM FCE.Payment WHERE ID = :{Payment})
	if (SQLCODE < 0) { set %ok = 0, %msg = "SQLCODE: "_ SQLCODE }
}

Storage Default
{
<Data name="CurrencyOrderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ATM</Value>
</Value>
<Value name="3">
<Value>Requestor</Value>
</Value>
<Value name="4">
<Value>RequestorEmail</Value>
</Value>
<Value name="5">
<Value>AmountOut</Value>
</Value>
<Value name="6">
<Value>CurrencyOut</Value>
</Value>
<Value name="7">
<Value>AmountIn</Value>
</Value>
<Value name="8">
<Value>CurrencyIn</Value>
</Value>
<Value name="9">
<Value>ExchangeRate</Value>
</Value>
<Value name="10">
<Value>Fee</Value>
</Value>
<Value name="11">
<Value>DateStamp</Value>
</Value>
<Value name="12">
<Value>TimeStamp</Value>
</Value>
<Value name="13">
<Value>Satisfaction</Value>
</Value>
<Value name="14">
<Value>Status</Value>
</Value>
<Value name="15">
<Value>Branch</Value>
</Value>
<Value name="16">
<Value>AccountHolder</Value>
</Value>
<Value name="17">
<Value>Payment</Value>
</Value>
</Data>
<DataLocation>^BaRe.BSqw.1</DataLocation>
<DefaultData>CurrencyOrderDefaultData</DefaultData>
<ExtentLocation>^BaRe.BSqw</ExtentLocation>
<IdLocation>^BaRe.BSqw.1</IdLocation>
<Index name="$CurrencyOrder">
<Location>^BaRe.BSqw.2</Location>
</Index>
<Index name="AccountHolderIndex">
<Location>^BaRe.BSqw.3</Location>
</Index>
<Index name="BranchIndex">
<Location>^BaRe.BSqw.4</Location>
</Index>
<Index name="IDKEY">
<Location>^BaRe.BSqw.1</Location>
</Index>
<Index name="InIndex">
<Location>^BaRe.BSqw.5</Location>
</Index>
<Index name="OutIndex">
<Location>^BaRe.BSqw.6</Location>
</Index>
<Index name="PaymentIndex">
<Location>^BaRe.BSqw.7</Location>
</Index>
<Index name="StatusIndex">
<Location>^BaRe.BSqw.8</Location>
</Index>
<IndexLocation>^BaRe.BSqw.I</IndexLocation>
<StreamLocation>^BaRe.BSqw.S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
