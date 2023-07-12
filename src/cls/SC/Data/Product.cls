/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture master data of a product. A product can be the final product
/// made and sold by a company, it can also be a part used to make the final product. One can use product
/// type attributes to differential different type of products (such as final products vs parts/items).
Class SC.Data.Product Extends SC.Core.Data.Product
{

Storage Default
{
<Data name="ProductDefaultData">
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
<Value>dataSource</Value>
</Value>
<Value name="5">
<Value>sourceProductId</Value>
</Value>
<Value name="6">
<Value>productClass</Value>
</Value>
<Value name="7">
<Value>productCategory</Value>
</Value>
<Value name="8">
<Value>productBrand</Value>
</Value>
<Value name="9">
<Value>productFamily</Value>
</Value>
<Value name="10">
<Value>productSegment</Value>
</Value>
<Value name="11">
<Value>productNumber</Value>
</Value>
<Value name="12">
<Value>name</Value>
</Value>
<Value name="13">
<Value>description</Value>
</Value>
<Value name="14">
<Value>type</Value>
</Value>
<Value name="15">
<Value>status</Value>
</Value>
<Value name="16">
<Value>gtin</Value>
</Value>
<Value name="17">
<Value>defaultUom</Value>
</Value>
<Value name="18">
<Value>shelfLife</Value>
</Value>
<Value name="19">
<Value>agingThreshold</Value>
</Value>
<Value name="20">
<Value>uid</Value>
</Value>
<Value name="21">
<Value>shelfLifeUom</Value>
</Value>
<Value name="22">
<Value>agingThresholdUom</Value>
</Value>
<Value name="23">
<Value>defaultLeadTime</Value>
</Value>
<Value name="24">
<Value>leadTimeUom</Value>
</Value>
<Value name="25">
<Value>defaultGoodReceiptProcessingTime</Value>
</Value>
<Value name="26">
<Value>goodReceiptProcessingTimeUom</Value>
</Value>
<Value name="27">
<Value>costControl</Value>
</Value>
<Value name="28">
<Value>standardCost</Value>
</Value>
<Value name="29">
<Value>movingAverageCost</Value>
</Value>
<Value name="30">
<Value>costCurrency</Value>
</Value>
</Data>
<DataLocation>^SC.Data.ProductD</DataLocation>
<DefaultData>ProductDefaultData</DefaultData>
<IdLocation>^SC.Data.ProductD</IdLocation>
<IndexLocation>^SC.Data.ProductI</IndexLocation>
<StreamLocation>^SC.Data.ProductS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
