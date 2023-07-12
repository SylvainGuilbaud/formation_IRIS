/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.RouteLegApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "RouteLeg";

/// Default sorting attribute
Parameter DEFAULTSORTING = "uid";

ClassMethod GetRouteLegs() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetRouteLegById(routeLegId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, routeLegId)
}

ClassMethod CreateRouteLeg(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteRouteLeg(routeLegId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, routeLegId)
}

ClassMethod UpdateRouteLeg(routeLegId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, routeLegId, body)
}

}
