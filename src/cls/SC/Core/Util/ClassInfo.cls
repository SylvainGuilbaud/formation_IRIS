/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Object used to capture some basic information about an object
Class SC.Core.Util.ClassInfo Extends %RegisteredObject
{

/// class name
Property ClassName As %String;

/// All attributes in the class
Property Attributes As %String;

/// String type attributes
Property StringAttributes As %String;

/// Numerical type attributes
Property NumericalAttributes As %String;

/// DateTime attributes
Property DatetimeAttributes As %String;

/// Date attributes
Property DateAttributes As %String;

/// OnNew override
Method %OnNew(className As %String) As %Status
{
    Set sc = $$$OK
    set ..ClassName = className
    set Attributes = ""
    set stringAttrs = ""
    set numAttrs = ""
    set datetimeAttrs = ""
    set dateAttrs = ""
    set sql="select name, type, sqlFieldName from %Dictionary.CompiledProperty " _ 
            " where storable = 1 and parent=? order by SequenceNumber"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql, className)
    if ( rs.%SQLCODE = 0 ) {
        while ( rs.%Next() '= 0 ) {
            set attr = rs.name
            set type = rs.type
            if ( attr = "recordCreatedTime") || (attr = "lastUpdatedTime" ) { CONTINUE }
            if Attributes = "" {
                set Attributes = attr
            }
            else {
                set Attributes = Attributes _ ","_attr
            }
            if (type = "%Library.String") || (type = "%Library.ExactString")  || (type = "%Library.EnumString") 
                || (type = "%Library.ExactString") || (type = "%Library.Name")  {
                if stringAttrs = "" {
                    set stringAttrs = attr 
                }
                else {
                    set stringAttrs = stringAttrs_","_attr
                }
            }
            elseif (type = "%Library.Numeric") || (type = "%Library.Decimal") || (type = "%Library.Integer") 
                    || (type = "%Library.Double") || (type = "%Library.SmallInt") || (type ="%Library.TinyInt") 
                    || (type = "%Library.BigInt") || (type = "%Library.Boolean") || (type = "%Library.Counter") {
                if numAttrs = "" {
                    set numAttrs = attr 
                }
                else {
                    set numAttrs = numAttrs_","_attr
                }
            }
            elseif (type = "%Library.DateTime") || (type = "%Library.TimeStamp") { 
                if datetimeAttrs = "" {
                    set datetimeAttrs = attr 
                }
                else {
                    set datetimeAttrs = datetimeAttrs_","_attr
                }
            }
            elseif (type = "%Library.Date")  { 
                if dateAttrs = "" {
                    set dateAttrs = attr 
                }
                else {
                    set dateAttrs = dateAttrs_","_attr
                }
            }
        }
        set Attributes = Attributes_",recordCreatedTime,lastUpdatedTime"
        if datetimeAttrs = "" {
            set datetimeAttrs = "recordCreatedTime,lastUpdatedTime"
        }
        else {
            set datetimeAttrs = datetimeAttrs_",recordCreatedTime,lastUpdatedTime"
        }
        set ..Attributes = Attributes
        set ..StringAttributes = stringAttrs
        set ..NumericalAttributes = numAttrs
        set ..DatetimeAttributes =  datetimeAttrs
        set ..DateAttributes =  dateAttrs
    }
    else {
        set sc = $$$ERROR($$$SQLCode,SQLCODE,$g(%msg))
    }
    Return sc
}

/// CHecks if a given attribute is a DateTime attribute
Method isDateTimeAttribute(attrName As %String) As %Integer
{
    set ret = 0
    if (..DatetimeAttributes '= "") && $find(..DatetimeAttributes, attrName) > 0 { set ret = 1} 
    return ret
}

}
