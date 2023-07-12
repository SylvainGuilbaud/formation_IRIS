/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This class implements the APIs to get basic information of the supply chain data model,
/// such as listing all the supply chain objects in the model, or show the details of any
/// supply chain objects, or to add a custom attribute to an object.
Class SC.Core.API.Data.ObjectApiImpl Extends %REST.Impl [ ProcedureBlock ]
{

/// Returns the definition of a specified data object
ClassMethod GetObjectDefinitionByName(objectName As %String) As %DynamicObject
{
    set className = "SC.Data."_objectName
    set c = ##class(%Dictionary.ClassDefinition).%OpenId(className,,.st)
    if $$$ISOK(st) {
        set resp = {}
        set resp.objectName = objectName
        set resp.className = className
        set resp.description = $zstrip(c.Description, "*C")
        // TODO: replace line return characters, and replace with single white space
        set attrs = ..GetClassProperties(className)
        set resp.attributes = attrs
        return resp.%ToJSON()
    }
    else {
        do ..%SetStatusCode("404")
        return {
            "status": "Failed",
            "Message": ("Object ["_objectName_"] not found.")
        }
    }
}

/// Get the list of all objects defined in the system
ClassMethod GetObjects() As %DynamicObject
{
    set objArray = []
    set sql="select id, name, description, abstract, super, hidden, timecreated, timechanged " _ 
            " from %Dictionary.ClassDefinition where name like ?"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql, "SC.Data.%")
    if ( rs.%SQLCODE = 0 ) {
        while ( rs.%Next() '= 0 ) {
            if ( rs.hidden < 1 ) {
                set o = {}
                set o.objectName = $piece(rs.name, ".Data.",2)
                set o.className = rs.name
                set o.description =  $zstrip(rs.description, "*C")
                do objArray.%Push(o)
            }
        }
    }
    else {
        if (rs.%SQLCODE = 100) { 
            do ..%SetStatusCode("404")
            
        } else {
            do ..%SetStatusCode("500")
        }
        return {
                "status": "Error",
                "errorCode": ("SQL["_rs.%SQLCODE),
                "errorMessage": (rs.%Message)
        } 
    }
    return objArray.%ToJSON()
}

/// Add a custom attribute to an object.
ClassMethod AddAttribute(objectName As %String, body As %DynamicObject) As %DynamicObject
{
    set className = "SC.Data."_objectName
    set c = ##class(%Dictionary.ClassDefinition).%OpenId(className,,.st)
    if $$$ISOK(st) {
        set propName=body.name
        set dataType=body.dataType
        // TODO: add data validation for the type values
        set required=body.required
        set description = body.description
        set p = ##class(%Dictionary.PropertyDefinition).%New()
        set p.Name = propName
        set p.Description =  $zstrip(description, "*C")
        set p.Required = required
        set p.parent = c
        set p.Type = "%"_dataType
        // TODO: handle non primitive data types (objects) properly
        set p.SequenceNumber = ..GetMaxPropSequenceNumber(className) + 1
        set st = c.%Save()
        if $$$ISOK(st) && (dataType = "String") {
            // Set string attribute max length
            set maxlen = body.maxLength
            if maxlen '= 0 {
                set params = p.Parameters
                do params.SetAt(maxlen, "MAXLEN")
                set st = p.%Save()
            }
        }

        if $$$ISOK(st) {
            do $system.OBJ.Compile(className, "ck")
            write !,"Successfully added property [", propName, "] to class [", className, "]."
            return {
                "status": "Success",
                "message": ("Attribute ["_propName_"] was added to class ["_className_"] successfully")
            }  
        }
        else {
            do ..%SetStatusCode("500")
            return {
                "status": "Error",
                "message": ("Failed to save property ["_propName_"] to class ["_className_"].")
            }
        }
    }
    else {
        do ..%SetStatusCode("404")
        return {
            "status": "Error",
            "message": ("Object ["_objectName_"] does is not defined")
        }
    }
}

/// Helper method to return JSON for all properties of a class
ClassMethod GetClassProperties(className As %String) As %DynamicObject
{
    set resp = []
    set sql="select id1, name, required, collection, type, description, origin, sqlFieldName " _ 
            "from %Dictionary.CompiledProperty where storable = 1 and parent=? order by SequenceNumber"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql, className)
    if ( rs.%SQLCODE = 0 ) {
        while ( rs.%Next() '= 0 ) {
            set p = {}
            set p.name = rs.name
            set p.description = rs.description
            // TODO: remove line return characters, and replace with single white space.
            set type = rs.type
            if ( $find(type, "%Library.") = 10 ) set type =  $piece(rs.Type, ".", 2)
            set p.dataType = type
            if (rs.collection '= "") {
                set p.dataType = "collection of " _ type
            }
            set p.required = rs.required
            set id = rs.id1
            set prop = ##class(%Dictionary.CompiledProperty).%OpenId(id)
            set maxlen = prop.Parameters.GetAt("MAXLEN")
            if maxlen '= "" {
                set p.maxLength = maxlen
            }
            if $find(rs.origin, "SC.Core.") = 9 {
                set p.isCustom = 0
            }
            else {
                set p.isCustom = 1
            }
            do resp.%Push(p)
        }
    }
    else {
        if (rs.%SQLCODE = 100) { 
            do ..%SetStatusCode("404")
        } else {
            do ..%SetStatusCode("500")
        }
        set sc = $$$ERROR($$$SQLCode,SQLCODE,$g(%msg))
        do $SYSTEM.Status.DisplayError(sc)
        return {
                "status": "Error",
                "errorCode": ("SQL["_rs.%SQLCODE),
                "errorMessage": (rs.%Message)
        } 
    }
    return resp
}

/// Find the largest property sequence number of a given class
ClassMethod GetMaxPropSequenceNumber(className As %String) As %Integer
{
    set resp = 0
    set sql="select max(SequenceNumber) as val from %Dictionary.CompiledProperty where parent=?"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql, className)
    if ( rs.%SQLCODE = 0 ) {
        if ( rs.%Next() '= 0 ) {
            set resp = rs.val
        }
    }
    else {
        if (rs.%SQLCODE = 100) { 
            do ..%SetStatusCode("404")
        } else {
            do ..%SetStatusCode("500")
        }
        set sc = $$$ERROR($$$SQLCode,SQLCODE,$g(%msg))
        do $SYSTEM.Status.DisplayError(sc)
        $$$ThrowStatus(sc)
    }
    return resp
}

}
