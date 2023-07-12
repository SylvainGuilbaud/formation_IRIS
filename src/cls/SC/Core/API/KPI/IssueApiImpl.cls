/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.KPI.IssueApiImpl Extends SC.Core.API.ApiBaseImpl
{

/// Default sorting attribute
Parameter DEFAULTSORTING = "-ID";

ClassMethod UpdateKpiIssues(body As %DynamicObject) As %DynamicAbstractObject
{
    set kpiName = body.kpi
    set kpiDef = ##class(SC.Core.API.KPI.KpiApiImpl).GetKpiDefinitionByName(kpiName)
    if kpiDef = "" { 
        do ..%SetStatusCode("400")
        return {"Status": "Failed", "Message": ("KPI not found ("_kpiName_")") }
    }
    if kpiDef.issueKpi = 0 {
        do ..%SetStatusCode("400")
        return {"Status": "Failed", "Message": ("KPI not configured for issue ("_kpiName_")") }        
    }
    
    set sc = ##class(SC.Core.Util.KpiIssueUtil).updateIssuesForKpi(kpiDef, .totalCount, .newCount, .existCount, .closedCount)
    do ..%SetStatusCode("201")
    return {"kpi":(kpiName), 
            "totalImpactedRecords": (totalCount),
            "newIssue": (newCount), 
            "existIssue": (existCount), 
            "closedIssue": (closedCount)}
}

ClassMethod CloseIssue(issueId As %String, body As %DynamicObject) As %DynamicAbstractObject
{
    try { 
        set issue = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Issue", issueId)
        if issue = "" {
		    do ..%SetStatusCode("404")
		    return {"Status": "Failed", 
                    "Message": ("No issue with id ["_issueId_"] was found.")}            
        }
        if issue.status = issue.#STATUSCLOSED {
		    do ..%SetStatusCode("404")
		    return {"Status": "Failed", 
                    "Message": ("Issue with id ["_issueId_"] already closed. No further update allowed.")}             
        }
        elseif ( (issue.status="") || (issue.status = issue.#STATUSOPEN)) {
            Set comment = body.comment
            do ..closeIssueWithComment(issue, comment)
        }
        elseif issue.status = issue.#STATUSWORKFLOW {
            do ..terminateWorkflow(issue)
            Set comment = body.comment
            do ..closeIssueWithComment(issue, comment)
        }
        do ..%SetStatusCode("200")
		return {"Status": "Success", 
                "Message": ("Successfully closed issue with id ["_issueId_"]. ")}
	} catch (ex) {
		do ..%SetStatusCode("500")
		return {"Status": "Error", 
                "Message": ("Failed to close issue with id ["_issueId_"] due to internal error. ")}
	}
}

/// Terminate a workflow associated with an issue
ClassMethod terminateWorkflow(issue As SC.Data.Issue) As %Status
{
    Set sc = $$$OK
    // TODO: to be completed
    Return sc
}

/// close an issue
ClassMethod closeIssueWithComment(issue As SC.Data.Issue, comment As %String) As %Status
{
    Set sc = $$$OK
    Set issue.status = issue.#STATUSCLOSED
    Set issue.resolutionNote = comment
    Set issue.resolutionType = issue.#RESOLUTIONMANUAL
    Set sc = issue.%Save()
    Return sc
}

ClassMethod CompleteWorkflow(issueId As %String, body As %DynamicObject) As %DynamicAbstractObject
{
    //return {"issueId": (issueId)}
    try { 
        set issue = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Issue", issueId)
        if issue = "" {
		    do ..%SetStatusCode("404")
		    return {"Status": "Failed", 
                    "Message": ("No issue with id ["_issueId_"] was found.")}            
        }
        if issue.status '= issue.#STATUSWORKFLOW {
		    do ..%SetStatusCode("400")
		    return {"Status": "Failed", 
                    "Message": ("Issue with id ["_issueId_"] is not in workflow status.")}             
        }

        set optionNumber = body.selectedOption
        set option = issue.getScenarioFromLastAnalysis(optionNumber)
        if option = "" {
		    do ..%SetStatusCode("404")
		    return {"Status": "Failed", 
                    "Message": ("Issue with id ["_issueId_"] does not have option "_optionNumber_" in its latest analysis.")}             
        }
        set sc = ##class(SC.Core.Util.IssueUtil).completeIssueWorkflow(issue, optionNumber)

        set ana = issue.getLatestAnalysis()
        set ana.status = ana.#STATUSCOMPLETED
        set ana.resolution = ana.#RESOLUTIONWORKFLOW
        set ana.actionTaken = optionNumber
        set anaSc = ana.%Save()

        set issue.status = issue.#STATUSCLOSED
        set issue.resolutionType = issue.#RESOLUTIONBPL
        set issue.resolutionNote = body.comment
        set issueSc = issue.%Save()

        if $$$ISOK(anaSc) && $$$ISOK(issueSc) {
            do ..%SetStatusCode("200")
		    return {"Status": "Success", 
                "Message": ("Successfully closed the issue with id ["_issueId_"] with workflow option "_optionNumber_".")}
        }
        else {
		    do ..%SetStatusCode("500")
		    return {"Status": "Error", 
                "Message": ("Failed to close the issue with id ["_issueId_"] with workflow option "_optionNumber_".")}
        }

	} catch (ex) {
		do ..%SetStatusCode("500")
		return {"Status": "Error", 
                "Message": ("Failed to run analysis for issue with id ["_issueId_"] due to internal error ")}
	}
}

ClassMethod RunIssueAnalysis(issueId As %Integer, body As %DynamicObject) As %DynamicAbstractObject
{
    try { 
        set issue = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Issue", issueId)
        //set issue = ##class(SC.Core.Data.Internal.Issue).%OpenId(issueId)
        if issue = "" {
		    do ..%SetStatusCode("404")
		    return {"Status": "Failed", 
                    "Message": ("No issue with id ["_issueId_"] was found.")}            
        }
        if issue.status = issue.#STATUSCLOSED {
		    do ..%SetStatusCode("404")
		    return {"Status": "Failed", 
                    "Message": ("Issue with id ["_issueId_"] already closed. No further anaysis allowed.")}             
        }

        Set processName = ..getProcessName(issue, body)
        if processName = "" {
		    do ..%SetStatusCode("404")
		    return {"Status": "Failed", 
                    "Message": ("There is no business process defined in issue with id ["_issueId_"], or provided in the API request.")}    
        }

        if issue.status = issue.#STATUSWORKFLOW {
            do ..terminateWorkflow(issue)
        }

        set sc = ##class(SC.Core.Util.IssueUtil).runIssueAnalysis(issueId, processName)

        if $$$ISOK(sc) {
            do ..%SetStatusCode("200")
		    return {"Status": "Success", 
                "Message": ("Successfully ran analysis for issue with id ["_issueId_"], using business process ["_processName_"].")}
        }
        else {
		    do ..%SetStatusCode("500")
		    return {"Status": "Error", 
                "Message": ("Failed to run analysis for issue with id ["_issueId_"], using business process ["_processName_"], underlying error: ["_$System.Status.GetErrorText(sc)_"]")}
        }

	} catch (ex) {
		do ..%SetStatusCode("500")
		return {"Status": "Error", 
                "Message": ("Failed to run analysis for issue with id ["_issueId_"] due to internal error ")}
	}
}

/// Find the process name to use for analysis. If one of provided in the request, use that.
/// Otherwise, use the value from Issue object.
ClassMethod getProcessName(issue As SC.Data.Issue, body As %DynamicObject)
{
    set ret = ""
    if body '= "" {
        set ret = body.processName
    }
    if ret = "" {
        set ret = issue.processName
    }
    return ret
}

}
