/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture shipment carrier information. 
Class SC.Core.Data.Carrier Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// name
Property name As %String(MAXLEN = 256);

/// carrier type
Property type As %String(MAXLEN = 128);

/// tracking URL
Property trackingUrl As %String(MAXLEN = 256);

/// status
Property status As %String(MAXLEN = 128);

/// primary contact
Property primaryContact As %String(MAXLEN = 128);

/// primary phone
Property primaryPhone As %String(MAXLEN = 128);

/// company url
Property url As %String(MAXLEN = 512);

/// scac (Standard Carrier Alpha Code) code
Property scac As %String(MAXLEN = 4);

}
