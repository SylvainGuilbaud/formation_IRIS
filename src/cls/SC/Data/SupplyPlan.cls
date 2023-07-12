/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used for supply plans. 
Class SC.Data.SupplyPlan Extends SC.Core.Data.SupplyPlan
{

Storage Default
{
<Data name="SupplyPlanDefaultData">
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
<Value>locationId</Value>
</Value>
<Value name="5">
<Value>productId</Value>
</Value>
<Value name="6">
<Value>planCycle</Value>
</Value>
<Value name="7">
<Value>planType</Value>
</Value>
<Value name="8">
<Value>startDate</Value>
</Value>
<Value name="9">
<Value>timeFrameDays</Value>
</Value>
<Value name="10">
<Value>validFromDate</Value>
</Value>
<Value name="11">
<Value>validToDate</Value>
</Value>
<Value name="12">
<Value>quantity</Value>
</Value>
<Value name="13">
<Value>quantityUom</Value>
</Value>
<Value name="14">
<Value>dataSource</Value>
</Value>
<Value name="15">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.SupplyPlanD</DataLocation>
<DefaultData>SupplyPlanDefaultData</DefaultData>
<IdLocation>^SC.Data.SupplyPlanD</IdLocation>
<IndexLocation>^SC.Data.SupplyPlanI</IndexLocation>
<StreamLocation>^SC.Data.SupplyPlanS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
