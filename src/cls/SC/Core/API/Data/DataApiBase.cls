/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Base implementation class for all API implementations. To use implementations in this
/// base class, the following assumptions must be true for the object:
/// 1, The object has a primary key "uid", with associated index "uidIndex".
/// 2, The package must be "SC.Data"
/// 3, Only primitive attributes are returned, not the contained objects.
/// 4, Class must inherit from %Persistent, %JSON.Adaptor
/// If a class does not satisfy the conditions above, you can pick some implementations
/// in this class, and override the ones does not work for you.
Class SC.Core.API.Data.DataApiBase Extends SC.Core.API.ApiBaseImpl [ ProcedureBlock ]
{

/// Generic implementation of create object API
ClassMethod ObjectCreate(objectName As %String, body As %DynamicObject) As %DynamicObject
{
    try { 
        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectName)
        set obj = $System.OBJ.New(classname)
        do obj.%JSONImport(body)
        set st = obj.%Save()
        if $$$ISOK(st) {
            do ..%SetStatusCode("201")
            do obj.%JSONExportToString(.objRes)
            return objRes
        }
        else {
		    do ..%SetStatusCode("500")
		    return {"Status": "Error", 
                    "Message": ("Failed to save object "_objectName_" due to: "
                    _$System.Status.GetErrorText(st))}            
        }
	} catch (ex) {
		do ..%SetStatusCode("500")
		return {"Status": "Error", 
                "Message": ("Failed to create object "_objectName_". ")}
	}
}

/// Generic implementation of delete object API
ClassMethod ObjectDelete(objectName As %String, uid As %String) As %DynamicObject
{
    try { 
        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectName)
        set exists = $CLASSMETHOD(classname,"uidIndexExists", uid)
        if exists = 0 {
		    do ..%SetStatusCode("400")
		    return {"Status": "Failed", 
                    "Message": ("No "_objectName_" with uid ["_uid_"] was found.")}            
        }
        set st = $CLASSMETHOD(classname,"uidIndexDelete", uid)
        if $$$ISOK(st) {
            do ..%SetStatusCode("200")
		    return {"Status": "Success", 
                    "Message": ("Successfully deleted "_objectName_" with uid ["_uid_"]. ")}
        }
        else {
		    do ..%SetStatusCode("500")
		    return {"Status": "Failed", 
                    "Message": ("Failed to delete "_objectName_" with uid ["_uid_"] due to: "
                    _$System.Status.GetErrorText(st))}
        }
	} catch (ex) {
		do ..%SetStatusCode("500")
		return {"Status": "Error", 
                "Message": ("Failed to delete "_objectName_" with uid ["_uid_"]. ")}
	}
}

/// Generic implementation of update object API
ClassMethod ObjectUpdate(objectName As %String, uid As %String, body As %DynamicObject) As %DynamicObject
{
    try { 
        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectName)
        set exists = $CLASSMETHOD(classname,"uidIndexExists", uid)
        if exists = 0 {
		    do ..%SetStatusCode("400")
		    return {"Status": "Failed", 
                    "Message": ("No "_objectName_" with uid ["_uid_"] was found.")}            
        }
        set obj = $CLASSMETHOD(classname,"uidIndexOpen", uid)
        do obj.%JSONImport(body)
        set st = obj.%Save()
        if $$$ISOK(st) {
            do obj.%JSONExportToString(.objRes)
            return objRes
        }
        else {
		    do ..%SetStatusCode("500")
		    return {"Status": "Error", 
                    "Message": ("Failed to save object "_objectName_" due to: "
                    _$System.Status.GetErrorText(st))}            
        }
	} catch (ex) {
		do ..%SetStatusCode("500")
		return {"Status": "Error", 
                "Message": ("Failed to update "_objectName_" with uid ["_uid_"]. ")}
	}
}

/// Get an object by object name and uid
ClassMethod ObjectGetByUid(objectName As %String, uid As %String) As %DynamicObject
{
    try { 
        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectName)
        set exists = $CLASSMETHOD(classname,"uidIndexExists", uid)
        if exists = 0 {
		    do ..%SetStatusCode("404")
		    return {"Status": "Failed", 
                    "Message": ("No "_objectName_" with uid ["_uid_"] was found.")}            
        }
        set obj = $CLASSMETHOD(classname,"uidIndexOpen", uid)
        do obj.%JSONExportToString(.objRes)
        set returnObj = ##class(%DynamicAbstractObject).%FromJSON(objRes)

        if ( objectName '= "Issue" ) {
            set issues = ##class(SC.Core.Util.KpiIssueUtil).constructJsonForObjectIssue(objectName, uid)
            if issues '= "" {
                do returnObj.%Set("issues", issues)
            }  
        }      
        return returnObj
	} catch (ex) {
		do ..%SetStatusCode("500")
		return {"Status": "Error", 
                "Message": ("Failed to retrieve object "_objectName_" with uid ["_uid_"]. ")}
	}
}

ClassMethod ObjectGetAll(objectName As %String, defaultSorting As %String, tableAlias As %String = "") As %DynamicObject
{
    set idSelect = ""
    return ..ObjectGetAllWithIdSelect(objectName, defaultSorting, tableAlias, idSelect)
}

/// This is the default implementation for getAll() or search function on a data object. It support pagination, sorting, 
/// as well as any search criteria based on any attribute of the object.
ClassMethod ObjectGetAllWithIdSelect(objectName As %String, defaultSorting As %String, tableAlias As %String, idSelect As %String) As %DynamicObject
{
    
    try {
        set className = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectName)
        set classInfo = ##class(SC.Core.Util.ClassInfo).%New(className)
        set objArr = [] 
        set pageSize = ..GetPageSize()
        set pageIndex = ..GetPageIndex()
        set orderBy = ..GetOrderByClause(classInfo, defaultSorting, tableAlias)
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
        


        set sql = ..ConstructObjectSQL(objectName, classInfo.Attributes, startIndex, endIndex, where, orderBy, tableAlias)
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
            while $LISTNEXT(attrList, ptr, attrName) {
                set value = rs.%Get(attrName)
                if (classInfo.isDateTimeAttribute(attrName) ) {
                    set value = ..formatDateTimeValue(value)
                }
                if value '= "" {
                    do obj.%Set(attrName, value)
                }   
            }

            //return {"Status": "LOcation 3"}

            if ( objectName '= "Issue" ) {
                set issues = ##class(SC.Core.Util.KpiIssueUtil).constructJsonForObjectIssue(objectName, rs.%Get("uid"))
                if issues '= "" {
                    do obj.%Set("issues", issues)
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
        return {"Status": "Error", 
                "Message": ("Server error "_ex.DisplayString())}
	}
}

/// Construct the Get/Search SQL statement, with pagenation, search parameter support
ClassMethod ConstructObjectSQL(objectName As %String, attributes As %String, startIndex As %Integer, endIndex As %Integer, where As %String, orderBy As %String, tableAlias As %String)
{
    set tableName = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName(objectName)
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
    Set sql = sql_" ORDER BY "_orderBy_
              ") WHERE %VID > "_startIndex
    return sql
}

ClassMethod formatDateTimeValue(value As %DateTime) As %String
{
    if value '= "" {
        //Set jsonString = $ZDATETIME(value, 3)
        set value = $Replace(value, " ", "T")
        Return value_"Z"
    }
    else {
        return ""
    }
}

}
