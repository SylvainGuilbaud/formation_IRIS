/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture line details of a supply shipment. It also provide the 
/// link to the corresponding purchase order line if order information is available. Although 
/// product info can be specified directly in this object (which is important when order
/// information is not available), it is preferred to get product info from the corresponding
/// purchase order lines.
Class SC.Data.SupplyShipmentLine Extends SC.Core.Data.SupplyShipmentLine
{

Storage Default
{
<Data name="SupplyShipmentLineDefaultData">
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
<Value>purchaseOrderLineNumber</Value>
</Value>
<Value name="6">
<Value>purchaseOrderLineId</Value>
</Value>
<Value name="7">
<Value>productId</Value>
</Value>
<Value name="8">
<Value>supplyShipmentId</Value>
</Value>
<Value name="9">
<Value>quantityShipped</Value>
</Value>
<Value name="10">
<Value>recordCreatedTime</Value>
</Value>
<Value name="11">
<Value>uid</Value>
</Value>
<Value name="12">
<Value>unitOfMeasure</Value>
</Value>
<Value name="13">
<Value>value</Value>
</Value>
<Value name="14">
<Value>valueCurrency</Value>
</Value>
</Data>
<DataLocation>^SC.Data.SupplyShipmentLineD</DataLocation>
<DefaultData>SupplyShipmentLineDefaultData</DefaultData>
<IdLocation>^SC.Data.SupplyShipmentLineD</IdLocation>
<IndexLocation>^SC.Data.SupplyShipmentLineI</IndexLocation>
<StreamLocation>^SC.Data.SupplyShipmentLineS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
