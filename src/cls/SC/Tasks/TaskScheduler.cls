/*
Copyright (c) 2022-2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Tasks.TaskScheduler
{

ClassMethod createDefaultTasks() As %Status
{
                
    set st = ..createDailyTask()
    if $$$ISERR(st) Quit st   
    set st = ..createMasterTask()
    return st
}

ClassMethod createMasterTask() As %Status
{
        &sql(SELECT ID INTO :taskId FROM %SYS.Task WHERE NameSpace='SC' AND Name='MasterTask')
        // this is run at installation, just simply write the error to STDOUT for debugging.
        IF SQLCODE<0 {WRITE "SQLCODE error ",SQLCODE," ",%msg  QUIT}
        
        IF SQLCODE=100 {set task = ##class(%SYS.Task).%New()}
        ELSE {set task = ##class(%SYS.Task).%OpenId(taskId)}
        // Don't update if the user has suspended the MasterTask
        if (task.Suspended '= 2) {

                // Run The master task every 1 minutes
                WRITE "Reset MasterTask"
                set task.Name = "MasterTask"
                set task.DailyFrequency = 1
                set task.DailyFrequencyTime = 0
                set task.DailyIncrement = 1
                set task.StartDate = $PIECE($HOROLOG,",",1)
                set task.Description = "Master schedule for SC tasks to run in sequence"
                set task.NameSpace = "SC"
                set task.TaskClass = "SC.Tasks.MasterTask"
                set task.TimePeriod = 0
                return task.%Save()
        }
}

ClassMethod createDailyTask() As %Status
{
        &sql(SELECT ID INTO :taskId FROM %SYS.Task WHERE NameSpace='SC' AND Name='SCDailyTask')
        // this is run at installation, just simply write the error to STDOUT for debugging.
        IF SQLCODE<0 {WRITE "SQLCODE error ",SQLCODE," ",%msg  QUIT}
        
        IF SQLCODE=100 {set task = ##class(%SYS.Task).%New()}
        ELSE {set task = ##class(%SYS.Task).%OpenId(taskId)}
        // Don't update if the user has suspended the SCDailyTask
        if (task.Suspended '= 2) {

                // Run The SC Daily tast once a day at midnight
                WRITE "Reset SCDailyTask"
                set task.Name = "SCDailyTask"
                set task.DailyFrequency = 0
                set task.Description = "Daily rebuild of cubes for SC"
                set task.NameSpace = "SC"
                set task.TaskClass = "SC.Tasks.DailyTask"
                set task.TimePeriod = 0
                set task.TimePeriodEvery = 1
                set task.DailyStartTime = 0 // midnight
                return task.%Save()
        }
}

ClassMethod initialRunDefaultTasks() As %Status
{
        return ##class(SC.Tasks.DailyTask).%New().OnTask()
}

}
