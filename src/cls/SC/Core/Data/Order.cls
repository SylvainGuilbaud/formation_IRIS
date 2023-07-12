/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.Order Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

/// order status
Property orderStatus As %String(MAXLEN = 128);

/// requested ship date
Property requestedShipDate As %DateTime;

/// requested delivery date
Property requestedDeliveryDate As %DateTime;

/// committed ship date
Property committedShipDate As %DateTime;

/// committed delivery date
Property committedDeliveryDate As %DateTime;

/// order placed date
Property orderPlacedDate As %DateTime;

/// change order date
Property changeOrderDate As %DateTime;

/// order value
Property orderValue As %Numeric;

/// order currency
Property orderCurrency As %String(MAXLEN = 128);

/// data source
Property dataSource As %String(MAXLEN = 128);

/// source order ID
Property sourceOrderId As %String(MAXLEN = 256);

}
