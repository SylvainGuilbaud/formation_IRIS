/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.BP.IssueContext Extends Ens.BP.Context
{

/// Issue ID
Property issueId As %String;

Property issue As SC.Data.Issue;

Property analysis As SC.Core.Data.Internal.IssueAnalysis;

Property newScenario As SC.Core.Data.Internal.ActionScenario;

/// Auto load issue when setting the issue ID
Method issueIdSet(value As %String) As %Status
{
    Set sc = $$$OK
    if value '= "" {
		set ..issue = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Issue", value)
        if ..issue '= "" {
            set ..analysis = ..issue.createNewAnalysis()
        }
	}
	quit sc
}

/// Auto load issue when setting the issue ID
/// Refresh the context scenario to a new instance.
Method createNewScenario() As %Status
{
    Set sc = $$$OK
    set ..newScenario = ##class(SC.Core.Data.Internal.ActionScenario).%New()
    return sc
}

/// Add the current context scenario to the analysis. Make sure both analysis and scenario object 
/// are instantiated.
Method addScenarioToAnalysis() As %Status
{
    Set sc = $$$OK
    if (..analysis '= "") && (..newScenario '= "") {
        set sc = ..analysis.addScenario(..newScenario)
    }
    else {
        set sc = $$$ERROR("Analysis or scenario not set yet")
    }
    return sc
}

/// Add the context analysis object to the issue
Method saveAnalysisToIssue() As %Status
{
    Set sc = $$$OK
    if (..analysis '= "") && (..issue '= "") {
        if ..analysis.status = "" {
            // Assume default analysis status is COMPLETED, so process designer does not have to worry about doing
            // this explicitly.
            set ..analysis.status = ..analysis.#STATUSCOMPLETED
        }
        if ..analysis.resolution = "" {
            // If resolution is not specified by the process, assume value of "none"
            set ..analysis.resolution = ..analysis.#RESOLUTIONNONE
        }
        set sc = ..issue.addLatestAnalysis(..analysis)
    }
    else {
        set sc = $$$ERROR("Analysis or issue not set yet")
    }
    return sc
}

/// Add the context analysis object with workflow to the issue
Method saveWorkflowAnalysisToIssue() As %Status
{
    Set sc = $$$OK
    if (..analysis '= "") && (..issue '= "") {
        set ..analysis.status = ..analysis.#STATUSWORKFLOW
        set ..analysis.resolution = "none"
        set sc = ..issue.addLatestAnalysis(..analysis)
    }
    else {
        set sc = $$$ERROR("Analysis or issue not set yet")
    }
    return sc
}

/// Load and return the impact object if specified in the issue
Method getImpactedObject() As %ObjectHandle
{
    set ret = ""
    if ..issue '= "" {
        set objectType = ..issue.impactedObjectType
        set uid = ..issue.impactedObjectId
        if (objectType '= "") && (uid '= "") {
            set ret = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(objectType, uid)
        } 
    } 
    return ret
}

Storage Default
{
<Data name="IssueContextDefaultData">
<Subscript>"IssueContext"</Subscript>
<Value name="1">
<Value>issueId</Value>
</Value>
<Value name="2">
<Value>issue</Value>
</Value>
<Value name="3">
<Value>analysis</Value>
</Value>
<Value name="4">
<Value>newScenario</Value>
</Value>
</Data>
<DefaultData>IssueContextDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
