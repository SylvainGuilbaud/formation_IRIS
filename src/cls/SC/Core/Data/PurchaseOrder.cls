/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.PurchaseOrder Extends SC.Core.Data.Order [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// supplier ID
Property supplierId As %String(MAXLEN = 256);

ForeignKey supplierIdFK(supplierId) References SC.Data.Supplier(uidIndex) [ NoCheck ];

Index supplierIdIndex On supplierId;

/// type
Property type As %String(MAXLEN = 256);

/// ship to location 
Property shipToLocationId As %String(MAXLEN = 256);

ForeignKey shipToLocationIdFK(shipToLocationId) References SC.Data.Location(uidIndex) [ NoCheck ];

Index shipToLocationIdIndex On shipToLocationId;

}
