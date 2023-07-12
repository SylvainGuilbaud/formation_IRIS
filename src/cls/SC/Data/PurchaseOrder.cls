/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture purchase/supply order information. THis object 
/// is used together with PurchaseOrderLine object (which captures the line details of the order.)
Class SC.Data.PurchaseOrder Extends SC.Core.Data.PurchaseOrder
{

Storage Default
{
<Data name="PurchaseOrderDefaultData">
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
<Value>requestedShipDate</Value>
</Value>
<Value name="5">
<Value>requestedDeliveryDate</Value>
</Value>
<Value name="6">
<Value>committedShipDate</Value>
</Value>
<Value name="7">
<Value>committedDeliveryDate</Value>
</Value>
<Value name="8">
<Value>orderPlacedDate</Value>
</Value>
<Value name="9">
<Value>changeOrderDate</Value>
</Value>
<Value name="10">
<Value>orderValue</Value>
</Value>
<Value name="11">
<Value>orderCurrency</Value>
</Value>
<Value name="12">
<Value>dataSource</Value>
</Value>
<Value name="13">
<Value>sourceOrderId</Value>
</Value>
<Value name="14">
<Value>orderStatus</Value>
</Value>
<Value name="15">
<Value>shipToLocationId</Value>
</Value>
<Value name="16">
<Value>supplierId</Value>
</Value>
<Value name="17">
<Value>type</Value>
</Value>
<Value name="18">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.PurchaseOrderD</DataLocation>
<DefaultData>PurchaseOrderDefaultData</DefaultData>
<IdLocation>^SC.Data.PurchaseOrderD</IdLocation>
<IndexLocation>^SC.Data.PurchaseOrderI</IndexLocation>
<SQLMap name="uidIndex">
<BlockCount>-28</BlockCount>
</SQLMap>
<StreamLocation>^SC.Data.PurchaseOrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
