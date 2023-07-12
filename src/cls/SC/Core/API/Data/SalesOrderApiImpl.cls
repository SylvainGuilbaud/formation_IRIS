/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// API impl class for sales order related APIs
Class SC.Core.API.Data.SalesOrderApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class: SalesOrder
Parameter OBJECTNAME = "SalesOrder";

/// Object name for SalesOrderLine
Parameter LINEOBJECT = "SalesOrderLine";

/// Default sorting attribute
Parameter DEFAULTSORTING = "-orderPlacedDate";

/// Sales order alias used in SQL statements
Parameter SOALIAS = "so";

/// Delete a sales order 
ClassMethod DeleteSalesOrder(orderId As %String) As %DynamicObject
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
        // Delete order lines first, to avoid foreign key violations
        set st = ..DeleteLinesForSalesOrder(orderId)
        if $$$ISOK(st) {
            // After deleting the order lines, delete the order
            set st = $CLASSMETHOD(classname,"uidIndexDelete", orderId)
            if $$$ISOK(st) {
                do ..%SetStatusCode("200")
		        return {"Status": "Success", 
                        "Message": ("Successfully deleted "_objectName_" with uid ["_orderId_"]. ")}               
            }
            else {
                do ..%SetStatusCode("500")
		        return {"Status": "Failed", 
                    "Message": ("Failed to delete "_objectName_" with uid ["_orderId_"] due to: "
                    _$System.Status.GetErrorText(st))}
            }
        }
        else {
		    do ..%SetStatusCode("500")
		    return {"Status": "Failed", 
                    "Message": ("Failed to delete order lines associated with SalesOrder with uid ["_orderId_"]. ")}
        }
	} catch (ex) {
		do ..%SetStatusCode("500")
		return {"Status": "Error", 
                "Message": ("Failed to delete "_objectName_" with uid ["_orderId_"]. ")}
	}
}

/// Delete all sales order lines for a given sales order
ClassMethod DeleteLinesForSalesOrder(orderId As %String) As %Status
{
    Set sc = $$$OK
    set tableName = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName(..#LINEOBJECT)
    SET sqltext = "DELETE FROM "_tableName_" WHERE salesOrderId=?"
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

ClassMethod CreateSalesOrder(body As %DynamicObject) As %DynamicObject
{
    try {
        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(..#OBJECTNAME)
        set so = $System.OBJ.New(classname)
        do so.%JSONImport(body)
        set st = so.%Save()
        set failed = 0
        set message = ""
        if $$$ISOK(st) {
            write !,"SalesOrder saved successfully"
            set lines = body.lineItems
            if lines.%Size() > 0 {
                set i = lines.%GetIterator()
                while i.%GetNext(.key, .line) {
                    // write "Key value > "_key_":"_line,!
                    Set line.salesOrderId = so.uid
                    Set line.uid = so.uid_"-"_line.lineNumber
                    set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(..#LINEOBJECT)
                    set sol = $System.OBJ.New(classname)                    
                    do sol.%JSONImport(line)
                    set st = sol.%Save()
                    if '$$$ISOK(st) { 
                        set failed = 1
                        set message = "Failed to save sales order line with line number ["_line.lineNumber_"]."
                        write !,message
                        QUIT
                    }
                    //write !, "Successfully saved SalesOrderLine "_line.lineNumber
                }
            }
        }
        else {
            do $system.Status.DisplayError(st)
            set failed = 1
            set message = "Failed to save SalesOrder"
        }
        if ( failed = 1 ) {
            // TODO: add transaction handling to roll back all saves
            do ..%SetStatusCode("500")
            return {"Status": "Failed", 
                    "Message": (message) }
        }
        else {
            do ..%SetStatusCode("201")
            Set soRes = ..GetSalesOrderById(so.uid)
            return soRes 
        }

    } catch (ex) {
        do ..%SetStatusCode("500")
        return {"Status": "Error", "Message": "Server error"}		
	}
}

/// Update a sales order
ClassMethod UpdateSalesOrder(orderId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, orderId, body)
}

/// Get or find sales orders
ClassMethod GetSalesOrders() As %DynamicAbstractObject
{
    set idSelect = ""
    return ..GetRecordsWithIdSelect(idSelect)
}

/// This method is used for both regular data model API and KPI API calls.
/// Do not change the name of this method!
ClassMethod GetRecordsWithIdSelect(idSelect As %String) As %DynamicAbstractObject
{
    //return { "Status": "Pass3"}
    //return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
    try {
        set tableAlias = ..#SOALIAS
        set className = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(..#OBJECTNAME)
        set classInfo = ##class(SC.Core.Util.ClassInfo).%New(className)
        set orderArr = [] 
        set pageSize = ..GetPageSize()
        set pageIndex = ..GetPageIndex()
        set orderBy = ..GetOrderByClause(classInfo, ..#DEFAULTSORTING, tableAlias)
        set startIndex = pageSize * pageIndex
        set endIndex = pageSize * (pageIndex + 1)

        Set where = ..GetWhereClause(classInfo, tableAlias)
        //return {"where": (where)}
        set originalWhere = where
        if idSelect '= "" {
            if where = "" {
                set where = " "_tableAlias_".ID IN ("_idSelect_")"
            }
            else {
                set where = where_" AND "_tableAlias_".ID IN ("_idSelect_")"
            }
        }

        set sql = ..ConstructSalesOrderSQL(classInfo.Attributes, startIndex, endIndex, where, orderBy, tableAlias)
        set attributes = classInfo.Attributes
        set attrList = $LISTFROMSTRING(attributes)
        set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
        if rs.%SQLCODE < 0 {
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
            set lineArray =  ..GetSalesOrderLineArray(uid)
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

ClassMethod ConstructSalesOrderSQL(attributes As %String, startIndex As %Integer, endIndex As %Integer, where As %String, orderBy As %String, tableAlias As %String) As %String
{
    set tableName = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName(..#OBJECTNAME)
    Set sql = "SELECT *, %VID as vid FROM ( SELECT TOP ("_endIndex_") "
    //set attributes = ##class(SC.Core.Util.ScObjectUtil).getObjectAttributes(objectName)
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

/// Get sales order by ID
ClassMethod GetSalesOrderById(uid As %String) As %DynamicObject
{
    try {
        set objectName = ..#OBJECTNAME
        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectName)
        set exists = $CLASSMETHOD(classname,"uidIndexExists", uid)
        if (exists = 0) {
		    do ..%SetStatusCode("404")
		    return {"Status": "Failed", 
                    "Message": ("No SalesOrder with uid ["_uid_"] was found.")}            
        }
        set order =  ##class(SC.Data.SalesOrder).uidIndexOpen(uid) 
        do order.%JSONExportToString(.orderOut)
        set returnOrder = ##class(%DynamicAbstractObject).%FromJSON(.orderOut)
        
        set lineArray =  ..GetSalesOrderLineArray(uid)
        do returnOrder.%Set("lineItems", lineArray)

        set issues = ##class(SC.Core.Util.KpiIssueUtil).constructJsonForObjectIssue(objectName, uid)
        if issues '= "" {
            do returnOrder.%Set("issues", issues)
        }
        return returnOrder
    } catch (ex) {
        do ..%SetStatusCode("500")
        return {"Status": "Error", "Message": "Server error"}
    }
}

ClassMethod GetSalesOrderLineArray(orderId As %String) As %DynamicArray
{
    set lineArray = []

    set lineObjectName = ..#LINEOBJECT
    set className = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(lineObjectName)
    set tableName = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName(lineObjectName)
    set classInfo = ##class(SC.Core.Util.ClassInfo).%New(className)
    //set sql = "select * from "_tableName_" where salesOrderId = '"_orderId_"' "
    //write !,"SQL: "_sql
    set sql = "select * from "_tableName_" where salesOrderId = ? "
    set statement = ##class(%SQL.Statement).%New(1)
    set st = statement.%Prepare(sql)
    if $$$ISOK(st) { 
        set rs = statement.%Execute(orderId)
        set attrList = $LISTFROMSTRING(classInfo.Attributes)
        //set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
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
        } else 
        { 
            if (rs.%SQLCODE = 100) {
                do ..%SetStatusCode("404")
                // don't throw exception, let the code return empty lineArray
            } else {         
                do ..%SetStatusCode("500")
                $$$ThrowStatus($$$ERROR($$$SQLCode,SQLCODE,$g(%msg)))
            }
        }
    }
    return lineArray
}

/// Construct the order SQL statement string
/// TODO: delete this after using it as a reference
ClassMethod ConstructOrderSQL(pStartIndex As %Integer, pEndIndex As %Integer, pWhere As %String, pOrderBy As %String) As %String
{
    Set sql = "SELECT *, %VID as vid FROM ("_
              "  SELECT TOP ("_pEndIndex_") "_..#SOALIAS_".ID1, "_..#SOALIAS_".id, "_..#SOALIAS_".changeOrderDate, "_
              ..#SOALIAS_".committedDeliveryDate, "_..#SOALIAS_".committedShipDate, "_..#SOALIAS_".customerId, "_
              ..#SOALIAS_".customerPoNumber, "_..#SOALIAS_".dataSource, "_..#SOALIAS_".lastModifiedDate, "_
              ..#SOALIAS_".lastUpdatedTime, "_..#SOALIAS_".orderCurrency, "_..#SOALIAS_".orderPlacedDate, "_
              ..#SOALIAS_".orderStatus, "_..#SOALIAS_".orderValue, "_..#SOALIAS_".requestedDeliveryDate, "_
              ..#SOALIAS_".requestedShipDate, "_..#SOALIAS_".salesOrganization, "_..#SOALIAS_".salesRegion, "_
              ..#SOALIAS_".shipToLocationId, "_..#SOALIAS_".sourceOrderId, "_..#SOALIAS_".recordCreatedTime, "_
              "cust.name AS customerName "_
              "  FROM "_##class(SC.Core.Util.ScObjectUtil).#SCTABLEPREFIX_".SalesOrder AS "_..#SOALIAS_"  LEFT OUTER JOIN "_
              ##class(SC.Core.Util.ScObjectUtil).#SCTABLEPREFIX_".Customer AS cust "_
              "  ON "_..#SOALIAS_".customerId = cust.id"
    if pWhere '= "" {
        Set sql = sql_" WHERE "_pWhere
    }
    Set sql = sql_"  ORDER BY "_pOrderBy_
              ") WHERE %VID > "_pStartIndex
    Return sql
}

}
