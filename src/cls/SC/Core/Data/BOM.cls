/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Object for bill of material. This object is commonly used in manufacturing to specify the parts required to make or assemble a products.
Class SC.Core.Data.BOM Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID of this BOM record
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// final product ID
Property productId As %String(MAXLEN = 256);

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex) [ NoCheck ];

Index productIdIndex On productId;

/// item/part ID
Property itemId As %String(MAXLEN = 256);

ForeignKey itemIdFK(itemId) References SC.Data.Product(uidIndex) [ NoCheck ];

Index itemIdIndex On itemId;

/// parent item ID
Property parentItemId As %String(MAXLEN = 256);

ForeignKey parentItemIdFK(parentItemId) References SC.Data.Product(uidIndex) [ NoCheck ];

Index parentItemIdIndex On parentItemId;

/// alternate indicator
Property isAlternate As %Boolean;

/// item/part ID this item substitutes for
Property substituteFor As %String(MAXLEN = 256);

ForeignKey substituteForFK(substituteFor) References SC.Data.Product(uidIndex) [ NoCheck ];

Index substituteForIndex On substituteFor;

/// quantity of this item required for the final product
Property quantity As %Numeric;

/// unit of measure for the quantity
Property unitOfMeasure As %String(MAXLEN = 128);

/// Effective start date
Property effectiveStartDate As %DateTime;

/// Effective end date
Property effectiveEndDate As %DateTime;

/// production indicator
Property productionRelevant As %Boolean;

}
