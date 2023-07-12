/*
Copyright (c) 2022-2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.SalesOrderLine Extends SC.Core.Data.OrderLine [ Abstract, NoExtent ]
{

Parameter DSTIME = "AUTO";

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// sale order for this line item
Property salesOrderId As %String(MAXLEN = 256);

ForeignKey salesOrderIdFK(salesOrderId) References SC.Data.SalesOrder(uidIndex);

Index salesOrderIdIndex On salesOrderId;

/// product for the line item
Property productId As %String(MAXLEN = 256);

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex) [ NoCheck ];

Index productIdIndex On productId;

/// ship to location
Property shipToLocationId As %String(MAXLEN = 256);

ForeignKey shipToLocationIdFK(shipToLocationId) References SC.Data.Location(uidIndex) [ NoCheck ];

Index shipToLocationIdIndex On shipToLocationId;

}
