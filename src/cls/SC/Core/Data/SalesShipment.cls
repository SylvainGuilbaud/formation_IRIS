/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.SalesShipment Extends SC.Core.Data.Shipment [ Abstract, NoExtent ]
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

/// carrier ID
Property carrierId As %String(MAXLEN = 256);

ForeignKey carrierIdFK(carrierId) References SC.Data.Carrier(uidIndex) [ NoCheck ];

Index carrierIdIndex On carrierId;

/// origin location ID
Property originLocationId As %String(MAXLEN = 256);

ForeignKey originLocationIdFK(originLocationId) References SC.Data.Location(uidIndex) [ NoCheck ];

Index originLocationIdIndex On originLocationId;

/// destination location ID
Property destinationLocationId As %String(MAXLEN = 256);

ForeignKey destinationLocationIdFK(destinationLocationId) References SC.Data.Location(uidIndex) [ NoCheck ];

Index destinationLocationIdIndex On destinationLocationId;

/// uid of the parent shipment (parent shipment must exist)
Property parentShipmentId As %String(MAXLEN = 256);

ForeignKey parentShipmentdFK(destinationLocationId) References SC.Data.SalesShipment(uidIndex) [ NoCheck ];

Index parentShipmentIdIndex On parentShipmentId;

}
