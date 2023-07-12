/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.BomApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "BOM";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

ClassMethod GetBOMs() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetBOMById(bomId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, bomId)
}

ClassMethod CreateBOM(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteBOM(bomId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, bomId)
}

ClassMethod UpdateBOM(bomId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, bomId, body)
}

}
