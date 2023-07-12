/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Test.IssueTest
{

ClassMethod testIssueCreate()
{
    set oid = "SO-10001"
    set iss = ##class(SC.Core.Data.Internal.Issue).%New()
    set iss.description = "Test issue"
    set iss.issueCategory = "OrderFullfilment"
    set iss.triggerType = "KPI"
    set iss.triggerObjectId = "SalesOrderLateDeliveryVsRequested"
    set iss.impactedObjectType = "SalesOrder"
    // set iss.severity = 5   // will get the value from analysis
    set iss.impactedObjectId = oid
    set iss.status = "open"
    set iss.resolutionType = "manual"
    set iss.processName = "SC-Process"
    set iss.issueData = "additional data about the issue" 
    do iss.%Save()
}

ClassMethod testIssueCreateWithAnalysis()
{
    set oid = "SO-10003"
    set iss = ##class(SC.Core.Data.Internal.Issue).%New()
    set iss.description = "Test issue"
    set iss.issueCategory = "OrderFullfilment"
    set iss.triggerType = "KPI"
    set iss.triggerObjectId = "SalesOrderLateDeliveryVsRequested"
    set iss.impactedObjectType = "SalesOrder"
    // set iss.severity = 5   // will get the value from analysis
    set iss.impactedObjectId = oid
    set iss.status = "open"
    set iss.resolutionType = "manual"
    set iss.processName = "SC-Process"
    set iss.issueData = "additional data about the issue" 
    do iss.%Save()
    w !,"Successfully created an issue with ID ",iss.%Id()
    set ana = iss.createNewAnalysis()
    //set ana = ##class(SC.Core.Data.Internal.IssueAnalysis).%New()
    set ana.processName = "testProcess"
    set ana.severity = 5
    set ana.urgency = 3
    set ana.supportingData = "Some supporting data"
    set ana.rootCauseAnalysis = "This is caused by COVID shutdown"
    set ana.impactAnalysis = "The impact is huge on the business"
    set opt = ##class(SC.Core.Data.Internal.ActionScenario).%New()
    set opt.optionName = "First Option"
    set opt.optionNumber = "A"
    set opt.description = "Some details of option A"
    set opt.supportingData = "All supporting data for A here ..."
    set opt.costImpact = 100
    set opt.timeImpact = 24
    set opt.feasibility = 1
    set opt.recommended = 1
    do opt.%Save()
    w !,"Saved scenario with ID ",opt.%Id()
    set sc = ana.addScenario(opt)
    set opt = ##class(SC.Core.Data.Internal.ActionScenario).%New()
    set opt.optionName = "Second Option"
    set opt.optionNumber = "B"
    set opt.description = "Some details of option B"
    set opt.costImpact = 200
    set opt.timeImpact = 12
    set opt.feasibility = 1
    set opt.recommended = 0
    set opt.supportingData = "All supporting data for B here ..."
    do opt.%Save()
    w !,"Saved scenario with ID ",opt.%Id()
    set sc = ana.addScenario(opt)
    set ana.recommendation = "A"
    set ana.status = ana.#STATUSCOMPLETED
    set ana.resolution = ana.#RESOLUTIONAUTOMATIC
    set ana.actionTaken = "Option A"
    do iss.addLatestAnalysis(ana)
    set ana = iss.getLatestAnalysis()
    w !,"Successfully created an issue analysis with ID ",ana.%Id()
}

ClassMethod addIssueAnalysisWithWorkflow(issueId As %Integer)
{
    set issue = ##class(SC.Core.Data.Internal.Issue).%OpenId(issueId)
    if issue '= "" {
        set ana = issue.createNewAnalysis()
        set ana.severity = 3
        set ana.urgency = 1
        set ana.supportingData = "Some supporting data"
        set ana.rootCauseAnalysis = "This is caused by COVID shutdown"
        set ana.impactAnalysis = "Significant impact on a customer"
        set opt = ##class(SC.Core.Data.Internal.ActionScenario).%New()
        set opt.optionName = "Option A"
        set opt.optionNumber = "A"
        set opt.description = "Use expedited shipment."
        set opt.supportingData = "Impact: $1000 extra shipping fee. Shipment will still be 36 hours late."
        set opt.costImpact = 1000
        set opt.timeImpact = 36
        set opt.feasibility = 1
        set opt.recommended = 0
        do opt.%Save()
        set sc = ana.addScenario(opt)
        set opt = ##class(SC.Core.Data.Internal.ActionScenario).%New()
        set opt.optionName = "Option B"
        set opt.optionNumber = "B"
        set opt.description = "Ship from different warehourses. Two shipments from two warehouses."
        set opt.supportingData = "Impact: $500 extra shipping cost. Shipment likely arrive on time."
        set opt.costImpact = 500
        set opt.timeImpact = 0
        set opt.feasibility = 1
        set opt.recommended = 1
        do opt.%Save()
        set sc = ana.addScenario(opt)
        set opt = ##class(SC.Core.Data.Internal.ActionScenario).%New()
        set opt.optionName = "Option C"
        set opt.optionNumber = "C"
        set opt.description = "Provide a free upgrade to a higher end model which is in stock."
        set opt.supportingData = "Impact: Negative margin of $12000 on the order. Order delivers on time."
        set opt.costImpact = 12000
        set opt.timeImpact = 0
        set opt.feasibility = 1
        set opt.recommended = 0
        do opt.%Save()
        set sc = ana.addScenario(opt)
        set ana.recommendation = "B"
        set ana.status = ana.#STATUSWORKFLOW
        set ana.resolution = ana.#RESOLUTIONNONE
        set sc = ana.%Save()
        if $$$ISOK(sc) {
            do issue.addLatestAnalysis(ana)
            w !,"Successfully created a new analysis with id ", ana.%Id(), " for issue ",issueId
        }
        else {
            do $SYSTEM.Status.DisplayError(sc)
            w !, "failed to save the analysis"
        }

    }
}

ClassMethod addIssueAnalysisImpactOnly(issueId As %Integer)
{
    set issue = ##class(SC.Core.Data.Internal.Issue).%OpenId(issueId)
    if issue '= "" {
        set ana = issue.createNewAnalysis()
        set ana.severity = 3
        set ana.urgency = 1
        set ana.supportingData = "Some supporting data"
        set ana.rootCauseAnalysis = "Higher than ususal  demands in the region"
        set ana.impactAnalysis = "Major customer satisfaction issue"
        set ana.status = ana.#STATUSCOMPLETED
        set ana.resolution = ana.#RESOLUTIONNONE
        set sc = ana.%Save()
        if $$$ISOK(sc) {
            do issue.addLatestAnalysis(ana)
            w !,"Successfully created a new analysis with id ", ana.%Id(), " for issue ",issueId
        }
        else {
            do $SYSTEM.Status.DisplayError(sc)
            w !, "failed to save the analysis"
        }
    }
}

ClassMethod addIssueAnalysisWithResolution(issueId As %Integer)
{
    set issue = ##class(SC.Core.Data.Internal.Issue).%OpenId(issueId)
    if issue '= "" {
        set ana = issue.createNewAnalysis()
        set ana.severity = 1
        set ana.urgency = 2
        set ana.supportingData = "Similar problems were closed with the same apporach"
        set ana.rootCauseAnalysis = "Normal fluctuation in demand"
        set ana.impactAnalysis = "Minimum impact on business"
        set ana.status = ana.#STATUSCOMPLETED
        set ana.resolution = ana.#RESOLUTIONAUTOMATIC
        set ana.actionTaken = "Related parties notified by the system"
        set sc = ana.%Save()
        if $$$ISOK(sc) {
            do issue.addLatestAnalysis(ana)
            w !,"Successfully created a new analysis with id ", ana.%Id(), " for issue ",issueId
        }
        else {
            do $SYSTEM.Status.DisplayError(sc)
            w !, "failed to save the analysis"
        }
    }
}

ClassMethod addIssueAnalysisCloseWithoutAction(issueId As %Integer)
{
    set issue = ##class(SC.Core.Data.Internal.Issue).%OpenId(issueId)
    if issue '= "" {
        set ana = issue.createNewAnalysis()
        set ana.severity = 1
        set ana.urgency = 2
        set ana.supportingData = "Similar problems were closed without action before"
        set ana.rootCauseAnalysis = "Typical business cycle"
        set ana.impactAnalysis = "No impact on business"
        set ana.status = ana.#STATUSCOMPLETED
        set ana.resolution = ana.#RESOLUTIONNOACTION
        set sc = ana.%Save()
        if $$$ISOK(sc) {
            do issue.addLatestAnalysis(ana)
            w !,"Successfully created a new analysis with id ", ana.%Id(), " for issue ",issueId
        }
        else {
            do $SYSTEM.Status.DisplayError(sc)
            w !, "failed to save the analysis"
        }
    }
}

ClassMethod testRetrieveIssue()
{
    set iid = 3
    set i = ##class(SC.Core.Data.Internal.Issue).%OpenId(iid)
    if i '= "" {
        set a = i.getLatestAnalysis()
        zw a
        if a.scenarios '= "" {
            w !,"Number of scenarios in analysis (",a.%Id(),") is: ", a.scenarios.Count(),!
            for i=1:1:a.scenarios.Count() {
                set o = a.scenarios.GetAt(i)
                zw o
            }
        }
    }
    else {
        w !,"No issue with ID (",iid, ") found"
    }
}

ClassMethod testCollection()
{
    set list = ##class(%ListOfDataTypes).%New()
    do list.Insert(100)
    do list.Insert(102)
    do list.Insert(104)
    set p = list.Find(100,0)
    w !,list.GetAt(p)," position is ",p
    set p = list.Find(103,0)
    w !,"100 position is ",p
    if p = "" {w " empty"}
}

}
