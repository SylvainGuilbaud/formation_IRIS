/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.Supplier Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID of supplier
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// name
Property name As %String(MAXLEN = 256);

/// data source
Property dataSource As %String(MAXLEN = 128);

/// source system supplier ID
Property sourceId As %String(MAXLEN = 256);

/// primary location
Property primaryLocationId As %String(MAXLEN = 256);

ForeignKey primaryLocationIdFK(primaryLocationId) References SC.Data.Location(uidIndex);

Index primaryLocationIdIndex On primaryLocationId;

/// primary phone
Property primaryPhone As %String(MAXLEN = 128);

/// primary contact
Property primaryContact As %String(MAXLEN = 128);

/// company url
Property url As %String(MAXLEN = 512);

/// type
Property type As %String(MAXLEN = 128);

/// status
Property status As %String(MAXLEN = 128);

}
