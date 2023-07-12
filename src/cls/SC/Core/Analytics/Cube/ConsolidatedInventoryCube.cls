/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This cube is for consolidated inventory data for given product and location. Each unique combination of (product, location) has only one records in the source table. If a count is 0 in this table, that means there is no more such product at this location, while a count =0 in ProductInventory table does not necessarily mean the product is out of stock at the location.
Class SC.Core.Analytics.Cube.ConsolidatedInventoryCube Extends %DeepSee.CubeDefinition [ DependsOn = SC.Core.Data.Internal.ConsolidatedInventory, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="ConsolidatedInventoryCube" displayName="ConsolidatedInventoryCube" disabled="false" abstract="false" sourceClass="SC.Core.Data.Internal.ConsolidatedInventory" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="quantityStatus" displayName="Total Quantity Status" description="Total Quantity Status" disabled="false" hasAll="false" allCaption="All totalQuantity" allDisplayName="totalQuantity" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" displayName="Total Quantity Status" description="Total Quantity Status" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getInventoryStatusValue(%source.totalQuantity,%source.productId,%source.locationId)" list="false" nullReplacement="Undefined" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="productBrand" displayName="Product Brand Hierarchy" description="Product Brand Hierarchy" disabled="false" hasAll="false" allCaption="All productId" allDisplayName="productId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="brand" displayName="Product Brand" description="Product Brand" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductBrand(%source.productId)" list="false" nullReplacement="Undefined" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
      <level name="productId" disabled="false" sourceProperty="productId" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="productCategory" displayName="Product Category Hierarchy" description="Product Category Hierarchy" disabled="false" hasAll="false" allCaption="All productId" allDisplayName="productId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="category" displayName="Product Category" description="Product Category" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductCategory(%source.productId)" list="false" nullReplacement="Undefined" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
      <level name="productId" disabled="false" sourceProperty="productId" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="productFamily" displayName="Product Family Hierarchy" description="Product Family Hierarchy" disabled="false" hasAll="false" allCaption="All productId" allDisplayName="productId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="family" displayName="Product Family Hierarchy" description="Product Family Hierarchy" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductFamily(%source.productId)" list="false" nullReplacement="Undefined" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="6">
      </level>
      <level name="productId" disabled="false" sourceProperty="productId" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="productClass" displayName="Product Class Hierarchy" description="Product Class Hierarchy" disabled="false" hasAll="false" allCaption="All productId" allDisplayName="productId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="class" displayName="Product Class Hierarchy" description="Product Class Hierarchy" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductClass(%source.productId)" list="false" nullReplacement="Undefined" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="7">
      </level>
      <level name="productId" disabled="false" sourceProperty="productId" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="predictedStatus" displayName="Predicted Inventory Status" description="Predicted Inventory Status" disabled="false" hasAll="false" allCaption="All minAvailability" allDisplayName="minAvailability" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="minAvailability" disabled="false" sourceProperty="minimumAvailability" list="false" nullReplacement="Undefined" rangeExpression="(,0]:PredictedOutOfStock;(0,):Normal;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="8">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="locationHierarchy" displayName="Location Hierarchy" description="Location Hierarchy" disabled="false" hasAll="false" allCaption="All locationId" allDisplayName="locationId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="country" displayName="Location Country" description="Location Country" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getLocationCountry(%source.locationId)" list="false" nullReplacement="Undefined" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="9">
      </level>
      <level name="locationId" disabled="false" sourceProperty="locationId" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="10">
      </level>
    </hierarchy>
  </dimension>
  <listing name="ConsolidatedInventoryListing" disabled="false" listingType="table" fieldList="locationId,productId,totalQuantity,quantityUom,minimumAvailability,earliestExpirationDate">
  </listing>
</cube>
}

Parameter DOMAIN;

}
