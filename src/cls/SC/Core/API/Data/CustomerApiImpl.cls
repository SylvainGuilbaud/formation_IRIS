/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.CustomerApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "Customer";

/// Default sorting attribute
Parameter DEFAULTSORTING = "name";

ClassMethod GetCustomers() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetCustomerById(customerId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, customerId)
}

ClassMethod CreateCustomer(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteCustomer(customerId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, customerId)
}

ClassMethod UpdateCustomer(customerId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, customerId, body)
}

}
