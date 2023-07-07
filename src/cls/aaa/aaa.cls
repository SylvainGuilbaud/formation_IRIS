Class aaa.aaa
{

/// Description
ClassMethod MethodName() As %Status
{
        Set sc = $$$OK
        // do something
        #dim rs As %SQL.ISelectResult
        set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM")
        while rs.%Next() {
            write rs.ID, !
        }

        Return sc
}

}
