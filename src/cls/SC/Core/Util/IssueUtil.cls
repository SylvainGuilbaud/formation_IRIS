/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Util.IssueUtil
{

/// Run issue analysis for a given issue. If an additional processName parameter is provided,
/// run that process instead of the default process defined in the issue object. 
ClassMethod runIssueAnalysis(issueId As %String, processName As %String = "") As %Status
{
    if issueId = "" { return $$$ERROR("No issueId specified") }
    set issue = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Issue", issueId)
    // set issue = ##class(SC.Core.Data.Internal.Issue).%OpenId(issueId)
    if issue = "" { return $$$ERROR("Invalid issueId ["_issueId_"] specified") }

    set targetProcess = processName
    if processName = "" {
        // Use process defined in the issue if none is provided in the method argument
        set targetProcess = issue.processName
    }

    if targetProcess = "" { return $$$ERROR("No process defined in the issue.") }
    
    if issue.status = issue.#STATUSWORKFLOW {
        // The current issue status is waiting for workflow response, Clean up the workflow first:
        // TODO
    }


    // Start to invoke the service to run the analysis
    set st = $$$OK
    SET service = ##class(Ens.Director).CreateBusinessService("SC.Core.BP.Service.SingleIssueBS",.tService)
    set tRequest = ##class(SC.Core.BP.Message.IssueAnalysisRequest).%New()
    set tRequest.issueId = issueId
    set tRequest.targetProcess = targetProcess
    set st = tService.ProcessInput(tRequest)

    return st
}

ClassMethod completeIssueWorkflow(issue As SC.Data.Issue, optionNumber As %String) As %Status
{
    set st = $$$OK
    // TODO: to be completed
    return st
}

}
