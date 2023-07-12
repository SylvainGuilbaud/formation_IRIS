/*
Copyright (c) 2022-2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Tasks.BuildCubes Extends %SYS.Task.Definition
{

Parameter TaskName = "RebuildAllCubes";

Method OnTask() As %Status
{
        set st = ##class(%DeepSee.Utils).%BuildCube("SalesOrderCube",1,,,,,.tStats)
        if $$$ISERR(st) Quit st
        set st = ##class(%DeepSee.Utils).%BuildCube("SalesOrderLineCube",1,,,,,.tStats)
        if $$$ISERR(st) Quit st
        set st = ##class(%DeepSee.Utils).%BuildCube("SalesShipmentCube",1,,,,,.tStats)
        set st = ##class(%DeepSee.Utils).%BuildCube("SupplyShipmentCube",1,,,,,.tStats)
        set st = ##class(%DeepSee.Utils).%BuildCube("ConsolidatedInventoryCube",1,,,,,.tStats)
        set st = ##class(%DeepSee.Utils).%BuildCube("ProductInventoryCube",1,,,,,.tStats)
        if $$$ISERR(st) Quit st
        set st = ##class(%DeepSee.Utils).%BuildCube("IssueCube",1,,,,,.tStats)
        return st
}

}
