/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to track sourcing/supplier information for a given product. 
Class SC.Data.ProductSupplier Extends SC.Core.Data.ProductSupplier
{

Storage Default
{
<Data name="ProductSupplierDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>recordCreatedTime</Value>
</Value>
<Value name="3">
<Value>lastUpdatedTime</Value>
</Value>
<Value name="4">
<Value>productId</Value>
</Value>
<Value name="5">
<Value>supplierId</Value>
</Value>
<Value name="6">
<Value>supplierType</Value>
</Value>
<Value name="7">
<Value>hasContract</Value>
</Value>
<Value name="8">
<Value>unitPrice</Value>
</Value>
<Value name="9">
<Value>currency</Value>
</Value>
<Value name="10">
<Value>unitOfMeasure</Value>
</Value>
<Value name="11">
<Value>supplierStatus</Value>
</Value>
<Value name="12">
<Value>effectiveStartDate</Value>
</Value>
<Value name="13">
<Value>effectiveEndDate</Value>
</Value>
<Value name="14">
<Value>leadTime</Value>
</Value>
<Value name="15">
<Value>leadTimeUnit</Value>
</Value>
<Value name="16">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.ProductSupplierD</DataLocation>
<DefaultData>ProductSupplierDefaultData</DefaultData>
<IdLocation>^SC.Data.ProductSupplierD</IdLocation>
<IndexLocation>^SC.Data.ProductSupplierI</IndexLocation>
<StreamLocation>^SC.Data.ProductSupplierS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
