/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.InventoryThresholdApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "InventoryThreshold";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

ClassMethod GetInventoryThresholds() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetInventoryThresholdById(inventoryThresholdId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, inventoryThresholdId)
}

ClassMethod CreateInventoryThreshold(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteInventoryThreshold(inventoryThresholdId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, inventoryThresholdId)
}

ClassMethod UpdateInventoryThreshold(inventoryThresholdId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, inventoryThresholdId, body)
}

}
