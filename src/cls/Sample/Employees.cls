/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
/// This sample persistent class represents an employee.<br>
Class Sample.Employees Extends Sample.Person
{

/// The employee's job title.
Property Title As %String(MAXLEN = 50);

/// The employee's current salary.
Property Salary As %Integer(MAXVAL = 100000, MINVAL = 0);

}
