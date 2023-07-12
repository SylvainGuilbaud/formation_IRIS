/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.SlaApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "SLA";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

ClassMethod GetSLAs() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetSLAById(slaId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, slaId)
}

ClassMethod CreateSLA(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteSLA(slaId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, slaId)
}

ClassMethod UpdateSLA(slaId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, slaId, body)
}

}
