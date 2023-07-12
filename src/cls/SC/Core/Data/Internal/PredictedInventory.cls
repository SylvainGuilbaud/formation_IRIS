/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This class is used for save inventory prediction data, and availability calculatins.
Class SC.Core.Data.Internal.PredictedInventory Extends SC.Core.Data.TimeStampedData
{

/// inventory product ID
Property productId As %String(MAXLEN = 256);

// ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex);

/// Product index
Index productIdIndex On productId;

/// primary location
Property locationId As %String(MAXLEN = 256);

// ForeignKey locationIdFK(locationId) References SC.Data.Location(uidIndex);

/// Location index
Index locationIdIndex On locationId;

/// Number of days in the future
Property dayInFuture As %Numeric;

/// date in the future
Property futureDate As %DateTime [ Required ];

/// quantity on hand
Property onHandQuantity As %Numeric;

/// predicted demand 
Property predictedDemand As %Numeric;

/// future supply
Property futureSupply As %Numeric;

/// Calculated availability
Property availability As %Numeric;

Method update() As %Status
{
    set st =  ..updateOnHand()
    if $$$ISOK(st) {
        set st = ..updateDemand()
        if $$$ISOK(st) {
            set st = ..updateSupply()
            if $$$ISOK(st) {
                set ..availability = ..onHandQuantity - ..predictedDemand + ..futureSupply
            }
        }
    }
    return st
}

Method updateOnHand() As %Status
{
    // directly from inventory
    set ..dayInFuture = ##class(%SYSTEM.SQL.Functions).DATEDIFF("d", $h, ..futureDate)
    if ..dayInFuture <= 1 {
        set sql = "SELECT SUM(quantity) As total FROM SC_Data.ProductInventory WHERE productId = '?' AND siteLocationId = '?'"
        set statement = ##class(%SQL.Statement).%New()
        set st = statement.%Prepare(sql) 
        if $$$ISOK(st) {
            set rs = statement.%Execute(..productId, ..locationId)
            if (rs.%SQLCode >= 0) && (rs.%Next())  {
                set ..onHandQuantity = rs.total   
            }
        }
        return st
    }
    // recusively update past dates
    else {
        set st = ..updatePrevious()
        if $$$ISOK(st) {
            set sql = "SELECT availability FROM SC_Core_Data_Internal.PredictedInventory WHERE futureDate = '?' AND productId = '?' AND locationId = '?'"
            set statement = ##class(%SQL.Statement).%New()
            set st = statement.%Prepare(sql) 
            if $$$ISOK(st) {
                set rs = statement.%Execute(##class(%SYSTEM.SQL.Functions).DATEADD("d", -1, ..futureDate), ..productId, ..locationId)
                if (rs.%SQLCode >= 0) && (rs.%Next())  {
                    set val = rs.availability
                    if val '= "" {
                        set ..onHandQuantity = val
                    }
                }
            }
        }
        return st
    }
}

Method updatePrevious() As %Status
{
    set previousDay = ##class(%SYSTEM.SQL.Functions).DATEADD("d", -1, ..futureDate)
    set sql = "SELECT id FROM SC_Core_Data_Internal.PredictedInventory WHERE futureDate = '?' AND productId = '?' AND locationId = '?'"
    set statement = ##class(%SQL.Statement).%New()
    set st = statement.%Prepare(sql) 
    set obj = ""
    if $$$ISOK(st) {
        set rs = statement.%Execute(previousDay, ..productId, ..locationId)
        if (rs.%SQLCode >= 0) && (rs.%Next())  {
            set obj = ##class(SC.Core.Data.Internal.PredictedInventory).%OpenId(rs.id)
        }
        else {
            set obj = ##class(SC.Core.Data.Internal.PredictedInventory).%New()
            set obj.productId = ..productId
            set obj.locationId = ..locationId
            set obj.futureDate = previousDay
        }
    } else {
        set st = obj.update()
        if $$$ISOK(st) {
            set st = obj.%Save()
        }
    }
    return st
}

Method updateDemand() As %Status
{
    set sql = "SELECT quantity, MIN(timeFrameDays) AS total FROM SC_Data.DemandPlan WHERE productId = '?' AND locationId = '?' AND DATEDIFF(D, startDate, '?') >= 0 AND DATEDIFF(D, startDate, '?') < timeFrameDays"
    set statement = ##class(%SQL.Statement).%New()
    set st = statement.%Prepare(sql) 
    set obj = ""
    if $$$ISOK(st) {
        set rs = statement.%Execute(..productId, ..locationId, ..futureDate, ..futureDate)
        if (rs.%SQLCode >= 0) && (rs.%Next())  {
            set ..predictedDemand = rs.total
        }
    } 
    return st
}

Method updateSupply() As %Status
{
    set sql = "SELECT SUM(quantityShipped) AS total FROM SC_Data.SupplyShipment JOIN SC_Data.SupplyShipmentLine ON SupplyShipmentLine.SupplyShipmentId = SupplyShipment.uid LEFT JOIN SC_Data.PurchaseOrderLine ON SupplyShipmentLine. purchaseOrderLineId = PurchaseOrderLine.uid WHERE DATEDIFF(D, estimatedTimeOfArrival, '?') = 0 AND destinationLocationId = '?' AND (PurchaseOrderLine.productId  = '?' OR (PurchaseOrderLine.productId IS NULL AND SupplyShipmentLine.productId  = '?'))"
    set statement = ##class(%SQL.Statement).%New()
    set st = statement.%Prepare(sql) 
    set obj = ""
    if $$$ISOK(st) {
        set rs = statement.%Execute(..futureDate, ..locationId, ..productId, ..productId)
        if (rs.%SQLCode >= 0) && (rs.%Next())  {
            set ..futureSupply = rs.quantityShipped
        }
        else {
            set ..futureSupply = 0
        }
    } 
    return st
}

Storage Default
{
<Data name="PredictedInventoryDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>productId</Value>
</Value>
<Value name="3">
<Value>lastUpdatedTime</Value>
</Value>
<Value name="4">
<Value>locationId</Value>
</Value>
<Value name="5">
<Value>dayInFuture</Value>
</Value>
<Value name="6">
<Value>futureDate</Value>
</Value>
<Value name="7">
<Value>onHandQuantity</Value>
</Value>
<Value name="8">
<Value>predictedDemand</Value>
</Value>
<Value name="9">
<Value>futureSupply</Value>
</Value>
<Value name="10">
<Value>availability</Value>
</Value>
<Value name="11">
<Value>recordCreatedTime</Value>
</Value>
</Data>
<DataLocation>^SC.Core.Da5DF8.PredictedIn850FD</DataLocation>
<DefaultData>PredictedInventoryDefaultData</DefaultData>
<IdLocation>^SC.Core.Da5DF8.PredictedIn850FD</IdLocation>
<IndexLocation>^SC.Core.Da5DF8.PredictedIn850FI</IndexLocation>
<StreamLocation>^SC.Core.Da5DF8.PredictedIn850FS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
