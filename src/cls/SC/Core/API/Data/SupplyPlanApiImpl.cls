/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.SupplyPlanApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "SupplyPlan";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

ClassMethod GetSupplyPlans() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetSupplyPlanById(planId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, planId)
}

ClassMethod CreateSupplyPlan(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteSupplyPlan(planId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, planId)
}

ClassMethod UpdateSupplyPlan(planId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, planId, body)
}

}
