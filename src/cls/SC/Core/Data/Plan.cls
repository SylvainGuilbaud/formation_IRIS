/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.Plan Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// location ID
Property locationId As %String(MAXLEN = 256);

ForeignKey locationIdFK(locationId) References SC.Data.Location(uidIndex) [ NoCheck ];

Index locationIdIndex On locationId;

/// product ID
Property productId As %String(MAXLEN = 256);

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex) [ NoCheck ];

Index productIdIndex On productId;

/// planning cycle
Property planCycle As %String(MAXLEN = 128);

/// plan type
Property planType As %String(MAXLEN = 128);

/// start date
Property startDate As %DateTime;

/// time frame days
Property timeFrameDays As %Numeric;

/// valid from date
Property validFromDate As %DateTime;

/// valid to date
Property validToDate As %DateTime;

/// quantity
Property quantity As %Numeric;

/// quantity unit of measure
Property quantityUom As %String(MAXLEN = 128);

/// data source
Property dataSource As %String(MAXLEN = 128);

}
