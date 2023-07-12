/*
Copyright (c) 2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Tasks.DailyTask Extends %SYS.Task.Definition
{

Parameter TaskName = "SCDailyTask";

Method OnTask() As %Status
{
        set st = ##class(SC.Core.Tasks.BuildCubes).%New().OnTask()
        if $$$ISERR(st) Quit st
        
        return $$$OK
}

}
