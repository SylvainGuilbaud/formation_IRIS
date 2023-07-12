/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.ProductionCapacityApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "ProductionCapacity";

/// Default sorting attribute
Parameter DEFAULTSORTING = "facilityId";

/// alias name used in SQL statements
Parameter SQLALIAS = "pc";

ClassMethod GetProductionCapacities() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetProductionCapacityById(productionCapacityId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, productionCapacityId)
}

ClassMethod CreateProductionCapacity(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteProductionCapacity(productionCapacityId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, productionCapacityId)
}

ClassMethod UpdateProductionCapacity(productionCapacityId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, productionCapacityId, body)
}

ClassMethod GetRecordsWithIdSelect(idSelect As %String) As %DynamicAbstractObject
{
    return ..ObjectGetAllWithIdSelect(..#OBJECTNAME, ..#DEFAULTSORTING, ..#SQLALIAS, idSelect)
}

}
