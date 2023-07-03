Class FCE.PhoneNumber Extends %String
{

Parameter PATTERN = "3n1""-""3n1""-""4n";

/// OVERRIDE: add parentheses around area code
ClassMethod LogicalToDisplay(phone As %String) As %String
{
	return "(" _ $piece(phone, "-") _ ")-" _ $piece(phone, "-", 2, 3)
}

}
