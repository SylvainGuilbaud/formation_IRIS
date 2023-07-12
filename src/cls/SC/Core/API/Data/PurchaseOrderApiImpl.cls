/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// API impl class for purchase order related APIs
Class SC.Core.API.Data.PurchaseOrderApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class: PurchaseOrder
Parameter OBJECTNAME = "PurchaseOrder";

/// Object name for PurchaseOrderLine
Parameter LINEOBJECT = "PurchaseOrderLine";

/// Default sorting attribute
Parameter DEFAULTSORTING = "-orderPlacedDate";

/// purchase order alias used in SQL statements
Parameter POALIAS = "po";

/// Delete a purchase order 
ClassMethod DeletePurchaseOrder(orderId As %String) As %DynamicObject
{
    try { 
        set objectName = ..#OBJECTNAME
        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectName)
        set exists = $CLASSMETHOD(classname,"uidIndexExists", orderId)
        if exists = 0 {
		    do ..%SetStatusCode("400")
		    return {"Status": "Failed", 
                    "Message": ("No "_objectName_" with uid ["_orderId_"] was found.")}            
        }
        set st = ..DeleteLinesForPurchaseOrder(orderId)
        if $$$ISOK(st) {
            // After deleting the order lines, delete the order
            set st = $CLASSMETHOD(classname,"uidIndexDelete", orderId)
            set st = ..DeleteLinesForPurchaseOrder(orderId)
            if $$$ISOK(st) {
                do ..%SetStatusCode("200")
		        return {"Status": "Success", 
                        "Message": ("Successfully deleted "_objectName_" with uid ["_orderId_"]. ")}               
            }
            else {
		        return {"Status": "Failed", 
                        "Message": ("Failed to delete "_objectName_" with uid ["_orderId_"] due to: "
                        _$System.Status.GetErrorText(st))}            }
        }
        else {
		    do ..%SetStatusCode("500")
		    return {"Status": "Failed", 
                    "Message": ("Failed to delete order lines for "_objectName_" with uid ["_orderId_"]. ")}
		    do ..%SetStatusCode("500")

        }
	} catch (ex) {
		do ..%SetStatusCode("500")
		return {"Status": "Error", 
                "Message": ("Failed to delete "_objectName_" with uid ["_orderId_"]. ")}
	}
}

/// Delete all purchase order lines for a given purchase order
ClassMethod DeleteLinesForPurchaseOrder(orderId As %String) As %Status
{
    Set sc = $$$OK
    set tableName = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName(..#LINEOBJECT)
    SET sqltext = "DELETE FROM "_tableName_" WHERE purchaseOrderId=?"
    SET statement = ##class(%SQL.Statement).%New()
    set status = statement.%Prepare(sqltext) 
    if $$$ISOK(status) {
        set rs = statement.%Execute(orderId)
        if ( rs.%SQLCODE '= 0 ) {
            if (rs.%SQLCODE = 100) {
                do ..%SetStatusCode("404")
            } else {            
                do ..%SetStatusCode("500")
            }
            set sc = $$$ERROR($$$SQLCode,SQLCODE,$g(%msg))
        }
    }
    else {
        set sc = status
    }
    Return sc
}

ClassMethod CreatePurchaseOrder(body As %DynamicObject) As %DynamicObject
{
    try {
        //set so = ##class(SC.Data.PurchaseOrder).%New()
        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(..#OBJECTNAME)
        set so = $System.OBJ.New(classname)
        do so.%JSONImport(body)
        set st = so.%Save()
        set failed = 0
        set message = ""
        if $$$ISOK(st) {
            set lines = body.lineItems
            if lines.%Size() > 0 {
                set i = lines.%GetIterator()
                while i.%GetNext(.key, .line) {
                    // write "Key value > "_key_":"_line,!
                    Set line.purchaseOrderId = so.uid
                    Set line.uid = so.uid_"-"_line.lineNumber
                    //Set sol = ##class(SC.Data.PurchaseOrderLine).%New()
                    set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(..#LINEOBJECT)
                    set sol = $System.OBJ.New(classname)
                    do sol.%JSONImport(line)
                    set st = sol.%Save()
                    if '$$$ISOK(st) { 
                        set failed = 1
                        set message = "Failed to save purchase order line with line number ["_line.lineNumber_"]."
                        QUIT
                    }
                }
            }
        }
        else {
            set failed = 1
            set message = "Failed to save PurchaseOrder"
        }
        if ( failed = 1 ) {
            // TODO: add transaction handling to roll back all saves
            do ..%SetStatusCode("500")
            return {"Status": "Failed", 
                    "Message": (message) }
        }
        else {
            do ..%SetStatusCode("201")
            Set soRes = ..GetPurchaseOrderById(so.uid)
            return soRes 
        }

    } catch (ex) {
        do ..%SetStatusCode("500")
        return {"Status": "Error", "Message": "Server error"}		
	}
}

/// Update a purchase order
ClassMethod UpdatePurchaseOrder(orderId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, orderId, body)
}

/// Get or find purchase orders
ClassMethod GetPurchaseOrders() As %DynamicAbstractObject
{
    set idSelect = ""
    return ..GetPurchaseOrdersWithIdSelect(idSelect)
}

ClassMethod GetPurchaseOrdersWithIdSelect(idSelect As %String) As %DynamicAbstractObject
{
    //return { "Status": "Pass3"}
    //return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
    try {
        set tableAlias = ..#POALIAS
        set className = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(..#OBJECTNAME)
        set classInfo = ##class(SC.Core.Util.ClassInfo).%New(className)
        set orderArr = [] 
        set pageSize = ..GetPageSize()
        set pageIndex = ..GetPageIndex()
        set orderBy = ..GetOrderByClause(classInfo, ..#DEFAULTSORTING, tableAlias)
        set startIndex = pageSize * pageIndex
        set endIndex = pageSize * (pageIndex + 1)

        Set where = ..GetWhereClause(classInfo, tableAlias)
        set originalWhere = where
        if idSelect '= "" {
            if where = "" {
                set where = " "_tableAlias_".ID IN ("_idSelect_")"
            }
            else {
                set where = where_" AND "_tableAlias_".ID IN ("_idSelect_")"
            }
        }

        set sql = ..ConstructPurchaseOrderSQL(classInfo.Attributes, startIndex, endIndex, where, orderBy, tableAlias)
        set attributes = classInfo.Attributes
        set attrList = $LISTFROMSTRING(attributes)
        set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
        if ( rs.%SQLCODE < 0 ) {
            // Syntax error of the sql statement, possible SQL injection risk.
            $$$ThrowStatus($$$ERROR($$$SQLCode,SQLCODE,$g(%msg)))
        }
        set count = 0
		while rs.%Next() {
            set count = count +1
            set order = {}
            set ptr=0
            set uid = ""
            while $LISTNEXT(attrList, ptr, attrName) {
                set value = rs.%Get(attrName)
                if value '= "" {
                    if (classInfo.isDateTimeAttribute(attrName) ) {
                        set value = ..formatDateTimeValue(value)
                    }
                    do order.%Set(attrName, value)
                    if ( attrName = "uid" ) { set uid = value}
                }   
            }
            set lineArray =  ..GetPurchaseOrderLineArray(uid)
            do order.%Set("lineItems", lineArray)
            set issues = ##class(SC.Core.Util.KpiIssueUtil).constructJsonForObjectIssue(..#OBJECTNAME, uid)
            if issues '= "" {
                do order.%Set("issues", issues)
            }
			do orderArr.%Push(order)
        }
        do ..%SetHeader("pageSize", pageSize)
        do ..%SetHeader("pageIndex", pageIndex)
        do ..%SetHeader("orderBy", orderBy)
        do ..%SetHeader("returnCount", count)
        do ..%SetHeader("whereClause", originalWhere)
        return orderArr.%ToJSON()
    } catch (ex) {
        do ..%SetStatusCode("500")
        return {"Status": "Error", "Message": "Server error"}		
	}
}

ClassMethod ConstructPurchaseOrderSQL(attributes As %String, startIndex As %Integer, endIndex As %Integer, where As %String, orderBy As %String, tableAlias As %String) As %String
{
    set tableName = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName(..#OBJECTNAME)
    Set sql = "SELECT *, %VID as vid FROM ( SELECT TOP ("_endIndex_") "
    set attrList = $LISTFROMSTRING(attributes)
    set ptr=0
    set first = 0
    while $LISTNEXT(attrList, ptr, attrName) {
        if first > 0 {
            set sql = sql_", "
        }
        else {
            set first = 1
        }
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

/// Get purchase order by ID
ClassMethod GetPurchaseOrderById(uid As %String) As %DynamicObject
{
    try {
        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(..#OBJECTNAME)
        set exists = $CLASSMETHOD(classname,"uidIndexExists", uid)
        if (exists = 0) {
		    do ..%SetStatusCode("404")
		    return {"Status": "Failed", 
                    "Message": ("No PurchaseOrder with uid ["_uid_"] was found.")}            
        }
        set order =  $CLASSMETHOD(classname,"uidIndexOpen", uid)
        do order.%JSONExportToString(.orderOut)
        set returnOrder = ##class(%DynamicAbstractObject).%FromJSON(.orderOut)
        
        set lineArray =  ..GetPurchaseOrderLineArray(uid)
        do returnOrder.%Set("lineItems", lineArray)

        set issues = ##class(SC.Core.Util.KpiIssueUtil).constructJsonForObjectIssue(..#OBJECTNAME, uid)
        if issues '= "" {
            do returnOrder.%Set("issues", issues)
        }
        return returnOrder
    } catch (ex) {
        do ..%SetStatusCode("500")
        return {"Status": "Error", "Message": "Server error"}
    }
}

ClassMethod GetPurchaseOrderLineArray(orderId As %String) As %DynamicArray
{
    set lineArray = []

    set lineObjectName = ..#LINEOBJECT
    set className = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(lineObjectName)
    set tableName = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName(lineObjectName)
    set classInfo = ##class(SC.Core.Util.ClassInfo).%New(className)
    set sql = "select * from "_tableName_" where purchaseOrderId = '"_orderId_"' "
    //write !,"SQL: "_sql
    set attrList = $LISTFROMSTRING(classInfo.Attributes)
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
    if ( rs.%SQLCODE = 0 ) {
	    while rs.%Next() {
            set line = {}
            set ptr=0
            while $LISTNEXT(attrList, ptr, attrName) {
                set value = rs.%Get(attrName)
                if value '= "" {
                    if (classInfo.isDateTimeAttribute(attrName) ) {
                        set value = ..formatDateTimeValue(value)
                    }
                    do line.%Set(attrName, value)
                }   
            }
		    do lineArray.%Push(line)
        }
    }
    else {
        if (rs.%SQLCODE = 100) { 
            do ..%SetStatusCode("404")
            // don't throw error - return empty lineArray.
        } else {
            do ..%SetStatusCode("500")
            $$$ThrowStatus($$$ERROR($$$SQLCode,SQLCODE,$g(%msg)))
        }
    }
    return lineArray
}

}
