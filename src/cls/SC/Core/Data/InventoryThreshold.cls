/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.InventoryThreshold Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// site location ID
Property siteLocationId As %String(MAXLEN = 256) [ Required ];

ForeignKey siteLocationIdFK(siteLocationId) References SC.Data.Location(uidIndex);

Index siteLocationIdIndex On siteLocationId;

/// product ID
Property productId As %String(MAXLEN = 256) [ Required ];

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex);

Index productIdIndex On productId;

/// expected lead time
Property expectedLeadTime As %Numeric;

/// days of supply upper threshold
Property daysOfSupplyUpperThreshold As %Numeric;

/// days of supply lower threshold
Property daysOfSupplyLowerThreshold As %Numeric;

/// target days of supply
Property targetDaysOfSupply As %Numeric;

/// quantity upper threshold
Property quantityUpperThreshold As %Numeric;

/// quantity lower threshold
Property quantityLowerThreshold As %Numeric;

/// quantity unit of measure
Property quantityUom As %String(MAXLEN = 128);

/// velocity code
Property velocityCode As %String(MAXLEN = 128);

/// Safety stock level for the product at the location
Property safetyStock As %Numeric;

/// Minimum safety stock level
Property minSafetyStock As %Numeric;

}
