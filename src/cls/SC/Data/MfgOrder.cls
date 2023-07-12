/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture datya related to a manufacturing or work order. A manufacturing order
/// is typically a work order for some product or services, to be executed at a specified facility, with some
/// milestone dates. A manufacturing order can be associated with a sales order, if a sales order requires
/// some manufacturing process, assembling, or packaging. 
Class SC.Data.MfgOrder Extends SC.Core.Data.MfgOrder
{

Storage Default
{
<Data name="MfgOrderDefaultData">
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
<Value>workDescription</Value>
</Value>
<Value name="5">
<Value>orderStatus</Value>
</Value>
<Value name="6">
<Value>orderEntryDate</Value>
</Value>
<Value name="7">
<Value>workLocationId</Value>
</Value>
<Value name="8">
<Value>salesOrderId</Value>
</Value>
<Value name="9">
<Value>salesOrderLineNumber</Value>
</Value>
<Value name="10">
<Value>productId</Value>
</Value>
<Value name="11">
<Value>quantity</Value>
</Value>
<Value name="12">
<Value>unitOfMeasure</Value>
</Value>
<Value name="13">
<Value>plannedStartDate</Value>
</Value>
<Value name="14">
<Value>plannedEndDate</Value>
</Value>
<Value name="15">
<Value>actualStartDate</Value>
</Value>
<Value name="16">
<Value>actualEndDate</Value>
</Value>
<Value name="17">
<Value>notes</Value>
</Value>
<Value name="18">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.MfgOrderD</DataLocation>
<DefaultData>MfgOrderDefaultData</DefaultData>
<IdLocation>^SC.Data.MfgOrderD</IdLocation>
<IndexLocation>^SC.Data.MfgOrderI</IndexLocation>
<StreamLocation>^SC.Data.MfgOrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
