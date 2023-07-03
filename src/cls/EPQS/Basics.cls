Class EPQS.Basics Extends %RegisteredObject
{

/* Example of how Classes in ObjectScript interact with Python */

// Demonstrates the the [Language=python] syntax and that the body of the class is in python

Method Welcome() As %Numeric [ Language = python ]
{
print('welcome!')
return True
}

// Demonstrates how to execute a SQL query from Python

Method RunSQL() As %Numeric [ Language = python ]
{
import iris
rs = iris.sql.exec("select top 10 Name, Super, $extract(description,1,50) from %Dictionary.ClassDefinition WHERE Name %STARTSWITH '%Net.'")

for row in rs:
    print(row)

return True
}

// Demonstrates how to execute a SQL query from Python and import it into a pandas dataframe

Method CreateDataframe() As %Numeric [ Language = python ]
{
import iris
import pandas as pd
rs = iris.sql.exec("select Name, Super, $extract(description,1,50) from %Dictionary.ClassDefinition WHERE Name %STARTSWITH '%Net.'")

df = rs.dataframe()

print(df.describe())

return True
}

/* Demonstrates how methods written in Python can access properties in this class */
Property VariableMessage As %String [ InitialExpression = "Initial Value" ];

// Can we access Properties?

// The same 'self.' syntax can be used to access methods (written in either ObjectScript or Python) on the class

Method PrintVariableMessage() As %Numeric [ Language = python ]
{
foo = self.VariableMessage
print('VariableMessage says: '+foo)
return True
}

// Can we update Properties?

Method SetVariableMessage() As %Numeric [ Language = python ]
{
self.VariableMessage = "Updated Value"
foo = self.VariableMessage
return True
}

// Can we read a global that was set in ObjectScript from Python?

Method ReadGlobal() As %Numeric [ Language = python ]
{
import iris

foo = iris.gref("^Test")
print(foo.get())
return True
}

Method UpdateGlobal() As %Numeric [ Language = python ]
{
import iris

foo = iris.gref("^Test")
foo.set('Updated Global Value')
return True
}

/// A slightly different example of how to make SQL calls from Python
Method PrepareAndExecuteSQL() As %Numeric [ Language = python ]
{
import iris

stmt = iris.sql.prepare("select top 10 Name, Super, $extract(description,1,50) from %Dictionary.ClassDefinition WHERE Name %STARTSWITH ?")
rs = stmt.execute("%Net.")
for idx, row in enumerate(rs):
    print(f"[{idx}]: {row}")
return 1
}

ClassMethod Install()
{
    if ##class(%SYS.Python).Import("pandas")=0 {
        do ##class(%SYS.Python).Install("pandas")
    }
    SET ^Test="Initial Global Value"
}

ClassMethod RunEverything()
{
    do ..Install()
    set obj = ##class(EPQS.Basics).%New()

    write !,"Running Welcome... ",!
    do obj.Welcome()
    write !,"Running RunSQL... ",!
    do obj.RunSQL()
    write !,"Running CreateDataframe... ",!
    do obj.CreateDataframe()
    write !,"Running PrepareAndExecuteSQL... ",!
    do obj.PrepareAndExecuteSQL()

    write !,"Running PrintVariableMessage... ",!
    do obj.PrintVariableMessage()
    write !,"Running SetVariableMessage... ",!
    do obj.SetVariableMessage()
    write !,"Running PrintVariableMessage... ",!
    do obj.PrintVariableMessage()

    write !,"Running ReadGlobal... ",!
    do obj.ReadGlobal()
    write !,"Running UpdateGlobal... ",!
    do obj.UpdateGlobal()
    write !,"Running ReadGlobal... ",!
    do obj.ReadGlobal()
}

}
