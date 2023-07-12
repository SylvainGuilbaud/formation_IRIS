/*
Copyright (c) 2022-2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.PurchaseOrderLine Extends SC.Core.Data.OrderLine [ Abstract, NoExtent ]
{

Property uid As %String(MAXLEN = 128);

Index uidIndex On uid [ PrimaryKey ];

Property purchaseOrderId As %String(MAXLEN = 256);

ForeignKey purchaseOrderIdFK(purchaseOrderId) References SC.Data.PurchaseOrder(uidIndex);

Index purchaseOrderIdIndex On purchaseOrderId;

Property productId As %String(MAXLEN = 256);

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex) [ NoCheck ];

Index productIdIndex On productId;

Property shipToLocationId As %String(MAXLEN = 256);

ForeignKey shipToLocationIdFK(shipToLocationId) References SC.Data.Location(uidIndex) [ NoCheck ];

Index shipToLocationIdIndex On shipToLocationId;

}
