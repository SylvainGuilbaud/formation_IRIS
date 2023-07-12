/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.SLA Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// type
Property type As %String(MAXLEN = 128);

/// product
Property productId As %String(MAXLEN = 256);

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex) [ NoCheck ];

Index productIdIndex On productId;

/// product brand
Property productBrand As %String(MAXLEN = 128);

/// product family
Property productFamily As %String(MAXLEN = 128);

/// operation
Property operation As %String(MAXLEN = 128);

/// cycle time
Property cycleTime As %Numeric;

/// cycle time unit
Property cycleTimeUnit As %String(MAXLEN = 128);

/// upper bound
Property upperBound As %Numeric;

/// lower bound
Property lowerBound As %Numeric;

/// bound unit
Property boundUnit As %String(MAXLEN = 128);

}
