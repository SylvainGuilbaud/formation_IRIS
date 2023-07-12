/*
Copyright (c) 2022-2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.Internal.Issue Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID of customer
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// Description of the issue
Property description As %String(MAXLEN = 128);

/// Category of the issue, up to each clients to define
Property issueCategory As %String(MAXLEN = 64);

/// Impacted region of the issue
Property issueRegion As %String(MAXLEN = 32);

/// What trigger the issue:
/// KPI: issue triggered by a KPI
/// externalEvent: triggered by external events, such as weather etc.
/// BPL: trigger by some business process
/// API: trigger outside IRIS, sent in through API
Property triggerType As %String(VALUELIST = ",KPI,externalEvent,BPL,API");

Parameter TRIGGERKPI = "KPI";

Parameter TRIGGEREXTEVENT = "externalEvent";

Parameter TRIGGERBPL = "BPL";

Parameter TRIGGERAPI = "API";

/// Unique ID of the triiggering event, such as KPI name, event ID, etc.
Property triggerObjectId As %String(MAXLEN = 64);

/// Name of the object impacted, such as SalesOrder, SupplyShipment, etc.
Property impactedObjectType As %String(MAXLEN = 64);

/// Uique ID of the impacted object
Property impactedObjectId As %String(MAXLEN = 64);

/// More data related to the definition or background of the issue
Property issueData As %String(MAXLEN = 512);

/// Name of the analytis process
Property processName As %String(MAXLEN = 64);

/// Source of the issue
Property source As %String(MAXLEN = 64);

/// severity level, the higher value, the more sever
Property severity As %Integer;

/// urgency level, the higher value, the more urgent
Property urgency As %Integer;

/// status of the issue:
/// open: issue still open
/// workflow: task assigned in workflow, waiting for response from user
/// closed: issue closed. See resolution type for more details on why it is closed.
Property status As %String(VALUELIST = ",open,workflow,closed");

Parameter DSTIME = "AUTO";

Parameter STATUSOPEN = "open";

Parameter STATUSWORKFLOW = "workflow";

Parameter STATUSCLOSED = "closed";

/// time the issue closed
Property closeTime As %DateTime;

/// UID of the user who acted on the issue
Property resolutionUser As %String(MAXLEN = 64);

/// How the issue was resolved, 
/// manual: user close the issue manually, may involve some manual action, or no action required
/// bpl: issue resolved through a BPL process
/// nolongervalid: for KPI related, this means the record no longer matches the KPI condition. Other examples
///                include external event triggered issue is closed due to the event is over or event changed 
///                which no longer impact the records.
Property resolutionType As %String(VALUELIST = ",manual,bpl,noLongerValid");

Parameter RESOLUTIONMANUAL = "manual";

Parameter RESOLUTIONBPL = "bpl";

Parameter RESOLUTIONNOLONGERVALID = "noLongerValid";

/// Details of the resolution
Property resolutionNote As %String(MAXLEN = 512);

/// Create a new analysis for the issue. If the current issue has not been persisted, returns ""
Method createNewAnalysis() As SC.Core.Data.Internal.IssueAnalysis
{
    set ret = ""
    if ..%Id() '= "" {
        set iid = ..%Id()
        set a = ##class(SC.Core.Data.Internal.IssueAnalysis).%New()
        set a.issueId = iid
        set a.runSequence = ..getLastAnalysisSequence(iid) + 1
        do a.%Save() // Save the analysis, preserve the runSequence
        set ret = a
    }
    return ret
}

/// Retrieve the latest analysis for the issue
Method getLatestAnalysis() As SC.Core.Data.Internal.IssueAnalysis
{
    set ret = ""
    if ..%Id() '= "" {
        set iid = ..%Id()
        set lastRun = ..getLastAnalysisSequence(iid)
        //w !,"lasrRun = ", lastRun
        if lastRun > 0 {
            set ret = ..getAnalysisByRunSequence(lastRun)
        }
    }
    return ret
}

Method getScenarioFromLastAnalysis(optionNumber As %String) As SC.Core.Data.Internal.ActionScenario
{
    set ret = ""
    if optionNumber '= "" {
        set ana = ..getLatestAnalysis()
        if ana '= "" {
            set options = ana.scenarios
            if options '= "" {
                for i=1:1:options.Count() {
                    set opt = options.GetAt(i)
                    if opt.optionNumber = optionNumber {
                        set ret = opt
                        quit
                    }
                }
            }
        }
    }
    return ret
}

/// add the latest analysis to an issue
Method addLatestAnalysis(ana As SC.Core.Data.Internal.IssueAnalysis) As %Status
{
    Set sc = $$$OK
    set iid = ..%Id()
    if ( ( iid '= "") && (ana '= ""))  {
        // First update the analysis with issue specific information
        set ana.issueId = iid
        set ana.runSequence = ..getLastAnalysisSequence(iid) + 1
        do ana.%Save() // Save the updates
        // Next copy related info from analysis to issue:
        do ..syncLatestAnalysisToIssue()  
    }
    else {
        // TODO: return an error status
    }
    Return sc
}

/// Sync latest analysis results to issue
Method syncLatestAnalysisToIssue() As %Status
{
    Set sc = $$$OK
    set ana = ..getLatestAnalysis()
    if ana '= "" {
        set ..severity = ana.severity
        set ..urgency = ana.urgency
        if ana.status = ana.#STATUSCOMPLETED {
            // For completed analysis, send the resolution results back to the issue, if exists
            if (ana.resolution '= "") && (ana.resolution '= ana.#RESOLUTIONNONE)  {
                set ..status = ..#STATUSCLOSED
                set ..resolutionType =..#RESOLUTIONBPL
                set ..closeTime = ana.lastUpdatedTime
            }
        }
        elseif ana.status = ana.#STATUSWORKFLOW {
            set ..status = ..#STATUSWORKFLOW
        } 
        else {
            // No need to do anything for other analysis status values
            // TODO: add error handling if analysis did not finish successfully
        } 
        do ..%Save()        
    }
    Return sc
}

/// Retrieve the analysis of a specific run by sequence number
Method getAnalysisByRunSequence(seqNum As %Integer) As SC.Core.Data.Internal.IssueAnalysis
{
    Set ret = 0
    if ..%Id() '= "" {
        set iid = ..%Id()
        set sql ="SELECT ID FROM SC_Core_Data_Internal.IssueAnalysis WHERE issueId = ? AND runSequence = ?"
        set statement = ##class(%SQL.Statement).%New()
        set sc = statement.%Prepare(sql)
        if $$$ISOK(sc) {
            set rs = statement.%Execute(iid, seqNum)
            if (rs.%SQLCODE = 0 && rs.%Next()) {
                Set aid = rs.%Get("ID")
                set ret = ##class(SC.Core.Data.Internal.IssueAnalysis).%OpenId(aid)
            } else {
                set sc = $$$ERROR($$$SQLCode,SQLCODE,$g(%msg))
            }
        }
        $$$ThrowOnError(sc)
    }
    Return ret
}

/// Get the latest analysis run sequence number. Retruns 0 if no analysis was run.
ClassMethod getLastAnalysisSequence(iid As %Integer) As %Integer
{
    Set ret = 0
    set sql ="SELECT max(runSequence) latestSeq FROM SC_Core_Data_Internal.IssueAnalysis WHERE issueId = ? "
    set statement = ##class(%SQL.Statement).%New()
    set sc = statement.%Prepare(sql)
    if $$$ISOK(sc) {
        set rs = statement.%Execute(iid)
        if (rs.%SQLCODE = 0 && rs.%Next()) {
             Set ret = rs.%Get("latestSeq")
        } else {
            set sc = $$$ERROR($$$SQLCode,SQLCODE,$g(%msg))
        }
    }
    $$$ThrowOnError(sc)
    Return ret
}

}
