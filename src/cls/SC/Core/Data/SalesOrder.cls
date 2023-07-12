/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.SalesOrder Extends SC.Core.Data.Order [ Abstract, NoExtent ]
{

// for cube sync

Parameter DSTIME = "AUTO";

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// customer ID
Property customerId As %String(MAXLEN = 256);

ForeignKey customerIdFK(customerId) References SC.Data.Customer(uidIndex) [ NoCheck ];

Index customerIdIndex On customerId;

/// customer PO number
Property customerPoNumber As %String(MAXLEN = 128);

/// sales organization
Property salesOrganization As %String(MAXLEN = 128);

/// sales region
Property salesRegion As %String(MAXLEN = 256);

/// ship to location
Property shipToLocationId As %String(MAXLEN = 256);

ForeignKey shipToLocationIdFK(shipToLocationId) References SC.Data.Location(uidIndex) [ NoCheck ];

Index shipToLocationIdIndex On shipToLocationId;

}
