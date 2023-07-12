/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.ProductSupplierApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "ProductSupplier";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

ClassMethod GetProductSuppliers() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetProductSupplierById(prodSuplId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, prodSuplId)
}

ClassMethod CreateProductSupplier(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteProductSupplier(prodSuplId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, prodSuplId)
}

ClassMethod UpdateProductSupplier(prodSuplId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, prodSuplId, body)
}

}
