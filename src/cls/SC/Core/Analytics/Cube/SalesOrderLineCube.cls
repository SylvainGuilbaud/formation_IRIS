/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Cube for sales order lines
Class SC.Core.Analytics.Cube.SalesOrderLineCube Extends %DeepSee.CubeDefinition [ DependsOn = SC.Data.SalesOrderLine, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="SalesOrderLineCube" displayName="SalesOrderLineCube" description="Cube for sales order lines" disabled="false" abstract="false" sourceClass="SC.Data.SalesOrderLine" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" defaultListing="SalesOrderLineListing" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="lineType" displayName="Line Type" description="Line Type" disabled="false" hasAll="false" allCaption="All type" allDisplayName="type" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="lineType" displayName="Line Type" description="Line Type" disabled="false" sourceProperty="type" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="lineStatus" displayName="Line Status" description="Line Status" disabled="false" hasAll="false" allCaption="All status" allDisplayName="status" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="lineStatus" displayName="Line Status" description="Line Status" disabled="false" sourceProperty="status" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="productBrand" displayName="Product Brand" description="Product Brand" disabled="false" hasAll="false" allCaption="All productId" allDisplayName="productId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="productBrand" displayName="Product Brand" description="Product Brand" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductBrand(%source.productId)" list="false" nullReplacement="Other" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
      <level name="productName" displayName="Product Name" description="Product Name" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductName(%source.productId)" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="productFamily" displayName="Product Family" description="Product Family" disabled="false" hasAll="false" allCaption="All productId" allDisplayName="productId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="productFamily" displayName="Product Family" description="Product Family" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductFamily(%source.productId)" list="false" nullReplacement="Other" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="6">
      </level>
      <level name="productName" displayName="Product Name" description="Product Name" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductName(%source.productId)" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="productCategory" displayName="Product Category" description="Product Category" disabled="false" hasAll="false" allCaption="All productId" allDisplayName="productId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="productCategory" displayName="Product Category" description="Product Category" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductCategory(%source.productId)" list="false" nullReplacement="Other" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="7">
      </level>
      <level name="productName" displayName="Product Name" description="Product Name" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductName(%source.productId)" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="productClass" displayName="Product Class" description="Product Class" disabled="false" hasAll="false" allCaption="All productId" allDisplayName="productId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="productClass" displayName="Product Class" description="Product Class" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductClass(%source.productId)" list="false" nullReplacement="Other" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="8">
      </level>
      <level name="productName" displayName="Product Name" description="Product Name" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getProductName(%source.productId)" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="customer" displayName="Customer" description="Customer" disabled="false" hasAll="false" allCaption="All salesOrderId" allDisplayName="salesOrderId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="country" displayName="Customer Country" description="Customer Country" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getOrderCustomerCountry(%source.salesOrderId)" list="false" nullReplacement="Undefined" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="9">
      </level>
      <level name="name" displayName="Customer Name" description="Customer Name" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getOrderCustomerName(%source.salesOrderId)" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="10">
      </level>
    </hierarchy>
  </dimension>
  <measure name="lineValue" displayName="Order Line Value" description="Order Line Value" disabled="false" sourceProperty="value" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="1">
  </measure>
  <measure name="quantity" displayName="Quantity" description="Quantity" disabled="false" sourceProperty="quantity" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="2">
  </measure>
  <listing name="SalesOrderLineListing" disabled="false" listingType="table" fieldList="uid,lineNumber,productId,quantity,unitOfMeasure,value,valueCurrency,status,type">
  </listing>
</cube>
}

Parameter DOMAIN;

}
