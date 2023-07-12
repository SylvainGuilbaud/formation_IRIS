/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.ShippingCost Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID and primary key
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// foreign key to the location table
Property originLocationId As %String(MAXLEN = 256);

ForeignKey originLocationIdFK(originLocationId) References SC.Data.Location(uidIndex) [ NoCheck ];

/// foreign key to the location table
Property destinationLocationId As %String(MAXLEN = 256);

ForeignKey destinationLocationIdFK(destinationLocationId) References SC.Data.Location(uidIndex) [ NoCheck ];

/// foreign key to the product table for the product to be shipped
Property productId As %String(MAXLEN = 256);

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex) [ NoCheck ];

/// foreign key to the carrier table for the carrier to be used
Property carrierId As %String(MAXLEN = 256);

ForeignKey carrierIdFK(carrierId) References SC.Data.Carrier(uidIndex) [ NoCheck ];

/// Mode of transportation: Truck, Ocean, Air, etc.
Property transportationMode As %String(MAXLEN = 256);

/// different types, such as expedited, FTL, LTL, etc.
Property shippingType As %String(MAXLEN = 128);

/// type of the price, such as promotion, contract price, regular price, etc.
Property pricingType As %String(MAXLEN = 128);

/// shipping cost of one unit of the product
Property unitCost As %Numeric;

/// unit of measure for the product associated with cost
Property unitOfMeasure As %String(MAXLEN = 256);

/// currency of the cost value
Property costCurrency As %String(MAXLEN = 256);

/// Effective start date
Property effectiveStartDate As %DateTime;

/// Effective end date
Property effectiveEndDate As %DateTime;

/// status value of the record
Property status As %String(MAXLEN = 256);

}
