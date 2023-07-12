/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.SupplyShipmentLineApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "SupplyShipmentLine";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

ClassMethod GetSupplyShipmentLines() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetSupplyShipmentLineById(lineId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, lineId)
}

ClassMethod CreateSupplyShipmentLine(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteSupplyShipmentLine(lineId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, lineId)
}

ClassMethod UpdateSupplyShipmentLine(lineId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, lineId, body)
}

}
