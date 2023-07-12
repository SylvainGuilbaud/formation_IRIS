/*
Copyright (c) 2022-2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Tasks.MasterTask Extends %SYS.Task.Definition
{

Parameter TaskName = "SCMaster";

Method OnTask() As %Status
{
    
    // TODO: This is for mechane learning. Not needed now.
    // set st = ##class(SC.Core.Tasks.PredictSupplyShipmentLateArrival).%New().OnTask()
    // if $$$ISERR(st) Quit st
    set st0 = ##class(SC.Core.Tasks.SynchCube).%New().OnTask()
    set st1 = ##class(SC.Core.Tasks.UpdateKPIIssue).%New().OnTask()
    set st2 = ##class(SC.Core.Tasks.SynchIssueCube).%New().OnTask()
    set st3 = ##class(SC.Core.Tasks.AnalyzeAllNewIssues).%New().OnTask()
    set st4 = ##class(SC.Core.Tasks.PredictInventory).%New().OnTask()
    set st5 = ##class(SC.Core.Tasks.ConsolidatedInventoryTask).%New().OnTask()
    
    
    if $$$ISERR(st0) Quit st0
    if $$$ISERR(st1) Quit st1
    if $$$ISERR(st2) Quit st2
    if $$$ISERR(st3) Quit st3
    if $$$ISERR(st4) Quit st4
    if $$$ISERR(st5) Quit st5

    return $$$OK
}

}
