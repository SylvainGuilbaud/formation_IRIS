/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.PurchaseOrderLineApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "PurchaseOrderLine";

/// Default sorting attribute
Parameter DEFAULTSORTING = "-ID,lineNumber";

ClassMethod GetPurchaseOrderLines() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetPurchaseOrderLineById(lineId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, lineId)
}

ClassMethod CreatePurchaseOrderLine(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeletePurchaseOrderLine(lineId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, lineId)
}

ClassMethod UpdatePurchaseOrderLine(lineId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, lineId, body)
}

}
