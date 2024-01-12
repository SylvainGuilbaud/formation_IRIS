Class utils.file
{

Parameter DIRECTORY = "/data/";

Parameter FILENAME = "results";

Parameter EXTENSION = ".txt";

/// Redirect standard output to a file
ClassMethod results() As %Status
{
        set sc = $$$OK
        SET file=..#DIRECTORY _ ..#FILENAME _ "_" _ $tr($zdt($h,3),"- :")_..#EXTENSION
        OPEN file:("NRW"):5
            USE file
            WRITE !,"BEGIN RESULTS ",$zdt($h,3),!
            do ##class(UnitTest.utils).run("Test3")
            WRITE !,"END RESULTS ",$zdt($h,3)
        CLOSE file
        WRITE !,"Results are in ",file,!
        return sc
}

}
