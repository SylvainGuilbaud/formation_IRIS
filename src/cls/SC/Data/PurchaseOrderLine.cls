/*
Copyright (c) 2022-2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture purchase order line details. An order can have one or multiple 
/// order lines. There can be different types of lines, such as a line for a product, and another line
/// for a service. Order line is also linked to supply shipment lines for shipment tracking.
Class SC.Data.PurchaseOrderLine Extends SC.Core.Data.PurchaseOrderLine
{

Storage Default
{
<Data name="PurchaseOrderLineDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>lineNumber</Value>
</Value>
<Value name="3">
<Value>lastUpdatedTime</Value>
</Value>
<Value name="4">
<Value>purchaseOrderId</Value>
</Value>
<Value name="5">
<Value>requestedShipDate</Value>
</Value>
<Value name="6">
<Value>productId</Value>
</Value>
<Value name="7">
<Value>status</Value>
</Value>
<Value name="8">
<Value>shipToLocationId</Value>
</Value>
<Value name="9">
<Value>value</Value>
</Value>
<Value name="10">
<Value>valueCurrency</Value>
</Value>
<Value name="11">
<Value>quantity</Value>
</Value>
<Value name="12">
<Value>recordCreatedTime</Value>
</Value>
<Value name="13">
<Value>requestedDeliveryDate</Value>
</Value>
<Value name="14">
<Value>type</Value>
</Value>
<Value name="15">
<Value>uid</Value>
</Value>
<Value name="16">
<Value>unitOfMeasure</Value>
</Value>
</Data>
<DataLocation>^SC.Data.PurchaseOrderLineD</DataLocation>
<DefaultData>PurchaseOrderLineDefaultData</DefaultData>
<IdLocation>^SC.Data.PurchaseOrderLineD</IdLocation>
<IndexLocation>^SC.Data.PurchaseOrderLineI</IndexLocation>
<StreamLocation>^SC.Data.PurchaseOrderLineS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
