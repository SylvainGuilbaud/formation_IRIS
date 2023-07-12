/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Test.KpiTest
{

ClassMethod testKpiCreate()
{
    set json =  {
        "name": "TestKpi",
        "baseObject": "SalesOrder",
        "status": "Active",
        "watchingThreshold": 10,
        "warningThreshold": 100,
        "type": "DeepSee",
        "deepseeKpiSpec": {
            "namespace": "TEST",
            "cube": "SalesOrderCube",
            "kpiMeasure": "count",
            "valueType": "raw",
            "kpiConditions": [
                "[COMMITTEDSHIPDATE].[H1].[COMMITTEDSHIPSTATUS].&[Late]"
            ],
            "kpiDimensions": [
                {
                    "name": "orderStatus",
                    "cubeDimension": "[orderStatus].[H1].[orderStatus]"
                },
                {
                    "name": "region",
                    "cubeDimension": "[salesRegion].[H1].[salesRegion]"
                } 
            ]
        }
    }
    set kpi = $CLASSMETHOD("SC.Core.Analytics.KPI.KpiDefinition","%New")
    set sc = kpi.%JSONImport(json)
    if $$$ISERR(sc) {
        w !,"Failed to save KPI"
        do $system.Status.DisplayError(sc)
    }
    else {
        w !,"KPI saved successfully"
    }
}

}
