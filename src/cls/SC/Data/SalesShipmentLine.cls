/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture line details of a sales shipment. It also provide the 
/// link to the corresponding sales order line if order information is available. Although 
/// product info can be specified directly in this object (which is important when order
/// information is not available), it is preferred to get product info from the corresponding
/// sales order lines.
Class SC.Data.SalesShipmentLine Extends SC.Core.Data.SalesShipmentLine
{

Storage Default
{
<Data name="SalesShipmentLineDefaultData">
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
<Value>salesOrderId</Value>
</Value>
<Value name="5">
<Value>salesOrderLineNumber</Value>
</Value>
<Value name="6">
<Value>salesOrderLineId</Value>
</Value>
<Value name="7">
<Value>productId</Value>
</Value>
<Value name="8">
<Value>salesShipmentId</Value>
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
<DataLocation>^SC.Data.SalesShipmentLineD</DataLocation>
<DefaultData>SalesShipmentLineDefaultData</DefaultData>
<ExtentSize>0</ExtentSize>
<IdLocation>^SC.Data.SalesShipmentLineD</IdLocation>
<IndexLocation>^SC.Data.SalesShipmentLineI</IndexLocation>
<StreamLocation>^SC.Data.SalesShipmentLineS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
