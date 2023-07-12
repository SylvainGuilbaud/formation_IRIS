/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture sales order information. This object 
/// is used together with SalesOrderLine object (which captures the line details of the order.)
Class SC.Data.SalesOrder Extends SC.Core.Data.SalesOrder
{

Storage Default
{
<Data name="SalesOrderDefaultData">
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
<Value>customerId</Value>
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
<Value>customerPoNumber</Value>
</Value>
<Value name="15">
<Value>orderStatus</Value>
</Value>
<Value name="16">
<Value>requestedShipDate</Value>
</Value>
<Value name="17">
<Value>salesOrganization</Value>
</Value>
<Value name="18">
<Value>salesRegion</Value>
</Value>
<Value name="19">
<Value>shipToLocationId</Value>
</Value>
<Value name="20">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.SalesOrderD</DataLocation>
<DefaultData>SalesOrderDefaultData</DefaultData>
<IdLocation>^SC.Data.SalesOrderD</IdLocation>
<IndexLocation>^SC.Data.SalesOrderI</IndexLocation>
<StreamLocation>^SC.Data.SalesOrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
