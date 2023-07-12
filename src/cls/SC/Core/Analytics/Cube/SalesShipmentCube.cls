/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Cube class for sales shipments
Class SC.Core.Analytics.Cube.SalesShipmentCube Extends %DeepSee.CubeDefinition [ DependsOn = SC.Data.SalesShipment, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="SalesShipmentCube" displayName="SalesShipmentCube" description="Cube class for sales shipments" disabled="false" abstract="false" sourceClass="SC.Data.SalesShipment" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" defaultListing="SalesShipmentListing" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="carrier" displayName="Carrier" description="Carrier" disabled="false" hasAll="false" allCaption="All carrierId" allDisplayName="carrierId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="name" displayName="Carrier Name" description="Carrier Name" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getCarrierName(%source.carrierId)" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="customer" displayName="Customer" description="Customer" disabled="false" hasAll="false" allCaption="All customerID" allDisplayName="customerID" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="country" displayName="Customer Country" description="Customer Country" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getCustomerCountry(%source.customerId)" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
      <level name="name" displayName="Customer Name" description="Customer Name" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getCustomerName(%source.customerId)" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="status" disabled="false" hasAll="false" allCaption="All status" allDisplayName="status" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" disabled="false" sourceProperty="status" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="actualVsCommittedDelivery" displayName="Actual vs. Committed Time Of Arrival" description="Actual vs Committed Time Of Arrival" disabled="false" hasAll="false" allCaption="All committedTimeOfArrival" allDisplayName="committedTimeOfArrival" sourceProperty="committedTimeOfArrival" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" displayName="Delivery Status" description="Delivery Status" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getHoursLateWithDefaultActual(%source.committedTimeOfArrival,%source.actualTimeOfArrival) " timeFunction="HourNumber" list="false" nullReplacement="Unknown" rangeExpression="(,-8):Early;[-8,8]:OnTime;(8,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="6">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="transportMode" displayName="Transportation Mode" description="Transportation Mode" disabled="false" hasAll="false" allCaption="All transportMode" allDisplayName="transportMode" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="mode" displayName="Transportation Mode" description="Transportation Mode" disabled="false" sourceProperty="transportMode" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="7">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="estimatedVsCommittedDelivery" displayName="Estimated vs Committed Time Of Arrival" description="Estimated vs Committed Time Of Arrival" disabled="false" hasAll="false" allCaption="All estimatedTimeOfArrival" allDisplayName="estimatedTimeOfArrival" sourceProperty="estimatedTimeOfArrival" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" displayName="Delivery Status" description="Delivery Status" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getHoursLate(%source.committedTimeOfArrival,%source.estimatedTimeOfArrival) " list="false" nullReplacement="Unknown" rangeExpression="(,-8):Early;[-8,8]:OnTime;(8,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="8">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="actualVsRequestedDelivery" displayName="Actual vs Requested Time Of Arrival" description="Actual vs Requested Time Of Arrival" disabled="false" hasAll="false" allCaption="All requestedTimeOfArrival" allDisplayName="requestedTimeOfArrival" sourceProperty="requestedTimeOfArrival" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" displayName="Delivery Status" description="Delivery Status" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getHoursLateWithDefaultActual(%source.requestedTimeOfArrival,%source.actualTimeOfArrival) " list="false" nullReplacement="Unknown" rangeExpression="(,-8):Early;[-8,8]:OnTime;(8,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="9">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="predictedVsCommittedDelivery" displayName="Predicted vs Committed Time Of Arrival" description="Predicted vs Committed Time Of Arrival" disabled="false" hasAll="false" allCaption="All predictedTimeOfArrival" allDisplayName="predictedTimeOfArrival" sourceProperty="predictedTimeOfArrival" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" displayName="Delivery Status" description="Delivery Status" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getHoursLate(%source.committedTimeOfArrival,%source.predictedTimeOfArrival) " list="false" nullReplacement="Unknown" rangeExpression="(,-8):Early;[-8,8]:OnTime;(8,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="10">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="actualShipDate" displayName="Actual Ship Date" description="Actual Ship Date" disabled="false" hasAll="false" allCaption="All actualShipDate" allDisplayName="actualShipDate" sourceProperty="actualShipDate" type="time" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="year" displayName="Ship Year" description="Year" disabled="false" timeFunction="Year" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="11">
      </level>
      <level name="quarter" displayName="Ship Quarter" description="Quarter" disabled="false" timeFunction="QuarterYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="12">
      </level>
      <level name="month" displayName="Ship Month" description="Month" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="13">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="actualTimeOfArrival" displayName="Actual Time Of Arrival" description="Actual Time Of Arrival" disabled="false" hasAll="false" allCaption="All actualTimeOfArrival" allDisplayName="actualTimeOfArrival" sourceProperty="actualTimeOfArrival" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="value" displayName="Actual Time Of Arrival" description="Actual Time Of Arrival" disabled="false" sourceProperty="actualTimeOfArrival" list="false" nullReplacement="InTransit" rangeExpression="(-100000000,):Delivered;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="14">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="shipFromLocation" displayName="Ship From Location" description="Ship From Location" disabled="false" hasAll="false" allCaption="All originLocationId" allDisplayName="originLocationId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="country" displayName="Country" description="Ship from country" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getLocationCountry(%source.originLocationId)" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="15">
      </level>
      <level name="state" displayName="State" description="Ship from State" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getLocationState(%source.originLocationId)" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="16">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="shipToLocation" displayName="Ship To Location" description="Ship To Location" disabled="false" hasAll="false" allCaption="All destinationLocationId" allDisplayName="destinationLocationId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="country" displayName="Country" description="Ship to country" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getLocationCountry(%source.destinationLocationId)" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="17">
      </level>
      <level name="state" displayName="State" description="Ship to state" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getLocationState(%source.destinationLocationId)" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="18">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="estimatedVsRequestedDelivery" displayName="Estimated vs Requested Time Of Arrival" description="Estimated vs Requested Time Of Arrival" disabled="false" hasAll="false" allCaption="All estimatedTimeOfArrival" allDisplayName="estimatedTimeOfArrival" sourceProperty="estimatedTimeOfArrival" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" displayName="Delivery Status" description="Delivery Status" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getHoursLate(%source.requestedTimeOfArrival,%source.estimatedTimeOfArrival) " list="false" nullReplacement="Unknown" rangeExpression="(,-8):Early;[-8,8]:OnTime;(8,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="19">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="predictedVsRequestedDelivery" displayName="Predicted vs Requested Time Of Arrival " description="Predicted vs Requested Time Of Arrival " disabled="false" hasAll="false" allCaption="All predictedTimeOfArrival" allDisplayName="predictedTimeOfArrival" sourceProperty="predictedTimeOfArrival" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" displayName="Delivery Status" description="Delivery Status" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getHoursLate(%source.requestedTimeOfArrival,%source.predictedTimeOfArrival) " list="false" nullReplacement="Unknown" rangeExpression="(,-8):Early;[-8,8):OnTime;(8,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="20">
      </level>
    </hierarchy>
  </dimension>
  <listing name="SalesShipmentListing" disabled="false" listingType="table" fieldList="uid,status,customerId,carrierId,originLocationId,destinationLocationId,actualShipDate,actualTimeOfArrival,committedTimeOfArrival,estimatedTimeOfArrival">
  </listing>
</cube>
}

Parameter DOMAIN;

}
