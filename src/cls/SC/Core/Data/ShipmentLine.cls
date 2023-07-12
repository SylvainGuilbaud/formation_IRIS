/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.ShipmentLine Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// line number
Property lineNumber As %String(MAXLEN = 128) [ Required ];

/// quantity shipped
Property quantityShipped As %Numeric;

/// unit of measure
Property unitOfMeasure As %String(MAXLEN = 128);

/// value
Property value As %Numeric;

/// value currency
Property valueCurrency As %String(MAXLEN = 128);

}
