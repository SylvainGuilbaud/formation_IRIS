/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.LocationApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "Location";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

ClassMethod GetLocations() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetLocationById(locationId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, locationId)
}

ClassMethod CreateLocation(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteLocation(locationId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, locationId)
}

ClassMethod UpdateLocation(locationId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, locationId, body)
}

}
