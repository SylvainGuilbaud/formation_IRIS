/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to define shipping cost.
Class SC.Data.ShippingCost Extends SC.Core.Data.ShippingCost
{

Storage Default
{
<Data name="ShippingCostDefaultData">
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
<Value>originLocationId</Value>
</Value>
<Value name="5">
<Value>destinationLocationId</Value>
</Value>
<Value name="6">
<Value>productId</Value>
</Value>
<Value name="7">
<Value>carrierId</Value>
</Value>
<Value name="8">
<Value>transportationMode</Value>
</Value>
<Value name="9">
<Value>shippingType</Value>
</Value>
<Value name="10">
<Value>pricingType</Value>
</Value>
<Value name="11">
<Value>unitCost</Value>
</Value>
<Value name="12">
<Value>unitOfMeasure</Value>
</Value>
<Value name="13">
<Value>costCurrency</Value>
</Value>
<Value name="14">
<Value>effectiveStartDate</Value>
</Value>
<Value name="15">
<Value>effectiveEndDate</Value>
</Value>
<Value name="16">
<Value>status</Value>
</Value>
<Value name="17">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.ShippingCostD</DataLocation>
<DefaultData>ShippingCostDefaultData</DefaultData>
<IdLocation>^SC.Data.ShippingCostD</IdLocation>
<IndexLocation>^SC.Data.ShippingCostI</IndexLocation>
<StreamLocation>^SC.Data.ShippingCostS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
