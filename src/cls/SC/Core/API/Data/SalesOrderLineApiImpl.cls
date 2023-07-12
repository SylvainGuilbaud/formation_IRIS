/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.SalesOrderLineApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "SalesOrderLine";

/// Default sorting attribute
Parameter DEFAULTSORTING = "-ID,lineNumber";

ClassMethod GetSalesOrderLines() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

/// This method is used for both regular data model API and KPI API calls.
/// Do not change the name of this method!
ClassMethod GetRecordsWithIdSelect(idSelect As %String) As %DynamicAbstractObject
{
    set tableAlias = ""
    return ..ObjectGetAllWithIdSelect(..#OBJECTNAME, ..#DEFAULTSORTING, tableAlias, idSelect)
}

ClassMethod GetSalesOrderLineById(lineId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, lineId)
}

ClassMethod CreateSalesOrderLine(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteSalesOrderLine(lineId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, lineId)
}

ClassMethod UpdateSalesOrderLine(lineId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, lineId, body)
}

}
