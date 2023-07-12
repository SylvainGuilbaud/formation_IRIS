/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Tasks.PredictInventory Extends %SYS.Task.Definition
{

Parameter TaskName = "PredictInventory";

Property forecastWindow As %Numeric [ InitialExpression = 14 ];

Method OnTask() As %Status
{
    do ##class(SC.Core.Data.Internal.PredictedInventory).%DeleteExtent()
    set sql = "SELECT * FROM SC_Data.ProductInventory JOIN SC_Data.DemandPlan ON ProductInventory.siteLocationId=DemandPlan.locationId AND ProductInventory.productId=DemandPlan.productId WHERE DATEDIFF(D, startDate, $H) < timeFrameDays AND DATEDIFF(D, $H, startDate) < ?"
    set statement = ##class(%SQL.Statement).%New()
    set status = statement.%Prepare(sql) 
    if $$$ISOK(status) {
        set st = status
        set rs = statement.%Execute()
        while (rs.%SQLCode >= 0) && (rs.%Next())  {
            set pid = rs.productId
            set lid = rs.siteLocationId
            set st = ..updateInventory(pid, lid, ..forecastWindow)
        }
    }
    if $$$ISERR(st) {
        do ##class(SC.Core.Data.Internal.PredictedInventory).%DeleteExtent()
        throw st
    }
    return st
}

Method updateInventory(pid As %String, lid As %String, daysOut As %Numeric) As %Status
{
    set dateOut = ##class(%SYSTEM.SQL.Functions).DATEADD("d", daysOut, $h)
    set sql = "SELECT id FROM SC_Core_Data_Internal.PredictedInventory WHERE productId = '?' AND locationId = '?' AND DATEDIFF(D, futureDate, '?') = 0"
    set statement = ##class(%SQL.Statement).%New()
    set status = statement.%Prepare(sql) 
    set obj = ""
    if $$$ISOK(status) {
        set rs = statement.%Execute(pid, lid, dateOut)
        if (rs.%SQLCode >= 0) && (rs.%Next())  {
            set obj = ##class(SC.Core.Data.Internal.PredictedInventory).%OpenId(rs.id)
        }
        else {
            set obj = ##class(SC.Core.Data.Internal.PredictedInventory).%New()
            set obj.locationId = lid
            set obj.productId = pid
            set obj.futureDate = dateOut
        }
    }
    else {
        return status
    }
    set status = obj.update()
    if ($$$ISOK(status))
        set status = obj.%Save()
    return status
}

}
