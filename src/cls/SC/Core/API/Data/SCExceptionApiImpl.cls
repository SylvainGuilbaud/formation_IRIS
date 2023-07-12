/*
Copyright (c) 2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.SCExceptionApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "SCException";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

ClassMethod GetExceptions() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetExceptionById(exceptionId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, exceptionId)
}

ClassMethod CreateException(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteException(exceptionId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, exceptionId)
}

ClassMethod UpdateException(exceptionId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, exceptionId, body)
}

}
