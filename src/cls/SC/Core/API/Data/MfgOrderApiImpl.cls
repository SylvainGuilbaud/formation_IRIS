/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.MfgOrderApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "MfgOrder";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

ClassMethod GetMfgOrders() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetMfgOrderById(orderId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, orderId)
}

ClassMethod CreateMfgOrder(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteMfgOrder(orderId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, orderId)
}

ClassMethod UpdateMfgOrder(orderId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, orderId, body)
}

}
