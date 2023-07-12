/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.SupplyShipmentApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "SupplyShipment";

/// Object name for SupplyShipmentLine
Parameter LINEOBJECT = "SupplyShipmentLine";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

/// Supply shipment alias used in SQL statements
Parameter SPSALIAS = "sps";

ClassMethod GetSupplyShipments() As %DynamicObject
{
    set idSelect = ""
    return ..GetRecordsWithIdSelect(idSelect)
}

ClassMethod GetRecordsWithIdSelect(idSelect As %String) As %DynamicAbstractObject
{
    //return { "Status": "Pass3"}
    //return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
    try {
        set tableAlias = ..#SPSALIAS
        set className = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(..#OBJECTNAME)
        set classInfo = ##class(SC.Core.Util.ClassInfo).%New(className)
        set shipmentArr = [] 
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

        set sql = ..ConstructSupplyShipmentSQL(classInfo.Attributes, startIndex, endIndex, where, orderBy, tableAlias)
        set attributes = classInfo.Attributes
        set attrList = $LISTFROMSTRING(attributes)
        set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
        if rs.%SQLCODE < 0 {
            $$$ThrowStatus($$$ERROR($$$SQLCode,SQLCODE,$g(%msg)))
        }
        set count = 0
		while rs.%Next() {
            set count = count +1
            set uid = rs.uid
            set shipmentObject = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(..#OBJECTNAME, uid)
            do shipmentObject.%JSONExportToString(.objStr)
            set shipment = ##class(%DynamicAbstractObject).%FromJSON(objStr)
            // The following code is replace by the the logic above: now using JsonAdaptor to generate JSON from object
            // instead of manually creating json for each attributes. Part of SC-150 fix.
            //set shipment = {}
            //set ptr=0
            //set uid = ""
            //while $LISTNEXT(attrList, ptr, attrName) {
            //    set value = rs.%Get(attrName)
            //    if value '= "" {
            //        if (classInfo.isDateTimeAttribute(attrName) ) {
            //            set value = ..formatDateTimeValue(value)
            //        }
            //        do shipment.%Set(attrName, value)
            //        if ( attrName = "uid" ) { set uid = value}
            //    }   
            //}

            set lineArray =  ..GetSupplyShipmentLineArray(uid)
            do shipment.%Set("lineItems", lineArray)
            set issues = ##class(SC.Core.Util.KpiIssueUtil).constructJsonForObjectIssue(..#OBJECTNAME, uid)
            if issues '= "" {
                do shipment.%Set("issues", issues)
            }              
			do shipmentArr.%Push(shipment)
        }
        do ..%SetHeader("pageSize", pageSize)
        do ..%SetHeader("pageIndex", pageIndex)
        do ..%SetHeader("orderBy", orderBy)
        do ..%SetHeader("returnCount", count)
        do ..%SetHeader("whereClause", originalWhere)
        return shipmentArr.%ToJSON()
    } catch (ex) {
        do ..%SetStatusCode("500")
        return {"Status": "Error", "Message": "Server error"}		
	}
}

ClassMethod GetSupplyShipmentById(uid As %String) As %DynamicObject
{
    try {
        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(..#OBJECTNAME)
        set exists = $CLASSMETHOD(classname,"uidIndexExists", uid)
        if (exists = 0) {
		    do ..%SetStatusCode("404")
		    return {"Status": "Failed", 
                    "Message": ("No SupplyShipment with uid ["_uid_"] was found.")}            
        }
        set order =  $CLASSMETHOD(classname,"uidIndexOpen", uid)
        do order.%JSONExportToString(.orderOut)
        set returnOrder = ##class(%DynamicAbstractObject).%FromJSON(.orderOut)
        
        set lineArray =  ..GetSupplyShipmentLineArray(uid)
        do returnOrder.%Set("lineItems", lineArray)
        
        set milestones = ##class(SC.Core.Util.MilestoneUtil).constructJsonForObjectMilestone(..#OBJECTNAME, uid)
        if milestones '= "" {
            do returnOrder.%Set("milestones", milestones)
        } 

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

ClassMethod CreateSupplyShipment(body As %DynamicObject) As %DynamicObject
{
    try {
        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(..#OBJECTNAME)
        set so = $System.OBJ.New(classname)
        do so.%JSONImport(body)
        set st = so.%Save()
        set failed = 0
        set message = ""
        if $$$ISOK(st) {
            write !,"SupplyShipment saved successfully"
            set lines = body.lineItems
            if lines.%Size() > 0 {
                set i = lines.%GetIterator()
                while i.%GetNext(.key, .line) {
                    // write "Key value > "_key_":"_line,!
                    Set line.supplyShipmentId = so.uid
                    Set line.uid = so.uid_"-"_line.lineNumber
                    set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(..#LINEOBJECT)
                    set sol = $System.OBJ.New(classname)                    
                    do sol.%JSONImport(line)
                    set st = sol.%Save()
                    if '$$$ISOK(st) { 
                        set failed = 1
                        set message = "Failed to save supply shipment line with line number ["_line.lineNumber_"]."
                        write !,message
                        QUIT
                    }
                    //write !, "Successfully saved SupplyOrderLine "_line.lineNumber
                }
            }
        }
        else {
            do $system.Status.DisplayError(st)
            set failed = 1
            set message = "Failed to save SupplyShipment"
        }
        if ( failed = 1 ) {
            // TODO: add transaction handling to roll back all saves
            do ..%SetStatusCode("500")
            return {"Status": "Failed", 
                    "Message": (message) }
        }
        else {
            do ..%SetStatusCode("201")
            Set soRes = ..GetSupplyShipmentById(so.uid)
            return soRes 
        }

    } catch (ex) {
        do ..%SetStatusCode("500")
        return {"Status": "Error", "Message": "Server error"}		
	}
}

ClassMethod DeleteSupplyShipment(shipmentId As %String) As %DynamicObject
{
    try { 
        set objectName = ..#OBJECTNAME
        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectName)
        set exists = $CLASSMETHOD(classname,"uidIndexExists", shipmentId)
        if exists = 0 {
		    do ..%SetStatusCode("400")
		    return {"Status": "Failed", 
                    "Message": ("No "_objectName_" with uid ["_shipmentId_"] was found.")}            
        }
        // Delete shipment lines first, to avoid foreign key violations
        set st = ..DeleteLinesForSupplyShipment(shipmentId)
        if $$$ISOK(st) {
            // After deleting the lines, delete the shipment
            set st = $CLASSMETHOD(classname,"uidIndexDelete", shipmentId)
            if $$$ISOK(st) {
                do ..%SetStatusCode("200")
		        return {"Status": "Success", 
                        "Message": ("Successfully deleted "_objectName_" with uid ["_shipmentId_"]. ")}               
            }
            else {
                do ..%SetStatusCode("500")
		        return {"Status": "Failed", 
                    "Message": ("Failed to delete "_objectName_" with uid ["_shipmentId_"] due to: "
                    _$System.Status.GetErrorText(st))}
            }
        }
        else {
		    do ..%SetStatusCode("500")
		    return {"Status": "Failed", 
                    "Message": ("Failed to delete lines associated with "_objectName_" with uid ["_shipmentId_"]. ")}
        }
	} catch (ex) {
		do ..%SetStatusCode("500")
		return {"Status": "Error", 
                "Message": ("Failed to delete "_objectName_" with uid ["_shipmentId_"]. ")}
	}
}

/// Update a supply shipment info
ClassMethod UpdateSupplyShipment(shipmentId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, shipmentId, body)
}

/// Delete all lines for a shipment 
ClassMethod DeleteLinesForSupplyShipment(shipmentId As %String) As %Status
{
    Set sc = $$$OK
    set tableName = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName(..#LINEOBJECT)
    SET sqltext = "DELETE FROM "_tableName_" WHERE supplyShipmentId=?"
    SET statement = ##class(%SQL.Statement).%New()
    set status = statement.%Prepare(sqltext) 
    if $$$ISOK(status) {
        set rs = statement.%Execute(shipmentId)
        if ( rs.%SQLCODE '= 0 ) {
            if (rs.%SQLCODE = 100) {
                do ..%SetStatusCode("404")
            } else {            
                do ..%SetStatusCode("500")
            }
            set sc = $$$ERROR($$$SQLError, SQLCODE, $g(%msg))
        }
    }
    else {
        set sc = status
    }
    Return sc
}

ClassMethod GetSupplyShipmentLineArray(shipmentId As %String) As %DynamicArray
{
    set lineArray = []

    set lineObjectName = ..#LINEOBJECT
    set className = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(lineObjectName)
    set tableName = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName(lineObjectName)
    set classInfo = ##class(SC.Core.Util.ClassInfo).%New(className)
    set sql = "select * from "_tableName_" where supplyShipmentId = '"_shipmentId_"' "
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
        } else {         
            do ..%SetStatusCode("500")
            return {
            "status": "Error",
            "errorCode": ("SQL["_rs.%SQLCODE_"]"),
            "errorMessage": (rs.%Message)
            } 
        }
    }
    return lineArray
}

ClassMethod ConstructSupplyShipmentSQL(attributes As %String, startIndex As %Integer, endIndex As %Integer, where As %String, orderBy As %String, tableAlias As %String) As %String
{
    set tableName = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName(..#OBJECTNAME)
    Set sql = "SELECT *, %VID as vid FROM ( SELECT TOP ("_endIndex_") "_tableAlias_".uid"
    set attrList = $LISTFROMSTRING(attributes)
    set ptr=0
    set first = 0
    // The following code commented out does not work for some non-primitive property types. 
    // The change is part of SC-150 fix
    //while $LISTNEXT(attrList, ptr, attrName) {
    //    if first > 0 {
    //        set sql = sql_", "
    //    }
    //    else {
    //        set first = 1
    //    }
    //    if tableAlias '= "" {
    //        set sql = sql_tableAlias_"."
    //    }
    //    set sql = sql_attrName
    //}
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
