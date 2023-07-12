/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.SupplierApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "Supplier";

/// Default sorting attribute
Parameter DEFAULTSORTING = "name";

ClassMethod GetSuppliers() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetSupplierById(supplierId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, supplierId)
}

ClassMethod CreateSupplier(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteSupplier(supplierId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, supplierId)
}

ClassMethod UpdateSupplier(supplierId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, supplierId, body)
}

}
