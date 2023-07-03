Include FCE

Class FCE.Tests.TestCase Extends %UnitTest.TestCase
{

/// Helper method
ClassMethod Run()
{
    set testSuite = "FCETests"
    
    // set up ^UnitTestRoot if not already set
    if '$data(^UnitTestRoot) {
    	set mainFolder = "UnitTests\FCE\" 
	    set st = ##class(%File).CreateDirectoryChain(mainFolder _ testSuite)
	    if $$$ISOK(st) { set ^UnitTestRoot = mainFolder }
	    else {
	    	write !, "UnitTestRoot folder could not be created. Consult with instructor."
	    	do $system.Status.DisplayError(st)
	    }
    }
    
    set testCase = ..%ClassName(1) // this test case
    set test = testSuite _ ":" _ testCase
	set quals = "/noload/norecursive/nodelete"
    do ##class(%UnitTest.Manager).RunTest(test, quals)
    quit
}

}
