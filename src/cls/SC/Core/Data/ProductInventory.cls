/*
Copyright (c) 2022-2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.ProductInventory Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

// for cube sync

Parameter DSTIME = "AUTO";

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// site location ID
Property siteLocationId As %String(MAXLEN = 256) [ Required ];

ForeignKey siteLocationIdFK(siteLocationId) References SC.Data.Location(uidIndex) [ NoCheck ];

Index siteLocationIdIndex On siteLocationId;

/// product ID
Property productId As %String(MAXLEN = 256) [ Required ];

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex) [ NoCheck ];

Index productIdIndex On productId;

/// location number
Property locationNumber As %String(MAXLEN = 128);

/// lot number
Property lotNumber As %String(MAXLEN = 128);

/// quantity
Property quantity As %Numeric;

/// quantity Uom
Property quantityUom As %String(MAXLEN = 128);

/// storage date
Property storageDate As %DateTime;

/// expiration date
Property expirationDate As %DateTime;

/// status
Property status As %String(MAXLEN = 128);

/// inventory type
Property inventoryType As %String(MAXLEN = 128);

/// inventory class
Property inventoryClass As %String(MAXLEN = 128);

/// inventory value
Property inventoryValue As %Numeric;

/// inventory value currency
Property valueCurrency As %String(MAXLEN = 128);

/// quantity reserved
Property quantityReserved As %Numeric;

/// quantity reserved unit of measure
Property quantityReservedUom As %String(MAXLEN = 128);

}
