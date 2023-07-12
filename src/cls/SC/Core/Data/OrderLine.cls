/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.OrderLine Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// line number
Property lineNumber As %String(MAXLEN = 128) [ Required ];

/// quantity
Property quantity As %Numeric;

/// unit of measure
Property unitOfMeasure As %String(MAXLEN = 128);

/// requested ship date
Property requestedShipDate As %DateTime;

/// requested delivery date
Property requestedDeliveryDate As %DateTime;

/// status
Property status As %String(MAXLEN = 128);

/// type
Property type As %String(MAXLEN = 128);

/// order line value
Property value As %Numeric;

/// value currency
Property valueCurrency As %String(MAXLEN = 128);

}
