/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.PredictedInventoryApiImpl Extends SC.Core.API.ApiBaseImpl
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "PredictedInventory";

/// Default sorting attribute
Parameter DEFAULTSORTING = "dayInFuture";

ClassMethod GetPredictedInventory() As %DynamicObject
{
    set idSelect = ""
    return ..GetRecordsWithIdSelect(idSelect)
}

ClassMethod GetRecordsWithIdSelect(idSelect As %String) As %DynamicAbstractObject
{
    try {
        set className = "SC.Core.Data.Internal.PredictedInventory"
        set classInfo = ##class(SC.Core.Util.ClassInfo).%New(className)
        set objArr = [] 
        set pageSize = ..GetPageSize()
        set pageIndex = ..GetPageIndex()
        set tableAlias = ""
        set orderBy = ..GetOrderByClause(classInfo, ..#DEFAULTSORTING, tableAlias)
        set startIndex = pageSize * pageIndex
        set endIndex = pageSize * (pageIndex + 1)

        Set where = ..GetWhereClause(classInfo, tableAlias)
        set originalWhere = where
        set idCol = "ID"
        if tableAlias '= "" { set idCOl = tableAlias_"."_idCol }
        if idSelect '= "" {
            if where = "" {
                set where = " "_idCol_" IN ("_idSelect_")"
            }
            else {
                set where = where_" AND "_idCol_" IN ("_idSelect_")"
            }
        }
        
        set sql = ..ConstructPredictedInventorySQL(classInfo.Attributes, startIndex, endIndex, where, orderBy, tableAlias)
        //return {"sql": (sql)} 
        set attributes = classInfo.Attributes
        set attrList = $LISTFROMSTRING(attributes)
        set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
        if rs.%SQLCODE < 0 {
            // if we get here, there is syntax problem with the SQL statement - just exception out - 
            // don't give the user any hints to hack our system.
            $$$ThrowStatus($$$ERROR($$$SQLCode,SQLCODE,$g(%msg)))
        }
        set count = 0
		while rs.%Next() {
            set count = count +1
            set obj = {}
            set ptr=0
            set idValue = rs.%Get("ID")
            do obj.%Set("ID", idValue, "number")
            while $LISTNEXT(attrList, ptr, attrName) {
                set value = rs.%Get(attrName)
                #; if (classInfo.isDateTimeAttribute(attrName) ) {
                #;     set value = ..formatDateTimeValue(value)
                #; }
                if value '= "" {
                    do obj.%Set(attrName, value)
                }   
            }
			do objArr.%Push(obj)
        }
        do ..%SetHeader("pageSize", pageSize)
        do ..%SetHeader("pageIndex", pageIndex)
        do ..%SetHeader("orderBy", orderBy)
        do ..%SetHeader("returnCount", count)
        do ..%SetHeader("whereClause", originalWhere)
        return objArr.%ToJSON()
    } catch (ex) {
        do ..%SetStatusCode("500")
        return {"Status": "Error", "Message": "Server error"}		
	}
}

ClassMethod ConstructPredictedInventorySQL(attributes As %String, startIndex As %Integer, endIndex As %Integer, where As %String, orderBy As %String, tableAlias As %String)
{
    set tableName = "SC_Core_Data_Internal.PredictedInventory"
    Set sql = "SELECT *, %VID as vid FROM ( SELECT TOP ("_endIndex_") "
    set attrList = $LISTFROMSTRING(attributes)
    set ptr=0
    //set first = 0 
    if tableAlias '= "" {
        set sql = sql_tableAlias_"."
    }
    set sql = sql_"ID"
    while $LISTNEXT(attrList, ptr, attrName) {
        //if first > 0 {
        set sql = sql_", "
        //}
        //else {
        //    set first = 1
        //}
        if tableAlias '= "" {
            set sql = sql_tableAlias_"."
        }
        set sql = sql_attrName
    }
    set sql = sql_" FROM "_tableName
    if tableAlias '= "" {
            set sql = sql_" AS "_tableAlias
    }
    if where '= "" {
        Set sql = sql_" WHERE "_where
    }
    Set sql = sql_"  ORDER BY "_orderBy_
              ") WHERE %VID > "_startIndex
    return sql
}

}
