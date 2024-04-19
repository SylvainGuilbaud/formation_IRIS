class Account:
    def __init__(self):
        self.balance = 0

    def deposit(self, amount):
        if amount < 0:
            raise ValueError("Deposit amount must be non-negative")
        
        old_balance = self.balance
        self.balance += amount
        
        # Postconditions
        if self.balance != old_balance + amount:
            raise ValueError("Postcondition failed: Balance calculation error")

    def withdraw(self, amount):
        if amount < 0:
            raise ValueError("Withdrawal amount must be non-negative")
        if self.balance < amount:
            raise ValueError("Insufficient funds")

        old_balance = self.balance
        self.balance -= amount
        
        # Postconditions
        if self.balance != old_balance - amount:
            raise ValueError("Postcondition failed: Balance calculation error")

    def check_balance_invariant(self):
        if self.balance < 0:
            raise ValueError("Balance invariant violated: Balance is negative")

    @classmethod
    def test_account(cls):
        account = cls()
        
        try:
            # Test depositing a positive amount
            account.deposit(100)
            print("Deposit succeeded: Balance after deposit:", account.balance)
            
            # Test depositing a negative amount (should fail)
            account.deposit(-50)
        except ValueError as e:
            print("Deposit of negative amount failed as expected:", e)
        else:
            raise ValueError("Deposit of negative amount unexpectedly succeeded")
        
        try:
            # Test withdrawing a valid amount
            account.withdraw(50)
            print("Withdrawal succeeded: Balance after withdrawal:", account.balance)
            
            # Test withdrawing more than the available balance (should fail)
            account.withdraw(200)
        except ValueError as e:
            print("Withdrawal of more than available balance failed as expected:", e)
        else:
            raise ValueError("Withdrawal of more than available balance unexpectedly succeeded")
        
        try:
            # Check balance invariant (should succeed)
            account.check_balance_invariant()
            print("Balance invariant holds true")
        except ValueError as e:
            print("Balance invariant violated:", e)
        
        # Intentionally set balance to negative value to trigger balance invariant failure
        account.balance = -10
        
        try:
            # Check balance invariant (should fail)
            account.check_balance_invariant()
        except ValueError as e:
            print("Balance invariant violated as expected:", e)
        else:
            raise ValueError("Balance invariant unexpectedly held true")
        
        print("Account operations completed successfully")

# Run the test
Account.test_account()
