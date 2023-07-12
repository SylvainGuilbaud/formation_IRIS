/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.MfgOrder Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// work description
Property workDescription As %String(MAXLEN = 512);

/// order status
Property orderStatus As %String(MAXLEN = 128);

/// order entry date
Property orderEntryDate As %DateTime;

/// work location
Property workLocationId As %String(MAXLEN = 256);

ForeignKey workLocationIdFK(workLocationId) References SC.Data.Location(uidIndex) [ NoCheck ];

Index workLocationIdIndex On workLocationId;

/// sales order
Property salesOrderId As %String(MAXLEN = 256);

ForeignKey salesOrderIdFK(salesOrderId) References SC.Data.SalesOrder(uidIndex) [ NoCheck ];

Index salesOrderIdIndex On salesOrderId;

/// sales order line
Property salesOrderLineNumber As %String(MAXLEN = 256);

/// product
Property productId As %String(MAXLEN = 256);

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex) [ NoCheck ];

Index productIdIndex On productId;

/// quantity
Property quantity As %Numeric;

/// unit of measure
Property unitOfMeasure As %String(MAXLEN = 128);

/// planned start date
Property plannedStartDate As %String;

/// planned end date
Property plannedEndDate As %DateTime;

/// actual start date
Property actualStartDate As %DateTime;

/// actual end date
Property actualEndDate As %DateTime;

/// notes
Property notes As %String(MAXLEN = 512);

}
