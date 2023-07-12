/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.ProductSupplier Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// Product ID
Property productId As %String(MAXLEN = 256);

ForeignKey productIdFK(productId) References SC.Data.Product(uidIndex) [ NoCheck ];

Index productIdIndex On productId;

/// Supplier ID
Property supplierId As %String(MAXLEN = 256);

ForeignKey supplierIdFK(supplierId) References SC.Data.Supplier(uidIndex) [ NoCheck ];

Index supplierIdIndex On supplierId;

/// Supplier Type
Property supplierType As %String(MAXLEN = 128);

/// Has Contract
Property hasContract As %Boolean;

/// Unit price
Property unitPrice As %Numeric;

/// Currency
Property currency As %String(MAXLEN = 128);

/// Unit of Measure
Property unitOfMeasure As %String(MAXLEN = 128);

/// Supplier status
Property supplierStatus As %String(MAXLEN = 128);

/// Effective start date
Property effectiveStartDate As %DateTime;

/// Effective end date
Property effectiveEndDate As %DateTime;

/// Lead time
Property leadTime As %Numeric;

/// Lead time unit
Property leadTimeUnit As %String(MAXLEN = 128);

}
