/*
Copyright (c) 2022-2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This class holds consolidated inventory data by product and location.
Class SC.Core.Data.Internal.ConsolidatedInventory Extends SC.Core.Data.TimeStampedData
{

/// unique ID - use concat of productId and locationId
Property uid As %String(MAXLEN = 512);

Index uidIndex On uid [ PrimaryKey ];

// product ID from product table

Property productId As %String(MAXLEN = 256) [ Required ];

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex) [ NoCheck ];

Index productIdIndex On productId;

/// site location ID
Property locationId As %String(MAXLEN = 256) [ Required ];

ForeignKey locationIdFK(locationId) References SC.Data.Location(uidIndex) [ NoCheck ];

Index locationIdIndex On locationId;

/// consolidated quantity
Property totalQuantity As %Numeric;

/// quantity Uom
Property quantityUom As %String(MAXLEN = 128);

/// earliest expiration date of the aggregates
Property earliestExpirationDate As %DateTime;

/// minimum availability from PredictedInventory
Property minimumAvailability As %Numeric;

// implement after SC-48 is done

/// ConsolidatedInventry table name
Parameter CONSOLIDATEDINVENTRYTABLE = "SC_Core_Data_Internal.ConsolidatedInventory";

/// ProductInventory table name
Parameter PRODUCTINVENTORYTABLE = "SC_Data.ProductInventory";

/// PredictedInventory table name
Parameter PREDICTEDINVENTORYTABLE = "SC_Core_Data_Internal.PredictedInventory";

// for cube sync

Parameter DSTIME = "AUTO";

ClassMethod populateConsolidatedInventoryTable() As %Status
{
    set st = ..pullFromProductInventory()
    if ($$$ISERR(st)) Quit st
    set st = ..pullFromPredictedInventory()
    if ($$$ISERR(st)) Quit st
    return $$$OK
}

ClassMethod pullFromProductInventory() As %Status
{
    set sql = "INSERT OR UPDATE "_..#CONSOLIDATEDINVENTRYTABLE_
        "(uid, productid, locationId, totalQuantity, quantityUom, earliestExpirationDate) "_
        "SELECT (productId + siteLocationId), productId, siteLocationId, SUM(quantity), quantityUom, MIN(expirationDate) FROM "_
        ..#PRODUCTINVENTORYTABLE_" GROUP BY productId, siteLocationId, quantityUom"
    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) Quit qStatus}
    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0 quit $$$ERROR($$$SQLError, rset.%SQLCODE, rset.%Message)
    return $$$OK
}

ClassMethod pullFromPredictedInventory() As %Status
{
    set sql = "INSERT OR UPDATE "_..#CONSOLIDATEDINVENTRYTABLE_
        "(uid, minimumAvailability) "_
        "SELECT (productId + locationId), MIN(availability) FROM "_
        ..#PREDICTEDINVENTORYTABLE_" GROUP BY productId, locationId"
    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) Quit qStatus}
    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0 quit $$$ERROR($$$SQLError, rset.%SQLCODE, rset.%Message)
    return $$$OK
}

Storage Default
{
<Data name="ConsolidatedInventoryDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>recordCreatedTime</Value>
</Value>
<Value name="3">
<Value>lastUpdatedTime</Value>
</Value>
<Value name="4">
<Value>productId</Value>
</Value>
<Value name="5">
<Value>locationId</Value>
</Value>
<Value name="6">
<Value>totalQuantity</Value>
</Value>
<Value name="7">
<Value>quantityUom</Value>
</Value>
<Value name="8">
<Value>earliestExpirationDate</Value>
</Value>
<Value name="9">
<Value>minimumAvailability</Value>
</Value>
<Value name="10">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Core.Da5DF8.ConsolidateC139D</DataLocation>
<DefaultData>ConsolidatedInventoryDefaultData</DefaultData>
<IdLocation>^SC.Core.Da5DF8.ConsolidateC139D</IdLocation>
<IndexLocation>^SC.Core.Da5DF8.ConsolidateC139I</IndexLocation>
<StreamLocation>^SC.Core.Da5DF8.ConsolidateC139S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
