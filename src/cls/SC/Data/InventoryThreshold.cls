/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to store inventory threshold information at different locations by products.
/// Example thresholds include min/max values, days of supply etc.
Class SC.Data.InventoryThreshold Extends SC.Core.Data.InventoryThreshold
{

Storage Default
{
<Data name="InventoryThresholdDefaultData">
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
<Value>siteLocationId</Value>
</Value>
<Value name="5">
<Value>productId</Value>
</Value>
<Value name="6">
<Value>expectedLeadTime</Value>
</Value>
<Value name="7">
<Value>daysOfSupplyUpperThreshold</Value>
</Value>
<Value name="8">
<Value>daysOfSupplyLowerThreshold</Value>
</Value>
<Value name="9">
<Value>targetDaysOfSupply</Value>
</Value>
<Value name="10">
<Value>quantityUpperThreshold</Value>
</Value>
<Value name="11">
<Value>quantityLowerThreshold</Value>
</Value>
<Value name="12">
<Value>quantityUom</Value>
</Value>
<Value name="13">
<Value>velocityCode</Value>
</Value>
<Value name="14">
<Value>uid</Value>
</Value>
<Value name="15">
<Value>safetyStock</Value>
</Value>
<Value name="16">
<Value>minSafetyStock</Value>
</Value>
</Data>
<DataLocation>^SC.Data.InventoryThresholdD</DataLocation>
<DefaultData>InventoryThresholdDefaultData</DefaultData>
<IdLocation>^SC.Data.InventoryThresholdD</IdLocation>
<IndexLocation>^SC.Data.InventoryThresholdI</IndexLocation>
<StreamLocation>^SC.Data.InventoryThresholdS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
