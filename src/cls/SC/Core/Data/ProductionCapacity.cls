/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.ProductionCapacity Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID and primary key
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// foreign key to Location table to identify the facility
Property facilityId As %String(MAXLEN = 256);

ForeignKey facilityIdFK(facilityId) References SC.Data.Location(uidIndex) [ NoCheck ];

/// foreign key to Product table to identify a product
Property productId As %String(MAXLEN = 256);

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex) [ NoCheck ];

/// bandwidth of the facility to produce the product
Property bandwidth As %Numeric;

/// unit of measure for the bandwidth value
Property bandwidthUom As %String(MAXLEN = 256);

/// Lead time for the product
Property leadTime As %Numeric;

/// unit of measure for the lead time
Property leadTimeUom As %String(MAXLEN = 256);

/// unit cost for making the product
Property unitCost As %Numeric;

/// currency for the cost value
Property costCurrency As %String(MAXLEN = 256);

/// status value
Property status As %String(MAXLEN = 256);

}
