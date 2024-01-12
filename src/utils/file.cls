Class utils.file Extends %RegisteredObject
{

Parameter DIRECTORY = "/data/";

/// Redirect standard output to a file
ClassMethod results(filename As %String = "result.txt") As %Status
{
        set sc = $$$OK
        SET file=..#DIRECTORY _ filename
        OPEN file:("NRW"):5
            WRITE !,"RESULTS ",$zdt($h,3)
            USE file
            do ##class(UnitTest.utils).run("Test3")
            WRITE !,"END RESULTS ",$zdt($h,3)
        CLOSE file
        WRITE !,"Results are in ",file,!
        return sc
}

}
