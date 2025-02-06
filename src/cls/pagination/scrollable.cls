Class pagination.scrollable Extends %RegisteredObject
{

/// Test retrieving 2 first and 2 last pages
ClassMethod test(age As %Integer = 100, pageSize As %String = 20) As %Status
{
    set start = $zh

    set sc = $$$OK
    set sc = ..getRS(age,.rs)
    if sc {  
        set page = 1
        write "Page number " _ page ,!
        set json = ..getOnePage(pageSize,page,rs)
        write json.%ToJSON(),!
        
        set page = 2
        write "Page number " _ page ,!
        set json = ..getOnePage(pageSize,page,rs)
        write json.%ToJSON(),!

        set page = json.pages
        write "Page number " _ page ,!
        set json = ..getOnePage(pageSize,page,rs)
        write json.%ToJSON(),!

        set page = json.pages + 1
        write "Page number " _ page ,!
        set json = ..getOnePage(pageSize,page,rs)
        write json.%ToJSON(),!

    } else {
       write "ERROR:"_$system.Status.GetErrorText(sc) 
    }

    write "elapse:"_ ($NORMALIZE($zh-start,6))

    return sc
}

/// Test retrieving all pages
ClassMethod test2(age As %Integer = 100, pageSize As %String = 20) As %Status
{
    set start = $zh

    set sc = $$$OK,page=0
    set sc = ..getRS(age,.rs)
    if sc {  
        do {
            set json = ..getOnePage(pageSize,$INCREMENT(page),rs)
            write "Page number " _ json.pageIndex ,!
            write json.%ToJSON(),!
        } while json.pageRecords > 0

    } else {
       write "ERROR:"_$system.Status.GetErrorText(sc) 
    }
    write "elapse:"_ ($NORMALIZE($zh-start,6))
    return sc
}

ClassMethod getOnePage(pageSize As %String = 20, pageIndex As %String = 1, rs As %ScrollableResultSet) As %DynamicObject
{
    set start = $zh
    set onePage = []
    set vFrom = ((pageIndex -1 ) * pageSize)+1
    set vTo = vFrom + (pageSize-1)
    set pageRecords = 0

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
            set pageRecords = pageRecords + 1
            Do rs.%Next()      
        }
        }
    catch(e) { Do onePage.%Push("no more record")}

    set result = {
                "pageSize":(pageSize),
                "pageIndex":(pageIndex),
                "fromIndex":(vFrom),
                "toIndex":(vFrom+i - 1),
                "resultSetTotal":(rs.Count()),
                "pageRecords":(pageRecords),
                "pages":($NORMALIZE((rs.Count()/pageSize),0)),
                "resultSet":(onePage),
                "elapse":($NORMALIZE($zh-start,6))
                }
 
    return result
}

ClassMethod getRS(age As %Integer, Output rs As %ScrollableResultSet) As %Status
{
    #dim sc As %Status = $$$OK
   
    set sql = "SELECT ID, Name,Age FROM Sample.Person where age > ?" 
    set rs=##class(%ScrollableResultSet).%New("%DynamicQuery:SQL")
    set sc = rs.Prepare(sql)
    quit:$$$ISERR(sc) sc
    set sc = rs.Execute(age)
    quit:$$$ISERR(sc) sc
    quit:(rs.Count()=0) $$$ERROR($$$GeneralError, "No results")
  
    return sc
}

}
