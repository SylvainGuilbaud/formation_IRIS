/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.ProductApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "Product";

/// Default sorting attribute
Parameter DEFAULTSORTING = "name";

ClassMethod GetProducts() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetProductById(productId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, productId)
}

ClassMethod CreateProduct(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteProduct(productId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, productId)
}

ClassMethod UpdateProduct(productId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, productId, body)
}

}
