Include %occErrors

Class MyApp.Account Extends %Persistent
{

Property Balance As %Numeric;

/// Deposit money into the account
Method Deposit(amount As %Numeric) As %Status
{
    // Preconditions
    If amount < 0 {
        Return $$$ERROR($$$GeneralError, "Deposit amount must be non-negative")
    }

    // Store the old balance
    Set oldBalance = ..Balance

    // Update balance
    Set ..Balance = oldBalance + amount

    // Postconditions
    If (..Balance '= $$$NULLOREF) && (..Balance '= (oldBalance + amount)) {
        Return $$$ERROR($$$GeneralError, "Postcondition failed: Balance calculation error")
    }

    Quit $$$OK
}

/// Withdraw money from the account
Method Withdraw(amount As %Numeric) As %Status
{
    // Preconditions
    If amount < 0 {
        Return $$$ERROR($$$GeneralError, "Withdrawal amount must be non-negative")
    }
    If (..Balance = $$$NULLOREF) || (..Balance < amount) {
        Return $$$ERROR($$$GeneralError, "Insufficient funds")
    }

    // Store the old balance
    Set oldBalance = ..Balance

    // Update balance
    Set ..Balance = oldBalance - amount

    // Postconditions
    If (..Balance '= $$$NULLOREF) && (..Balance '= (oldBalance - amount)) {
        Return $$$ERROR($$$GeneralError, "Postcondition failed: Balance calculation error")
    }

    Quit $$$OK
}

/// Invariant: Balance should always be non-negative
Method CheckBalanceInvariant() As %Status
{
        Set tSC = $$$OK
        If ..Balance < 0 {
            Set tSC = $$$ERROR($$$GeneralError, "Balance invariant violated: Balance is negative")
        }
        Quit tSC
}

/// Class method to test the Account class
ClassMethod TestAccount() As %Status
{
    // Create a new instance of Account
    Set account = ##class(MyApp.Account).%New()
    
    // Initialize the balance
    Set account.Balance = 0
    
    // Test depositing a positive amount
    Set tSC = account.Deposit(100)
    If $$$ISERR(tSC) {
        Write "Deposit failed: ", $system.Status.GetErrorText(tSC), !
        Quit tSC
    }
    Write "Deposit succeeded: Balance after deposit: ", account.Balance, !
    
    // Test depositing a negative amount (should fail)
    Set tSC = account.Deposit(-50)
    If $$$ISERR(tSC) {
        Write "Deposit of negative amount failed as expected: ", $system.Status.GetErrorText(tSC), !
    } Else {
        Write "Deposit of negative amount unexpectedly succeeded", !
        Quit $$$ERROR($$$GeneralError, "Deposit of negative amount unexpectedly succeeded")
    }
    
    // Test withdrawing a valid amount
    Set tSC = account.Withdraw(50)
    If $$$ISERR(tSC) {
        Write "Withdrawal failed: ", $system.Status.GetErrorText(tSC), !
        Quit tSC
    }
    Write "Withdrawal succeeded: Balance after withdrawal: ", account.Balance, !
    
    // Test withdrawing more than the available balance (should fail)
    Set tSC = account.Withdraw(200)
    If $$$ISERR(tSC) {
        Write "Withdrawal of more than available balance failed as expected: ", $system.Status.GetErrorText(tSC), !
    } Else {
        Write "Withdrawal of more than available balance unexpectedly succeeded", !
        Quit $$$ERROR($$$GeneralError, "Withdrawal of more than available balance unexpectedly succeeded")
    }
    
    // Check balance invariant
    Set tSC = account.CheckBalanceInvariant()
    If $$$ISERR(tSC) {
        Write "Balance invariant violated: ", $system.Status.GetErrorText(tSC), !
        Quit tSC
    }
    
    Write "Account operations completed successfully", !
    Quit $$$OK
}

Storage Default
{
<Data name="AccountDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Balance</Value>
</Value>
</Data>
<DataLocation>^MyApp.AccountD</DataLocation>
<DefaultData>AccountDefaultData</DefaultData>
<IdLocation>^MyApp.AccountD</IdLocation>
<IndexLocation>^MyApp.AccountI</IndexLocation>
<StreamLocation>^MyApp.AccountS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
