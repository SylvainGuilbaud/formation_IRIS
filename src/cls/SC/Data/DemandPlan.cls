/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used for demand plans. Demand plans can be provided in different cycles, for products at different locations.
Class SC.Data.DemandPlan Extends SC.Core.Data.DemandPlan
{

Storage Default
{
<Data name="DemandPlanDefaultData">
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
<Value name="16">
<Value>frequency</Value>
</Value>
<Value name="17">
<Value>DailyDemand</Value>
</Value>
</Data>
<DataLocation>^SC.Data.DemandPlanD</DataLocation>
<DefaultData>DemandPlanDefaultData</DefaultData>
<IdLocation>^SC.Data.DemandPlanD</IdLocation>
<IndexLocation>^SC.Data.DemandPlanI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="dataSource">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="frequency">
<AverageFieldSize>8</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="lastUpdatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="locationId">
<AverageFieldSize>15</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="planCycle">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="planType">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="productId">
<AverageFieldSize>9</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="quantity">
<AverageFieldSize>4</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="quantityUom">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="recordCreatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="startDate">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="timeFrameDays">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="uid">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="validFromDate">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="validToDate">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="uidIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^SC.Data.DemandPlanS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
