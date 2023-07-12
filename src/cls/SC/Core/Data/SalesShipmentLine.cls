/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.SalesShipmentLine Extends SC.Core.Data.ShipmentLine [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// sales order ID
Property salesOrderId As %String(MAXLEN = 256);

/// sales order line number
Property salesOrderLineNumber As %String(MAXLEN = 256);

ForeignKey salesOrderLineIdFK(salesOrderLineId) References SC.Data.SalesOrderLine(uidIndex) [ NoCheck ];

/// sales order line ID
Property salesOrderLineId As %String(MAXLEN = 256);

Index salesOrderLineIdIndex On salesOrderLineId;

/// product ID
Property productId As %String(MAXLEN = 256);

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex) [ NoCheck ];

Index productIdIndex On productId;

/// sales shipment ID
Property salesShipmentId As %String(MAXLEN = 256);

ForeignKey salesShipmentIdFK(salesShipmentId) References SC.Data.SalesShipment(uidIndex);

Index salesShipmentIdIndex On salesShipmentId;

}
