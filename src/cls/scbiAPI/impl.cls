/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// API for InterSystems IRIS supply chain analytics<br/>
/// Business logic class defined by OpenAPI in scbiAPI.spec<br/>
/// Updated Mar 19, 2024 12:24:15
Class scbiAPI.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// If ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 1;

/// Returns KPI definition of the specified KPI<br/>
/// The method arguments hold values for:<br/>
///     kpiName, KPI name<br/>
ClassMethod GetKpiDefinition(kpiName As %String) As %DynamicObject
{
    return ##class(SC.Core.API.KPI.KpiApiImpl).GetKpiDefinition(kpiName)
}

/// Update a KPI definition<br/>
/// The method arguments hold values for:<br/>
///     kpiName, Name of the KPI<br/>
///     body, New KPI definition<br/>
ClassMethod UpdateKpiDefinition(kpiName As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.KPI.KpiApiImpl).UpdateKpiDefinition(kpiName, body)
}

/// Delete a KPI definition<br/>
/// The method arguments hold values for:<br/>
///     kpiName, KPI name<br/>
ClassMethod DeleteKpiDefinition(kpiName As %String) As %DynamicObject
{
    return ##class(SC.Core.API.KPI.KpiApiImpl).DeleteKpiDefinition(kpiName)
}

/// Get all KPI definitions defined in the system
ClassMethod GetKpiDefinitions() As %DynamicObject
{
    return ##class(SC.Core.API.KPI.KpiApiImpl).GetKpiDefinitions()
}

/// Create a new KPI definition<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateKpiDefinition(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.KPI.KpiApiImpl).CreateKpiDefinition(body)
}

/// Returns KPI value of the specified KPI<br/>
/// The method arguments hold values for:<br/>
///     kpiName, KPI name<br/>
ClassMethod GetKpiValue(kpiName As %String) As %DynamicObject
{
    return ##class(SC.Core.API.KPI.KpiApiImpl).GetKpiValue(kpiName)
}

/// Returns source listing of a KPI<br/>
/// The method arguments hold values for:<br/>
///     kpiName, KPI name<br/>
ClassMethod GetKpiListing(kpiName As %String) As %DynamicObject
{
    return ##class(SC.Core.API.KPI.KpiApiImpl).GetKpiListing(kpiName)
}

/// Update issues for a given KPI<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod UpdateKpiIssues(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.KPI.IssueApiImpl).UpdateKpiIssues(body)
}

/// close an issue<br/>
/// The method arguments hold values for:<br/>
///     issueId, Issue ID<br/>
///     body<br/>
ClassMethod CloseIssue(issueId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.KPI.IssueApiImpl).CloseIssue(issueId, body)
}

/// Update the workflow with user input, and close the issue accordingly<br/>
/// The method arguments hold values for:<br/>
///     issueId, KPI name<br/>
///     body<br/>
ClassMethod CompleteWorkflow(issueId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.KPI.IssueApiImpl).CompleteWorkflow(issueId, body)
}

/// Run analysis for a given issue<br/>
/// The method arguments hold values for:<br/>
///     issueId, Issue uid<br/>
///     body<br/>
ClassMethod RunIssueAnalysis(issueId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.KPI.IssueApiImpl).RunIssueAnalysis(issueId, body)
}

/// Get inventory predictions for a given product at a given location
/// WARNING: This method's signature has changed.
ClassMethod GetPredictedInventory() As %DynamicObject
{
    return ##class(SC.Core.API.KPI.PredictedInventoryApiImpl).GetPredictedInventory()
}

}
