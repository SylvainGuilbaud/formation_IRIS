Class unittests.taskTest1 Extends %SYS.Task.Definition
{

Method OnTask() As %Status
{
	set sc = $$$OK

    set ^UnitTestRoot="/data/unittests"
    set sc = ##class(%UnitTest.Manager).RunTest("Test1")

    return sc
}

}
