/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Object for variant values for different leadtimes, such as leadtime for PO delivery, production 
/// leadtime, etc. These are values calculated from actual transaction data over specific time 
/// period in an external system, and saved in IRIS for planning or optimization purposes. 
Class SC.Core.Data.LeadtimeVariant Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID of this BOM record
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// accociated product ID
Property productId As %String(MAXLEN = 256);

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex) [ NoCheck ];

Index productIdIndex On productId;

/// Associated facility location ID, such as location ID of a plant
Property facilityLocationId As %String(MAXLEN = 256);

ForeignKey facilityLocationIdFK(facilityLocationId) References SC.Data.Location(uidIndex) [ NoCheck ];

Index facilityLocationIdIndex On facilityLocationId;

/// Time period for which the leadtime variant was calculated. For example, this can be a specific month of an year.
Property timePeriod As %String(MAXLEN = 32);

/// Type of the lead time, such as PO delivery leadtime, or production order leadtime, etc.
Property type As %String(MAXLEN = 64);

/// mean value for the leadtime
Property meanValue As %Numeric(SCALE = 9);

/// Standard deviation of the leadtime
Property standardDeviation As %Numeric(SCALE = 9);

/// unit of measure for the mean value and standard deviation
Property unitOfMeasure As %String(MAXLEN = 128);

}
