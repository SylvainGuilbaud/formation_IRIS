Class pagination.scrollable Extends %RegisteredObject
{

ClassMethod getOnePage(age As %Integer, pageSize As %String = 20, pageIndex As %String = 1, id As %Integer = 0) As %DynamicObject
{
    set onePage = []
    set result = []
    set vFrom = ((pageIndex -1 ) * pageSize)+1
    set vTo = vFrom + (pageSize-1)

    set sc = ..getRS(age,.id,.rs)
    if 'sc {
        do result.%Push({
                "ERROR":($system.Status.GetErrorText(sc))
            }
        )
    } else {

        do rs.CurrRowSet(vFrom)
        if pageSize >= rs.Count() set pageSize = rs.Count()

        try {
            FOR i=1:1:pageSize{
                Do onePage.%Push({
                "index": (i),
                "pid": (rs.%Get("ID")),
                "name" : (rs.%Get("Name")) ,
                "age": (rs.%Get("Age") )
                })    
                Do rs.%Next()      
            }
            }
        catch(e){ }

        do result.%Push({
                    "pageSize":(pageSize),
                    "pageIndex":(pageIndex),
                    "fromIndex":(vFrom),
                    "toIndex":(vFrom+i - 1),
                    "resultSetTotal":(rs.Count()),
                    "pageRecords":(i),
                    "pages":($NORMALIZE((rs.Count()/pageSize),0) _ " pages and " _ $NORMALIZE((rs.Count()#pageSize),0) _ " records"),
                    "resultSet":(onePage)
                    })
    }
    return result
}

ClassMethod getRS(age As %Integer, id As %Integer, Output rs As %ScrollableResultSet) As %Status
{
    #dim sc As %Status = $$$OK
    if '$d(id) 
    || id=0 {
        set sql = "SELECT ID, Name,Age FROM Sample.Person where age > ?" 
        set rs=##class(%ScrollableResultSet).%New("%DynamicQuery:SQL")
        set sc = rs.Prepare(sql)
        quit:$$$ISERR(sc) sc
        set sc = rs.Execute(age)
        quit:$$$ISERR(sc) sc
        quit:(rs.Count()=0) $$$ERROR($$$GeneralError, "No results")
    } else {
        set rs=##class(%ScrollableResultSet).%OpenId(id)
    }
    return sc
}

}
