/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.Product Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// data source
Property dataSource As %String(MAXLEN = 128);

/// source system product ID
Property sourceProductId As %String(MAXLEN = 256);

/// product class
Property productClass As %String(MAXLEN = 128);

/// product category
Property productCategory As %String(MAXLEN = 128);

/// product brand
Property productBrand As %String(MAXLEN = 128);

/// product family
Property productFamily As %String(MAXLEN = 128);

/// product segment
Property productSegment As %String(MAXLEN = 128);

/// product number
Property productNumber As %String(MAXLEN = 128);

/// name of the product
Property name As %String(MAXLEN = 256);

/// product description
Property description As %String(MAXLEN = 512);

/// type of the product
Property type As %String(MAXLEN = 128);

/// product status
Property status As %String(MAXLEN = 128);

/// GS1 GTIN value of the product
Property gtin As %String(MAXLEN = 128);

/// default unit of measure
Property defaultUom As %String(MAXLEN = 128);

/// shelf life
Property shelfLife As %Numeric;

/// Shelf life unit of measure
Property shelfLifeUom As %String(MAXLEN = 128);

/// aging threshold
Property agingThreshold As %Numeric;

/// Aging threshold unit of measure
Property agingThresholdUom As %String(MAXLEN = 128);

/// Default lead time for the product
Property defaultLeadTime As %Numeric;

/// Unit of measure for lead time
Property leadTimeUom As %String(MAXLEN = 128);

/// Default good receiot processing time
Property defaultGoodReceiptProcessingTime As %Numeric;

/// Unit of measure for good receipt processing time
Property goodReceiptProcessingTimeUom As %String(MAXLEN = 128);

/// Cost control value
Property costControl As %String(MAXLEN = 32);

/// Standard product cost
Property standardCost As %Numeric;

/// Moving average cost of the product 
Property movingAverageCost As %Numeric;

/// Cost currentcy
Property costCurrency As %String(MAXLEN = 128);

}
