/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Util.ScObjectUtil
{

/// SQL table name prefix for SC data objects
Parameter SCTABLEPREFIX = "SC_Data";

/// Class package name for SC data objects
Parameter SCPACKAGE = "SC.Data";

/// Returns the SQL table name for a supply chain object
ClassMethod getObjectTableName(objectName As %String) As %String
{
    if $find(objectName, ..#SCTABLEPREFIX) > 0 {
        return objectName
    }
    else {
        return ..#SCTABLEPREFIX_"."_objectName
    }
}

/// Returns the fully qualified class name for a supply chain object
ClassMethod getObjectClassName(objectName As %String) As %String
{
    if $find(objectName, ..#SCPACKAGE) > 0 {
        return objectName
    }
    else {
        return ..#SCPACKAGE_"."_objectName
    }
}

/// Returns a string with all class attributes/properties
ClassMethod getClassAttributes(className As %String) As %String
{
    set ret = ""
    set sql="select name, type, sqlFieldName from %Dictionary.CompiledProperty " _ 
            " where storable = 1 and parent=? order by SequenceNumber"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql, className)
    if rs.%SQLCODE < 0 {
        $$$ThrowStatus($$$ERROR($$$SQLCode,SQLCODE,$g(%msg)))
    }
    if ( rs.%SQLCODE = 0 ) {
        while ( rs.%Next() '= 0 ) {
            set attr = rs.name
            if ret = "" {
                set ret = attr
            }
            else {
                set ret = ret _ ","_attr
            }
        }
    }
    return ret
}

ClassMethod getObjectAttributes(objectName As %String) As %String
{
    set className = ..getObjectClassName(objectName)
    return ..getClassAttributes(className)
}

/// Retrieve an SC data object by it uid. 
ClassMethod getObjectByUid(objectName As %String, uid As %String) As %ObjectHandle
{
    set className = ..getObjectClassName(objectName)
    set obj = $CLASSMETHOD(className,"uidIndexOpen", uid)
    return obj
}

/// Retrieve an SC data object by it uid. 
ClassMethod getObjectById(objectName As %String, id As %Integer) As %ObjectHandle
{
    set className = ..getObjectClassName(objectName)
    set obj = $CLASSMETHOD(className,"%OpenId", id)
    return obj
}

/// Returns the UID of a data object, using object's internal ID
ClassMethod getObjectUidById(objectName As %String, id As %Integer) As %String
{
    set ret = ""
    if (objectName '= "") && (id '= "") {
        set tableName = ..getObjectTableName(objectName)
        set sql="select uid from "_tableName_" where ID = ?"
        set rs = ##class(%SQL.Statement).%ExecDirect(,sql, id)
        if rs.%SQLCODE < 0 {
            $$$ThrowStatus($$$ERROR($$$SQLCode,SQLCODE,$g(%msg)))
        }
        if ( rs.%SQLCODE = 0 ) {
            if ( rs.%Next() '= 0 ) {
                set ret = rs.uid
            }
        }
    }
    return ret
}

}
