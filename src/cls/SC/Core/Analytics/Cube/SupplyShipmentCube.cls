/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// 
Class SC.Core.Analytics.Cube.SupplyShipmentCube Extends %DeepSee.CubeDefinition [ DependsOn = SC.Data.SupplyShipment, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="SupplyShipmentCube" displayName="SupplyShipmentCube" description="Embedded cube for supply shipments" disabled="false" abstract="false" sourceClass="SC.Data.SupplyShipment" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" defaultListing="SupplyShipmentListing" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="carrier" disabled="false" hasAll="false" allCaption="All carrierId" allDisplayName="carrierId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="name" displayName="Carrier Name" description="Carrier Name" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getCarrierName(%source.carrierId)" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="supplier" disabled="false" hasAll="false" allCaption="All supplierId" allDisplayName="supplierId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="country" displayName="Supplier Country" description="Supplier Country" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getSupplierCountry(%source.supplierId)" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
      <level name="name" displayName="Supplier Name" description="Supplier Name" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getSupplierName(%source.supplierId)" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="status" disabled="false" hasAll="false" allCaption="All status" allDisplayName="status" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" disabled="false" sourceProperty="status" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="transportMode" disabled="false" hasAll="false" allCaption="All transportMode" allDisplayName="transportMode" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="mode" displayName="Transportation Mode" description="Transportation Mode" disabled="false" sourceProperty="transportMode" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="6">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="actualShipDate" disabled="false" hasAll="false" allCaption="All actualShipDate" allDisplayName="actualShipDate" sourceProperty="actualShipDate" type="time" calendar="gregorian" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="year" displayName="Ship Year" description="Ship Year" disabled="false" timeFunction="Year" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="7">
      </level>
      <level name="quarter" displayName="Ship Quarter" description="Ship Quarter" disabled="false" timeFunction="QuarterYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="8">
      </level>
      <level name="month" displayName="Ship Month" description="Ship Month" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="9">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="actualTimeOfArrival" displayName="Actual Time Of Arrival" description="Dilevery Status based on actualTimeOfArrival" disabled="false" hasAll="false" allCaption="All actualTimeOfArrival" allDisplayName="actualTimeOfArrival" sourceProperty="actualTimeOfArrival" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="value" displayName="Actual Time Of Arrival" description="Actual Time Of Arrival" disabled="false" sourceProperty="actualTimeOfArrival" list="false" nullReplacement="InTransit" rangeExpression="(-100000,):Delivered;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="10">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="shipFromLocation" displayName="Ship From Location" description="Ship From Location" disabled="false" hasAll="false" allCaption="All originLocationId" allDisplayName="originLocationId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="country" displayName="Ship From Country" description="Ship From Country" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getLocationCountry(%source.originLocationId)" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="11">
      </level>
      <level name="state" displayName="Ship From State" description="Ship From State" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getLocationState(%source.originLocationId)" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="12">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="shipToLocation" displayName="Ship To Location" description="Ship To Location" disabled="false" hasAll="false" allCaption="All destinationLocationId" allDisplayName="destinationLocationId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="country" displayName="Ship To Country" description="Ship To Country" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getLocationCountry(%source.destinationLocationId)" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="13">
      </level>
      <level name="state" displayName="Ship To State" description="Ship To State" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getLocationState(%source.destinationLocationId)" list="false" nullReplacement="Unknown" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="14">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="actualVsCommittedDelivery" displayName="Actual vs Committed Time Of Arrival" description="Actual vs Committed Time Of Arrival" disabled="false" hasAll="false" allCaption="All actualTimeOfArrival" allDisplayName="actualTimeOfArrival" sourceProperty="actualTimeOfArrival" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getHoursLateWithDefaultActual(%source.committedTimeOfArrival,%source.actualTimeOfArrival) " list="false" nullReplacement="Unknown" rangeExpression="(,-8):Early;[-8,8]:OnTime;(8,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="15">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="actualVsRequestedDelivery" displayName="Actual vs Requested Time Of Arrival" description="Actual vs Requested Time Of Arrival" disabled="false" hasAll="false" allCaption="All actualTimeOfArrival" allDisplayName="actualTimeOfArrival" sourceProperty="actualTimeOfArrival" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getHoursLateWithDefaultActual(%source.requestedTimeOfArrival,%source.actualTimeOfArrival) " list="false" nullReplacement="Unknown" rangeExpression="(,-8):Early;[-8,8]:OnTime;(8,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="16">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="estimatedVsCommittedDelivery" displayName="Estimated vs Committed Time Of Arrival" description="Estimated vs Committed Time Of Arrival" disabled="false" hasAll="false" allCaption="All estimatedTimeOfArrival" allDisplayName="estimatedTimeOfArrival" sourceProperty="estimatedTimeOfArrival" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getHoursLate(%source.committedTimeOfArrival,%source.estimatedTimeOfArrival) " list="false" nullReplacement="Unknown" rangeExpression="(,-8):Early;[-8,8]:OnTime;(8,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="17">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="estimatedVsRequestedDelivery" displayName="Estimated vs Requested Time Of Arrival" description="Estimated vs Requested Time Of Arrival" disabled="false" hasAll="false" allCaption="All estimatedTimeOfArrival" allDisplayName="estimatedTimeOfArrival" sourceProperty="estimatedTimeOfArrival" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getHoursLate(%source.requestedTimeOfArrival,%source.estimatedTimeOfArrival) " list="false" nullReplacement="Unknown" rangeExpression="(,-8):Early;[-8,8]:OnTime;(8,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="18">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="predictedVsCommittedDelivery" displayName="Predicted vs Committed Time Of Arrival" description="Predicted vs Committed Time Of Arrival" disabled="false" hasAll="false" allCaption="All predictedTimeOfArrival" allDisplayName="predictedTimeOfArrival" sourceProperty="predictedTimeOfArrival" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getHoursLate(%source.committedTimeOfArrival,%source.predictedTimeOfArrival) " list="false" nullReplacement="Unknown" rangeExpression="(,-8):Early;[-8,8]:OnTime;(8,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="19">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="predictedVsRequestedDelivery" displayName="Predicted vs Requested Time Of Arrival " description="Predicted vs Requested Time Of Arrival " disabled="false" hasAll="false" allCaption="All predictedTimeOfArrival" allDisplayName="predictedTimeOfArrival" sourceProperty="predictedTimeOfArrival" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getHoursLate(%source.requestedTimeOfArrival,%source.predictedTimeOfArrival) " list="false" nullReplacement="Unknown" rangeExpression="(,-8):Early;[-8,8]:OnTime;(8,):Late;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="20">
      </level>
    </hierarchy>
  </dimension>
  <listing name="SupplyShipmentListing" disabled="false" listingType="table" fieldList="uid,status,supplierId,carrierId,actualShipDate,actualTimeOfArrival,originLocationId,destinationLocationId,committedTimeOfArrival,estimatedTimeOfArrival">
  </listing>
</cube>
}

Parameter DOMAIN;

}
