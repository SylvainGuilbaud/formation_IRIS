/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Cube for product inventory, designed for lot level KPIs.
Class SC.Core.Analytics.Cube.ProductInventoryCube Extends %DeepSee.CubeDefinition [ DependsOn = SC.Data.ProductInventory, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="ProductInventoryCube" displayName="ProductInventoryCube" description="ProductInventoryCube" disabled="false" abstract="false" sourceClass="SC.Data.ProductInventory" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="productCategory" displayName="Product category hierarchy" description="Product category hierarchy" disabled="false" hasAll="false" allCaption="All productId" allDisplayName="productId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Category" displayName="Category" description="Product category" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductCategory(%source.productId)" list="false" nullReplacement="Undefined" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
      <level name="productId" disabled="false" sourceProperty="productId" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="productFamily" displayName="Product family hierarchy" description="Product family hierarchy" disabled="false" hasAll="false" allCaption="All productId" allDisplayName="productId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Family" displayName="Product Family" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductFamily(%source.productId)" list="false" nullReplacement="Undefined" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
      <level name="productId" disabled="false" sourceProperty="productId" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="productBrand" displayName="Product brand hierarchy" description="Product brand hierarchy" disabled="false" hasAll="false" allCaption="All productId" allDisplayName="productId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="brand" displayName="Product Brand" description="Product Brand" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductBrand(%source.productId)" list="false" nullReplacement="Undefined" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
      <level name="productId" disabled="false" sourceProperty="productId" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="productClass" displayName="Product class hierarchy" description="Product class hierarchy" disabled="false" hasAll="false" allCaption="All productId" allDisplayName="productId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="class" displayName="Product Class" description="Product Class" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductClass(%source.productId)" list="false" nullReplacement="Undefined" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="6">
      </level>
      <level name="productId" disabled="false" sourceProperty="productId" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="expirationDateHierarchy" displayName="Inventory Expiration Date" description="Inventory Expiration Date" disabled="false" hasAll="false" allCaption="All expirationDate" allDisplayName="expirationDate" sourceProperty="expirationDate" type="time" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="year" displayName="Expiration Year" description="Expiration Year" disabled="false" timeFunction="Year" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="7">
      </level>
      <level name="month" displayName="Expiration Month" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="8">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="inventoryType" displayName="Inventory Type" description="Inventory Type" disabled="false" hasAll="false" allCaption="All inventoryType" allDisplayName="inventoryType" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="inventoryType" disabled="false" sourceProperty="inventoryType" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="9">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="siteLocationHierarchy" displayName="Site Location Hierarchy" description="Site Location Hierarchy" disabled="false" hasAll="false" allCaption="All siteLocationId" allDisplayName="siteLocationId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="country" displayName="Inventory Location Country" description="Inventory Location Country" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getLocationCountry(%source.siteLocationId)" list="false" nullReplacement="Undefined" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="10">
      </level>
      <level name="siteLocationId" displayName="Site Location ID" description="Site Location ID" disabled="false" sourceProperty="siteLocationId" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="11">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="inventoryStatus" displayName="Inventory Status" description="Inventory Status" disabled="false" hasAll="false" allCaption="All status" allDisplayName="status" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" displayName="Inventory Status" description="Inventory Status" disabled="false" sourceProperty="status" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="12">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="expirationStatus" displayName="Expiration Status" description="Expiration Status" disabled="false" hasAll="false" allCaption="All expirationDate1" allDisplayName="expirationDate1" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" displayName="Aging status" description="Calculated status with values: Expired/Aging/Good/Undefined." disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getDaysBefore(%source.expirationDate)" list="false" nullReplacement="Undefined" rangeExpression="(,0]:Expired;(0,7]:Expiring;(7,):Good;" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="13">
      </level>
    </hierarchy>
  </dimension>
  <measure name="totalQuantity" displayName="Total Quantity" description="Total Quantity" disabled="false" sourceProperty="quantity" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="1">
  </measure>
  <measure name="reservedQuantity" displayName="Reserved quantity" description="Reserved quantity" disabled="false" sourceProperty="quantityReserved" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="2">
  </measure>
  <measure name="availableQuantity" displayName="Available Quantity" description="Available Quantity" disabled="false" sourceExpression="%source.quantity-%source.quantityReserved" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="3">
  </measure>
  <measure name="totalValue" displayName="Total Inventory Value" description="Total Inventory Value" disabled="false" sourceProperty="inventoryValue" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="4">
  </measure>
  <listing name="InventoryListing" disabled="false" listingType="table" fieldList="uid,siteLocationId,productId,quantity,quantityUom,expirationDate">
  </listing>
</cube>
}

Parameter DOMAIN;

}
