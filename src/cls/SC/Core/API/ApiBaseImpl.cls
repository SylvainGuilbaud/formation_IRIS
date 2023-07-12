/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Base implementation class for all API implementations. This class includes some 
/// helper methods for pagination, sorting, and search criteria supports.
Class SC.Core.API.ApiBaseImpl Extends %REST.Impl [ ProcedureBlock ]
{

/// String used as separator for data range
Parameter DATARANGESTRING = "..";

/// Null value for a http parameter
Parameter NULLVALUESTRING = "NULL";

/// Not null value string for a http param
Parameter NOTNULLVALUESTRING = "NOTNULL";

/// Default page size for API responses
Parameter DEFAULTPAGESIZE = 100;

/// The list of fields that we can sort by
Parameter SORTBYWHITELIST;

/// Adding a string value from statement result to a dynamic object. Do not add it if the value does not exist.
/// Do not add the attribute if the value is not set.
/// 
/// TODO: how to return NULL/VOID in a method? 
ClassMethod AddStringAttributeFromStatementResult(obj As %DynamicObject, attr As %String, rs As %SQL.StatementResult) As %Status
{
    Set sc = $$$OK
    Set value = rs.%Get(attr)
    if value '= "" {
        do obj.%Set(attr, value)
    } else {
        set sc = $$$ERROR($$$GeneralError,"Attribut not found in result set")
    }
    Return sc
}

/// Add a new attribute to dynamic object, by retrieving a date value from a SQL statement result.
/// Do not add the attribute if the value is not set.
ClassMethod AddDateAttributeFromStatementResult(obj As %DynamicObject, attr As %String, rs As %SQL.StatementResult) As %Status
{
    Set sc = $$$OK
    Set value = rs.%Get(attr)
    if value '= "" {
        // Upcomment the following if the SQL statement mode is default (0)
        //set value = $ZDATE(value, 3)
        do obj.%Set(attr, value)
    } else {
        set sc = $$$ERROR($$$GeneralError,"Attribut not found in result set")
    }
    Return sc
}

/// Add a string values JSON attribute to a dynamic objects, based on the value from a SQL result set.
/// Do not add anything if the result set does not contain a value for the attribute. 
/// 
/// TODO: is there any memory/performance issue to pass the result set to the method?
ClassMethod AddStringAttributeToDynamicObjectFromResultSet(obj As %DynamicArray, attr As %String, rs As %ResultSet) As %Status
{
    Set sc = $$$OK
    Set value = rs.Get(attr)
    if ( value '= "" ) {
        do obj.%Set(attr, value)
    } else {
        set sc = $$$ERROR($$$GeneralError,"Attribut not found in result set")
    }
    Return sc
}

/// Render JSON string for a date value, if using default SQL statement mode (0)
ClassMethod RenderDateForJson(value As %String) As %String
{
    Set jsonString = $ZDATE(value, 3)
    Return jsonString
}

/// Returns the page size value. If the value is set in the path parameter, return the value passed in.
/// If not, return the default value
ClassMethod GetPageSize() As %Integer
{
    Set pageSize = $Get(%request.Data("pageSize",1),..#DEFAULTPAGESIZE)
    Return pageSize
}

/// Returns the pageIndex for the current request. If no value is specifies, use default value (0)
ClassMethod GetPageIndex() As %Integer
{
    Set pageIndex = $Get(%request.Data("pageIndex",1),0)
    Return pageIndex
}

/// Returns the where clause for the searching parameters
ClassMethod GetWhereClause(classInfo As SC.Core.Util.ClassInfo, aliasName As %String) As %String
{
    Set clause = ""
    Set ptr = 0, count = 0
    Set stringAttrList = $LISTFROMSTRING(classInfo.StringAttributes)
    Set dateAttrList = $LISTFROMSTRING(classInfo.DatetimeAttributes)
    Set numAttrList = $LISTFROMSTRING(classInfo.NumericalAttributes)
    WHILE $LISTNEXT(stringAttrList, ptr, attr) {
        Set attrValue = $Get(%request.Data(attr,1))
        if attrValue '= "" {
            Set count = count+1
            Set whereStringValue = ..ConstructWhereForStringAttr(aliasName, attr, attrValue)
            if count = 1 {
                Set clause = whereStringValue
            }
            else {
                Set clause = clause_" AND "_whereStringValue
            }   
        }
    }
    Set ptr = 0
    WHILE $LISTNEXT(dateAttrList, ptr, attr) {
        Set attrValue = $Get(%request.Data(attr,1))
        if attrValue '= "" {
            Set count = count+1
            Set whereStringValue = ..ConstructWhereForDateAttr(aliasName, attr, attrValue)
            if count = 1 {
                Set clause = whereStringValue
            }
            else {
                Set clause = clause_" AND "_whereStringValue
            }   
        }
    }
    Set ptr = 0
    // TODO: add where for Date type attributes
    WHILE $LISTNEXT(numAttrList, ptr, attr) {
        Set attrValue = $Get(%request.Data(attr,1))
        if attrValue '= "" {
            Set count = count+1
            Set whereStringValue = ..ConstructWhereForNumberAttr(aliasName, attr, attrValue)
            if count = 1 {
                Set clause = whereStringValue
            }
            else {
                Set clause = clause_" AND "_whereStringValue
            }   
        }
    }
    return clause
}

/// Check if attribute value is NULL or NOT NULL, if so, return the corresponding SQL where string.
/// If not, return ""
ClassMethod ConstructWhereForNull(aliasPrefix As %String, attr As %String, attrValue As %String) As %String
{
    set ret = ""
    Set attr = ..ConstructSqlAttrName(aliasPrefix, attr)
    Set value = $ZCONVERT(attrValue,"U")
    if value = ..#NULLVALUESTRING {
        set ret = attr_" IS NULL"
    }
    elseif value = ..#NOTNULLVALUESTRING  {
        set ret = attr_" IS NOT NULL"
    }
    return ret
}

/// Construct where for one attribute with date type, for possible date range specified with ":"
ClassMethod ConstructWhereForDateAttr(aliasPrefix As %String, attr As %String, attrValue As %String) As %String
{
    Set ret = ..ConstructWhereForNull(aliasPrefix, attr, attrValue)
    if ret '= "" {
        return ret
    }

    Set attr = ..ConstructSqlAttrName(aliasPrefix, attr)
    if ($FIND(attrValue,..#DATARANGESTRING) > 0 ) {
        // Range specified
        Set min = $PIECE(attrValue,..#DATARANGESTRING,1)
        Set max = $PIECE(attrValue,..#DATARANGESTRING,2)
        if ( min '= "") && (max '= "" ) {
            if (max < min ) {
                Set errMsg = "Invalid value ["_attrValue_"] for date attribute ["_attr_"]." 
                write !,errMsg
                // TODO add error handling
            }
            else {
                Set ret = attr_" >= '"_min_"' AND "_attr_" <= '"_max_"'"
            } 
        }
        elseif (min '= "") {
            Set ret = attr_" >= '"_min_"'"
        }
        else {
            Set ret = attr_" <= '"_max_"'"
        }
    }
    else {
        // Single value specified
        Set ret = attr_"='"_attrValue_"'"
    }
    return ret
}

/// Construct where for one attribute with date type, for possible date range specified with ":"
ClassMethod ConstructWhereForNumberAttr(aliasPrefix As %String, attr As %String, attrValue As %String) As %String
{
    Set ret = ..ConstructWhereForNull(aliasPrefix, attr, attrValue)
    if ret '= "" {
        return ret
    }

    Set attr = ..ConstructSqlAttrName(aliasPrefix, attr)
    if ($FIND(attrValue,..#DATARANGESTRING) > 0 ) {
        // Range specified
        Set min = $PIECE(attrValue,..#DATARANGESTRING,1)
        Set max = $PIECE(attrValue,..#DATARANGESTRING,2)
        if ( min '= "") && (max '= "" ) {
            if (max < min ) {
                Set errMsg = "Invalid value ["_attrValue_"] for numerical attribute ["_attr_"]." 
                write !,errMsg
                // TODO add error handling
            }
            else {
                Set ret = attr_" >= "_min_" AND "_attr_" <= "_max
            } 
        }
        elseif (min '= "") {
            Set ret = attr_" >= "_min
        }
        else {
            Set ret = attr_" <= "_max
        }
    }
    else {
        // Single value specified
        Set ret = attr_"="_attrValue
    }
    return ret
}

/// Construct where for one attribute with string type, for possible multiple values separated by comma
ClassMethod ConstructWhereForStringAttr(aliasPrefix As %String, attr As %String, attrValue As %String) As %String
{
    Set ret = ..ConstructWhereForNull(aliasPrefix, attr, attrValue)
    if ret '= "" {
        return ret
    }

    Set attr = ..ConstructSqlAttrName(aliasPrefix, attr)
    Set valueList = $LISTFROMSTRING(attrValue)
    if $LISTLENGTH(valueList) = 1 {
        Set ret = attr_"='"_attrValue_"'"
    }
    else {
        Set ret = attr_" IN ("
        Set ptr = 0, count = 0
        WHILE $LISTNEXT(valueList, ptr, value) {
            Set count = count+1
            if count > 1 {
                Set ret = ret_", "
            }
            Set ret = ret_"'"_value_"'"
        }
        Set ret = ret_")"
    }
    return ret
}

/// Construct SQL col names with a table prefix
ClassMethod ConstructSqlAttrName(tablePrefix As %String, attrName As %String) As %String
{
    if tablePrefix = "" {
        return attrName
    }
    else {
        return tablePrefix_"."_attrName
    }
}

/// Get the sorting ORDER BY clause value
ClassMethod GetOrderByClause(classInfo As SC.Core.Util.ClassInfo, defaultSorting As %String, aliasName As %String, whitelist As %String = "") As %String
{
    if (whitelist = "") {
        Set whitelist = classInfo.Attributes
    }
    Set sortByParam = $Get(%request.Data("sortBy",1), defaultSorting)
    set orderBy = ..ConvertSortByParamToSqlClause(sortByParam, aliasName, whitelist)
    Return orderBy
}

/// Convert a sortBy parameter value to SQL order by string
ClassMethod ConvertSortByParamToSqlClause(param As %String, aliasName As %String, whitelist As %String) As %String
{
    Set valueList = $LISTFROMSTRING(param,",",0)
    Set allowedAttrs = $LISTFROMSTRING(whitelist,",",0)
    set $LIST(allowedAttrs, *+1) = "ID" // "ID" is always allowed.
    Set clause = ""
    Set ptr = 0, count =0
    WHILE $LISTNEXT(valueList, ptr, value) {
        Set count = count+1
        if $Extract(value,1,1) = "+" {
            Set sortingOrder = "ASC"
            Set value = $Extract(value, 2, *)
        }
        elseif $Extract(value,1,1) = "-" {
            Set sortingOrder = "DESC"
            Set value = $Extract(value, 2, *)
        }
        else {
            // No more default sorting order by attribute type. We will not require "+" for ASC due to 
            // extra overhead for URL encoding. Now, if no "-" prefix, it will be ASC.
            // Set sortingOrder = ..getValueSortingOrder(value)
            Set sortingOrder = "ASC"
        }
        // check if the attr in the white list
        if ($LISTFIND(allowedAttrs, value) > 0) {
            set attr = ..ConstructSqlAttrName(aliasName, value)
            if count > 1 {
                Set clause = clause_", "_attr_" "_sortingOrder
            }
            else {
                Set clause = attr_" "_sortingOrder
            }
        } else {
            set ex = ##class(%Exception.SQL).CreateFromSQLCODE(-400, "Attribute "_value_" of "_$LISTTOSTRING(valueList, ",")_" not allowed in ORDER BY expression. (Allowed values = "_$LISTTOSTRING(allowedAttrs, ",")_")")
            throw ex
        }
    }
    Return clause
}

}
