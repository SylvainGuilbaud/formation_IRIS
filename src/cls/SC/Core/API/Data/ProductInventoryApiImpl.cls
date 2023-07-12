/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.ProductInventoryApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "ProductInventory";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

/// Sales shipment alias used in SQL statements
Parameter PIALIAS = "pi";

ClassMethod GetProductInventories() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetProductInventoryById(inventoryId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, inventoryId)
}

ClassMethod CreateProductInventory(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteProductInventory(inventoryId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, inventoryId)
}

ClassMethod UpdateProductInventory(inventoryId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, inventoryId, body)
}

ClassMethod GetRecordsWithIdSelect(idSelect As %String) As %DynamicAbstractObject
{
    return ..ObjectGetAllWithIdSelect(..#OBJECTNAME, ..#DEFAULTSORTING, ..#PIALIAS, idSelect)
}

}
