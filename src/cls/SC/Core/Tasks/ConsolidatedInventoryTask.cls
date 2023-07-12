/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Tasks.ConsolidatedInventoryTask Extends %SYS.Task.Definition
{

Parameter TaskName = "ConsolidatedInventory";

Method OnTask() As %Status
{
        return ##class(SC.Core.Data.Internal.ConsolidatedInventory).populateConsolidatedInventoryTable()
}

}
