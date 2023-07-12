/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.CarrierApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "Carrier";

/// Default sorting attribute
Parameter DEFAULTSORTING = "name";

ClassMethod GetCarriers() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetCarrierById(carrierId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, carrierId)
}

ClassMethod CreateCarrier(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteCarrier(carrierId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, carrierId)
}

ClassMethod UpdateCarrier(carrierId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, carrierId, body)
}

}
