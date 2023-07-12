/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture information of a shipment to a customer, typically related
/// to one or multiple sales orders. This object is used together with SalesShipmentLine object, 
/// which captures the line details of the shipment.
Class SC.Data.SalesShipment Extends SC.Core.Data.SalesShipment
{

Storage Default
{
<Data name="SalesShipmentDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>recordCreatedTime</Value>
</Value>
<Value name="3">
<Value>committedTimeOfArrival</Value>
</Value>
<Value name="4">
<Value>actualShipDate</Value>
</Value>
<Value name="5">
<Value>estimatedTimeOfArrival</Value>
</Value>
<Value name="6">
<Value>updatedEta</Value>
</Value>
<Value name="7">
<Value>carrierId</Value>
</Value>
<Value name="8">
<Value>actualTimeOfArrival</Value>
</Value>
<Value name="9">
<Value>deliveredDateTime</Value>
</Value>
<Value name="10">
<Value>originLocationId</Value>
</Value>
<Value name="11">
<Value>recipientName</Value>
</Value>
<Value name="12">
<Value>purchaseOrder</Value>
</Value>
<Value name="13">
<Value>destinationLocationId</Value>
</Value>
<Value name="14">
<Value>cancelledDateTime</Value>
</Value>
<Value name="15">
<Value>latestCoordinate</Value>
</Value>
<Value name="16">
<Value>latestCoordinateTime</Value>
</Value>
<Value name="17">
<Value>inTransitLocation</Value>
</Value>
<Value name="18">
<Value>shipperAccountNumber</Value>
</Value>
<Value name="19">
<Value>shipperName</Value>
</Value>
<Value name="20">
<Value>shippingCost</Value>
</Value>
<Value name="21">
<Value>shippingCostCurrency</Value>
</Value>
<Value name="22">
<Value>transportMode</Value>
</Value>
<Value name="23">
<Value>status</Value>
</Value>
<Value name="24">
<Value>substatus</Value>
</Value>
<Value name="25">
<Value>type</Value>
</Value>
<Value name="26">
<Value>weight</Value>
</Value>
<Value name="27">
<Value>weightUom</Value>
</Value>
<Value name="28">
<Value>hoursDelayed</Value>
</Value>
<Value name="29">
<Value>trackStartDateTime</Value>
</Value>
<Value name="30">
<Value>currentStatusCityName</Value>
</Value>
<Value name="31">
<Value>notifyCarrier</Value>
</Value>
<Value name="32">
<Value>freightForwarder</Value>
</Value>
<Value name="33">
<Value>carrierContainer</Value>
</Value>
<Value name="34">
<Value>houseAirwayBill</Value>
</Value>
<Value name="35">
<Value>parcelTrackingNumber</Value>
</Value>
<Value name="36">
<Value>billOfLadingNumber</Value>
</Value>
<Value name="37">
<Value>shipmentCategory</Value>
</Value>
<Value name="38">
<Value>carrierBookingNumber</Value>
</Value>
<Value name="39">
<Value>masterAirWaybillNumber</Value>
</Value>
<Value name="40">
<Value>externalShipmentID</Value>
</Value>
<Value name="41">
<Value>customerId</Value>
</Value>
<Value name="42">
<Value>lastUpdatedTime</Value>
</Value>
<Value name="43">
<Value>orderCreatedSource</Value>
</Value>
<Value name="44">
<Value>parentShipmentId</Value>
</Value>
<Value name="45">
<Value>predictedTimeOfArrival</Value>
</Value>
<Value name="46">
<Value>requestedTimeOfArrival</Value>
</Value>
<Value name="47">
<Value>shipmentCreatedDateTime</Value>
</Value>
<Value name="48">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.SalesShipmentD</DataLocation>
<DefaultData>SalesShipmentDefaultData</DefaultData>
<IdLocation>^SC.Data.SalesShipmentD</IdLocation>
<IndexLocation>^SC.Data.SalesShipmentI</IndexLocation>
<StreamLocation>^SC.Data.SalesShipmentS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
