/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.SupplyShipmentLine Extends SC.Core.Data.ShipmentLine [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// purchase order ID
Property purchaseOrderId As %String(MAXLEN = 256);

ForeignKey purchaseOrderLineIdFK(purchaseOrderLineId) References SC.Data.PurchaseOrderLine(uidIndex) [ NoCheck ];

/// purchase order line number
Property purchaseOrderLineNumber As %String(MAXLEN = 256);

/// purchase order line ID
Property purchaseOrderLineId As %String(MAXLEN = 256);

Index purchaseOrderLineIdIndex On purchaseOrderLineId;

/// product ID
Property productId As %String(MAXLEN = 256);

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex) [ NoCheck ];

Index productIdIndex On productId;

/// supply shipment ID
Property supplyShipmentId As %String(MAXLEN = 256);

ForeignKey supplyShipmentIdFK(supplyShipmentId) References SC.Data.SupplyShipment(uidIndex);

Index supplyShipmentIdIndex On supplyShipmentId;

}
