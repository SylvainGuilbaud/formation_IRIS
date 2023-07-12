/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// BI cube out of box
Class SC.Core.Analytics.Cube.SalesOrderCube Extends %DeepSee.CubeDefinition [ DependsOn = SC.Data.SalesOrder, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="SalesOrderCube" displayName="SalesOrderCube" description="BI cube out of box" disabled="false" abstract="false" sourceClass="SC.Data.SalesOrder" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" defaultListing="salesOrderListing" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="orderStatus" displayName="Order Status" description="Order Status" disabled="false" hasAll="false" allCaption="All orderStatus" allDisplayName="orderStatus" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="orderStatus" displayName="Order Status" description="Order Status" disabled="false" sourceExpression="$Select(%source.orderStatus=&quot;Closed&quot;:&quot;Closed&quot;, 1:&quot;Open&quot;)" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="salesRegion" displayName="Sales Region" description="Sales Region" disabled="false" hasAll="false" allCaption="All salesRegion" allDisplayName="salesRegion" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="salesRegion" displayName="Sales Region" description="Sales Region" disabled="false" sourceProperty="salesRegion" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="orderPlacedDate" displayName="Order Placed Date" description="Order Placed Date" disabled="false" hasAll="false" allCaption="All orderPlacedDate" allDisplayName="orderPlacedDate" sourceProperty="orderPlacedDate" type="time" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Year" displayName="Order placed Year" description="Order placed Year" disabled="false" timeFunction="Year" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
      <level name="Quarter" displayName="Order placed quarter" description="Order placed quarter" disabled="false" timeFunction="QuarterYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
      <level name="Month" displayName="Order placed month" description="Order placed month" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="6">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="customer" displayName="Customer" disabled="false" hasAll="false" allCaption="All customerId" allDisplayName="customerId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="country" displayName="Customer Country" description="Customer Country" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getCustomerCountry(%source.customerId)" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="7">
      </level>
      <level name="name" displayName="Customer Name" description="Customer Name" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getCustomerName(%source.customerId)" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="8">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="latestShipVsCommitted" displayName="Latest Ship to Committed " description="Latest Ship to Committed " disabled="false" hasAll="false" allCaption="All committedShipDate" allDisplayName="committedShipDate" sourceProperty="committedShipDate" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" displayName="Shipment Status based on Committed Date" description="Shipment Status based on Committed Date" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getSOLateShipHours(%source.uid)" list="false" nullReplacement="Unknown" rangeExpression="(,8]:OnTime;(8,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="9">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="openQuantity" displayName="Open Quantity" description="Open Quantity" disabled="false" hasAll="false" allCaption="All openQuantity" allDisplayName="openQuantity" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="quantityStatus" displayName="Quantity Status" description="Quantity Status" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getSOOpenQuantity(%source.uid)" list="false" rangeExpression="(,0):OverShipped;[0,0]:InFull;(0,100000000]:PartialShipped;(100000000,):NoShip;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="10">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="latestDeliveryVsCommitted" displayName="Latest Delivery vs Committed" description="Latest Delivery vs Committed" disabled="false" hasAll="false" allCaption="All committedDeliveryDate" allDisplayName="committedDeliveryDate" sourceProperty="committedDeliveryDate" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" displayName="Delivery Status vs Committed" description="Delivery Status vs Committed" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getSOLateDeliveryHours(%source.uid, %source.committedDeliveryDate)" list="false" nullReplacement="Unknown" rangeExpression="(,24]:OnTime;(24,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="11">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="latestDeliveryVsRequested" displayName="Latest Delivery vs Requested" description="Latest Delivery vs Requested" disabled="false" hasAll="false" allCaption="All requestedDeliveryDate" allDisplayName="requestedDeliveryDate" sourceProperty="requestedDeliveryDate" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" displayName="Delivery Status vs Requested" description="Delivery Status vs Requested" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getSOLateDeliveryHours(%source.uid, %source.requestedDeliveryDate)" list="false" nullReplacement="Unknown" rangeExpression="(,24]:OnTime;(24,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="12">
      </level>
    </hierarchy>
  </dimension>
  <measure name="totalOrderValue" displayName="Total Order Value" description="Total order value" disabled="false" sourceProperty="orderValue" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="1">
  </measure>
  <measure name="averageOrderValue" displayName="Average Order Value" description="Average Order Value" disabled="false" sourceProperty="orderValue" aggregate="AVG" type="number" hidden="false" searchable="false" factNumber="1">
  </measure>
  <measure name="maxOrderValue" displayName="Maximum Order Value" description="Maximum Order Value" disabled="false" sourceProperty="orderValue" aggregate="MAX" type="number" hidden="false" searchable="false" factNumber="1">
  </measure>
  <listing name="salesOrderListing" disabled="false" listingType="table" fieldList="uid,customerId,orderValue,orderStatus,orderPlacedDate,committedShipDate,committedDeliveryDate" orderBy="orderPlacedDate">
  </listing>
</cube>
}

Parameter DOMAIN;

}
