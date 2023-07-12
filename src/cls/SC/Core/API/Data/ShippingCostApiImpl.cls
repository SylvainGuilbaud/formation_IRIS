/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.ShippingCostApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "ShippingCost";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

/// alias name used in SQL statements
Parameter SQLALIAS = "sc";

ClassMethod GetShippingCosts() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetShippingCostById(shippingCostId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, shippingCostId)
}

ClassMethod CreateShippingCost(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteShippingCost(shippingCostId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, shippingCostId)
}

ClassMethod UpdateShippingCost(shippingCostId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, shippingCostId, body)
}

ClassMethod GetRecordsWithIdSelect(idSelect As %String) As %DynamicAbstractObject
{
    return ..ObjectGetAllWithIdSelect(..#OBJECTNAME, ..#DEFAULTSORTING, ..#SQLALIAS, idSelect)
}

}
