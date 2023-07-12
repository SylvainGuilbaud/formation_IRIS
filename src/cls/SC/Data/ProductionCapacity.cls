/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used for production capacity of a product at a specific facility.
Class SC.Data.ProductionCapacity Extends SC.Core.Data.ProductionCapacity
{

Storage Default
{
<Data name="ProductionCapacityDefaultData">
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
<Value>facilityId</Value>
</Value>
<Value name="5">
<Value>productId</Value>
</Value>
<Value name="6">
<Value>bandwidth</Value>
</Value>
<Value name="7">
<Value>bandwidthUom</Value>
</Value>
<Value name="8">
<Value>leadTime</Value>
</Value>
<Value name="9">
<Value>leadTimeUom</Value>
</Value>
<Value name="10">
<Value>unitCost</Value>
</Value>
<Value name="11">
<Value>costCurrency</Value>
</Value>
<Value name="12">
<Value>status</Value>
</Value>
<Value name="13">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.ProductionCapacityD</DataLocation>
<DefaultData>ProductionCapacityDefaultData</DefaultData>
<IdLocation>^SC.Data.ProductionCapacityD</IdLocation>
<IndexLocation>^SC.Data.ProductionCapacityI</IndexLocation>
<StreamLocation>^SC.Data.ProductionCapacityS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
