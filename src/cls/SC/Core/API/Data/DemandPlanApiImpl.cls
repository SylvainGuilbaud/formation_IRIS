/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.DemandPlanApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "DemandPlan";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

ClassMethod GetDemandPlans() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetDemandPlanById(planId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, planId)
}

ClassMethod CreateDemandPlan(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteDemandPlan(planId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, planId)
}

ClassMethod UpdateDemandPlan(planId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, planId, body)
}

}
