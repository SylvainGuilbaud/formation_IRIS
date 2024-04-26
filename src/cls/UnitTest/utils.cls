/// <example>
/// set ^UnitTestRoot = "/data/unittests"
/// Do ##class(%UnitTest.Manager).RunTest("Test1")
/// </example>
/// <a 
/// target="_blank" 
/// href="https://docs.intersystems.com/irislatest/csp/docbook/Doc.View.cls?KEY=GUNITTEST_execute">
/// Executing Unit Tests Using the %UnitTest.Manager Methods
/// </a>
Class UnitTest.utils Extends %RegisteredObject
{

Parameter UNITTESTROOT = "/data/unittests";

/// Description
ClassMethod run(testName As %String = "") As %Status
{
        set sc = $$$OK
        set ^UnitTestRoot = ..#UNITTESTROOT
        set sc = ##class(%UnitTest.Manager).RunTest(testName)
        return sc
}

}
