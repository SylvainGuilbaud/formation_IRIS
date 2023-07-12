/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.MilestonApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "Milestone";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

ClassMethod GetMilestones() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetMilestoneById(milestoneId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, milestoneId)
}

ClassMethod CreateMilestone(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteMilestone(milestoneId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, milestoneId)
}

ClassMethod UpdateMilestone(milestoneId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, milestoneId, body)
}

}
