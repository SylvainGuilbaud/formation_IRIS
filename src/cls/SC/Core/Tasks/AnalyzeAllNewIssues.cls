/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Tasks.AnalyzeAllNewIssues Extends %SYS.Task.Definition
{

Parameter TaskName = "AnalyzeAllNewIssues";

Method OnTask() As %Status
{
    set myquery = "select ID,processName from SC_Data.Issue where ID not in (select issueId from SC_Core_Data_Internal.IssueAnalysis) and processName is not null and status <> 'closed'"
    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(myquery)
    if qStatus'=1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) Quit:qStatus}
    set rset = tStatement.%Execute()
    if rset.%SQLCODE < 0 return $$$ERROR($$$SQLCode,SQLCODE,$g(%msg))
    set retValue = $$$OK
    while rset.%Next()
    {
        set st = ##class(SC.Core.Util.IssueUtil).runIssueAnalysis(rset.ID, rset.processName)
        if $$$ISERR(st) {
            do $SYSTEM.Status.DisplayError(st)
            set retValue = st
        }
    }
    return retValue
}

}
