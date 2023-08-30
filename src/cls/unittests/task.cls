Class unittests.task Extends %SYS.Task.Definition
{

/// Root directory containing Unit Tests classes
Property UnitTestRoot As %VarString [ InitialExpression = "/data/unittests" ];

/// Root directory containing Unit Tests classes
Property Branch As %VarString [ InitialExpression = "Test1" ];

Method OnTask() As %Status
{
	set sc = $$$OK

    set ^UnitTestRoot=..UnitTestRoot

    set sc = ##class(%UnitTest.Manager).RunTest(..Branch)

    return sc
}

}
