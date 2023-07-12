/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Tasks.UpdateKPIIssue Extends %SYS.Task.Definition
{

Parameter TaskName = "UpdateKPIIssue";

Method OnTask() As %Status
{
    Set sql = "select name from SC_Core_Analytics_KPI.KpiDefinition"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
    Set count = 0
    Set retValue = $$$OK
    if rs.%SQLCODE < 0 {
        return $$$ERROR($$$SQLCode,SQLCODE,$g(%msg))
    }
    while rs.%Next() {
        set count = count+1
        set kpiName = rs.%Get("name")
        set kpiDef = ##class(SC.Core.API.KPI.KpiApiImpl).GetKpiDefinitionByName(kpiName)
        if kpiDef = "" { 
            return {"Status": "Failed", "Message": ("KPI not found ("_kpiName_")") }
        }
        if kpiDef.issueKpi = 0 {
            return {"Status": "Failed", "Message": ("KPI not configured for issue ("_kpiName_")") }        
        }
        set sc = ##class(SC.Core.Util.KpiIssueUtil).updateIssuesForKpi(kpiDef, .totalCount, .newCount, .existCount, .closedCount)
        if $$$ISERR(sc)
            set retValue = sc
    }
   return retValue
}

}
