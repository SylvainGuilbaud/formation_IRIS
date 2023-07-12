/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Object for bill of material. This object is commonly used in manufacturing to specify 
/// the parts required to make or assemble a products. BOM can be defined either in a flat
/// structure (simpe collection), or with a hierarchy in a tree structure.
Class SC.Data.BOM Extends SC.Core.Data.BOM
{

Storage Default
{
<Data name="BOMDefaultData">
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
<Value>itemId</Value>
</Value>
<Value name="6">
<Value>parentItemId</Value>
</Value>
<Value name="7">
<Value>isAlternate</Value>
</Value>
<Value name="8">
<Value>substituteFor</Value>
</Value>
<Value name="9">
<Value>quantity</Value>
</Value>
<Value name="10">
<Value>unitOfMeasure</Value>
</Value>
<Value name="11">
<Value>effectiveStartDate</Value>
</Value>
<Value name="12">
<Value>effectiveEndDate</Value>
</Value>
<Value name="13">
<Value>uid</Value>
</Value>
<Value name="14">
<Value>productionRelevant</Value>
</Value>
</Data>
<DataLocation>^SC.Data.BOMD</DataLocation>
<DefaultData>BOMDefaultData</DefaultData>
<IdLocation>^SC.Data.BOMD</IdLocation>
<IndexLocation>^SC.Data.BOMI</IndexLocation>
<StreamLocation>^SC.Data.BOMS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
