Class pagination.demo
{

/// do ##class(User.Pagination).Time("NoSave")
/// do ##class(User.Pagination).Time("Save")
ClassMethod Time(method = "Save")
{
    set start = $zh
    do $classmethod(,method)
    set end = $zh
    write $$$FormatText("%1 took %2 sec", method, $fnumber(end-start,"",4))
}

/// do ##class(User.Pagination).NoSave()
ClassMethod NoSave()
{
    do {
        do $i(i)        
        set obj = ..getPersonsPage(20,i)
        //w obj.%ToJSON(),!,!
    } while (obj.toIndex < obj.resultSetTotal)
}

/// do ##class(User.Pagination).Save()
ClassMethod Save()
{
    do {        
        set obj = ..getPersonsPageSave(20,.id)
        //w obj.%ToJSON(),!,!
    } while (id'=-1)
}

ClassMethod getPersonsPage(pageSize As %String = 20, pageIndex As %String = 1) As %DynamicObject
{
    #dim sc As %Status = $$$OK
    #dim rs As %ScrollableResultSet
    set sc = ..getRS(,.rs)
    quit:$$$ISERR(sc) {"msg": ($System.Status.GetErrorText(sc))}
    
    set vFrom = ((pageIndex -1 ) * pageSize)
    set vTo = vFrom + (pageSize-1)

    do rs.CurrRowSet(vFrom)
    set results = []
    set:(pageSize >= rs.Count()) pageSize = rs.Count()
    set i = 0
    while rs.%Next() && $i(i) {
        quit:(i>pageSize)
        do results.%Push({ "index": (i), "pid": (rs.%Get("ID")), "Name" : (rs.%Get("Name")), "age": (rs.%Get("Age"))})
        //do results.%Push(+rs.%Get("ID"))
    }

    set out = {
                "pageSize":(pageSize),
                "pageIndex":(pageIndex),
                "fromIndex":(vFrom + 1),
                "toIndex":(vFrom+i),
                "resultSetTotal":(rs.Count()),
                "pageRecords":(i),
                "pages":($NORMALIZE((rs.Count()/pageSize),0)),
                "resultSet":(results)
                }
    return out
}

ClassMethod getRS(id As %Integer, Output rs As %ScrollableResultSet) As %Status
{
    #dim sc As %Status = $$$OK
    if '$d(id) {
         set sql = "SELECT ID, Name, Age FROM Sample.Person"
        set rs=##class(%ScrollableResultSet).%New("%DynamicQuery:SQL")
        set sc = rs.Prepare(sql)
        quit:$$$ISERR(sc) sc
        set sc = rs.Execute()
        quit:$$$ISERR(sc) sc

        quit:(rs.Count()=0) $$$ERROR($$$GeneralError, "No results")
    } else {
        set rs=##class(%ScrollableResultSet).%OpenId(id)
    }
    
    quit sc
}

ClassMethod getPersonsPageSave(pageSize As %String = 20, ByRef id As %Integer) As %DynamicObject
{
    #dim sc As %Status = $$$OK
    #dim rs As %ScrollableResultSet
    set sc = ..getRS(.id,.rs)
    quit:$$$ISERR(sc) {"msg": ($System.Status.GetErrorText(sc))}
   

    set results = []
    set:(pageSize >= rs.Count()) pageSize = rs.Count()
    set i = 0
    set notAtEnd = rs.%Next()
    while notAtEnd && $i(i) {
        do results.%Push({ "index": (i), "pid": (rs.%Get("ID")), "Name" : (rs.%Get("Name")), "age": (rs.%Get("Age"))})
        //do results.%Push(+rs.%Get("ID"))
        quit:(i>=pageSize)
        set notAtEnd = rs.%Next()
    }
    
    if notAtEnd {
        do rs.%Save()
        Set id=rs.%Id()
    } else {
        do rs.%DeleteId(id)
        set id = -1
    }

    set out = {
                "pageSize":(pageSize),
                "resultSetTotal":(rs.Count()),
                "pageRecords":(i),
                "pages":($NORMALIZE((rs.Count()/pageSize),0)),
                "resultSet":(results)
                }
                
    kill rs
    return out
}

}
