/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Test.TestDataApiImpl
{

ClassMethod testObjectCreate()
{
    set input = {
        "uid": "LOC-TEST-1",
        "locationName": "Test location 1",
        "locationType": "Supplier",
        "status": "Active",
        "street": "1 Memorial Dr",
        "city": "Cambridge",
        "stateProvince": "MA",
        "country": "USA",
        "postalCode": "02020"
    }
    set objectName = "Location"

    set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectName)
    set obj = $System.OBJ.New(classname)
    do obj.%JSONImport(input)
    set st = obj.%Save()
    if $$$ISOK(st) {
        do obj.%JSONExportToString(.objRes)
        write objRes
    }
    else {
        do $system.Status.DisplayError(st)
    }
    //set resp = ##class(SC.Core.API.Data.DataApiBase).ObjectCreate(objectName, input)
    //zw resp
}

ClassMethod testObjectUpdate()
{
    set objectName = "Location"
    set uid = "LOC-TEST-1"
    set newObj =     {
        "uid": "LOC-TEST-1",
        "locationName": "Test location 1",
        "locationType": "Supplier",
        "status": "Active",
        "street": "1 Memorial Dr",
        "city": "Cambridge",
        "stateProvince": "MA",
        "country": "USA",
        "postalCode": "02134"
    }
    set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectName)
    set obj = $CLASSMETHOD(classname,"uidIndexOpen", uid)
    do obj.%JSONImport(newObj)
    set st = obj.%Save()
    if $$$ISOK(st) {
        do obj.%JSONExportToString(.objRes)
        write objRes
    } 
    else {
        do $system.Status.DisplayError(st)
    }
}

ClassMethod testSearchSql()
{
    
    set objectName = "Location" 
    set alias = ""
    set startIndex = 3
    set endIndex = 5
    set where = ""
    set orderBy = "uid"
    set sql = ##class(SC.Core.API.Data.DataApiBase).ConstructObjectSQL(objectName, startIndex, endIndex, where, orderBy, alias)
    write sql
}

ClassMethod testGetAll()
{
    set objectName = "Location"
    set className = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectName)
    set classInfo = ##class(SC.Core.Util.ClassInfo).%New(className)
    set startIndex = 20
    set endIndex = 21
    set orderBy = "ID"
    set tableAlias = ""
    set where = ""
    set resp = ..getSqlResult(objectName, classInfo, startIndex, endIndex, where, orderBy, tableAlias)
    zw resp
}

ClassMethod getSqlResult(objectName As %String, classInfo As SC.Core.Util.ClassInfo, startIndex As %Integer, endIndex As %Integer, where As %String, orderBy As %String, tableAlias As %String) As %DynamicObject
{
    set objArr = [] 
    set sql = ##class(SC.Core.API.Data.DataApiBase).ConstructObjectSQL(objectName, classInfo.Attributes, startIndex, endIndex, where, orderBy, tableAlias)
    write !, "SQL = ", sql
    set attributes = classInfo.Attributes
    set attrList = $LISTFROMSTRING(attributes)
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
    set count = 0
	while rs.%Next() {
        set count = count +1
        set obj = {}
        set ptr=0
        while $LISTNEXT(attrList, ptr, attrName) {
            set value = rs.%Get(attrName)
            w !, "name = [", attrName, "], value = [", value, "]"
            if value '= "" {
                do obj.%Set(attrName, value)
            }   
        }
	    do objArr.%Push(obj)
    }
    write !,"Count = ", count
    return objArr
}

}
