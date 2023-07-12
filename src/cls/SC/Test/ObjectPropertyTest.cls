/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Description
Class SC.Test.ObjectPropertyTest
{

ClassMethod TestClassDefinitions()
{
    set sql="select id, name, description, abstract, super, timecreated, timechanged " _ 
            " from %Dictionary.ClassDefinition where name like ?"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql, "SC.Data.%")
    if ( rs.%SQLCODE = 0 ) {
        while ( rs.%Next() '= 0 ) {
            write !, "ID = ", rs.ID
            write !, "Class name = ", rs.name
            write !, "Description = ", rs.description
            write !, "Is abstract = ", rs.abstract
            write !, "super class = ", rs.super, !
        }
    }
    else {
        write !, rs.%SQLCODE, ": ", rs.%Message
    }
}

/// Test class definition
ClassMethod TestClassDefinition(classname As %String)
{
    set sql="select id, name, abstract, super, timecreated, timechanged " _ 
            " from %Dictionary.ClassDefinition where id = ?"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql, classname)
    if ( rs.%SQLCODE = 0 ) {
        if ( rs.%Next() '= 0 ) {
            write !, "ID = ", rs.ID
            write !, "Class name = ", rs.name
            write !, "Is abstract = ", rs.abstract
            write !, "super class = ", rs.super
        }
        else {
            write !, "Class ", classname, " not defined. "
        }
    }
    else {
        write !, rs.%SQLCODE, ": ", rs.%Message
    }
}

/// Test class properties
ClassMethod TestClassProperties(classname As %String)
{
    set sql="select id1, name, required, type, description, origin, sqlFieldName " _ 
            "from %Dictionary.CompiledProperty where storable = 1 and parent=?"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql, classname)
    if ( rs.%SQLCODE = 0 ) {
        while ( rs.%Next() '= 0 ) {
            write !, "ID = ", rs.id1
            write !, "Property name = ", rs.name
            write !, "Description = ", rs.description
            write !, "Is required = ", rs.required
            write !, "Data type = ", rs.Type
            write !, "Origin = ", rs.origin
            if $find(rs.origin, "SC.Core.") = 9 {
                write !, "Is custom = false", !
            }
            else {
                write !, "Is custom = true", !
            }
        }
    }
    else {
        write !, rs.%SQLCODE, ": ", rs.%Message
    }
}

ClassMethod TestAddClassProperty(classname As %String, propname As %String)
{
    set c = ##class(%Dictionary.ClassDefinition).%OpenId(classname,,.st)
    if $$$ISOK(st) {
        write !,"Class name: ",c.Name
        set p = ##class(%Dictionary.PropertyDefinition).%New()
        set p.Name = propname
        set p.Description = "Property added through test method"
        set p.Required = 1
        set p.parent = c
        set p.Type = "%String"
        set st = c.%Save()
        if $$$ISOK(st) {
            do $system.OBJ.Compile(classname, "ck")
            write !,"Successfully added property [", propname, "] to class [", classname, "]."
        }
        else {
            do $system.Status.DisplayError(st)
        }
    }
    else {
        write !,"Class [",classname, "] is not defined."
    }
}

}
