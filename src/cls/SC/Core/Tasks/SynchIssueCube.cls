/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Tasks.SynchIssueCube Extends %SYS.Task.Definition
{

Parameter TaskName = "SynchIssueCube";

Method OnTask() As %Status
{
    set st = ##class(%DeepSee.Utils).%SynchronizeCube("IssueCube",1,,,,,.tStats)
    return st
}

}
