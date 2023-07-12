/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.LeadtimeVariantApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "LeadtimeVariant";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

ClassMethod GetLeadtimeVariants() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetLeadtimeVariantById(leadtimeVariantId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, leadtimeVariantId)
}

ClassMethod CreateLeadtimeVariant(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteLeadtimeVariant(leadtimeVariantId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, leadtimeVariantId)
}

ClassMethod UpdateLeadtimeVariant(leadtimeVariantId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, leadtimeVariantId, body)
}

}
