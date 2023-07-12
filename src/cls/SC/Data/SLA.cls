/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used for service-level agreement (SLA). SLA can be defined for a
/// product (time takes to source or make a product), or for a specific manufacturing 
/// process (such as time required for assembly or testing).
Class SC.Data.SLA Extends SC.Core.Data.SLA
{

Storage Default
{
<Data name="SLADefaultData">
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
<Value>type</Value>
</Value>
<Value name="5">
<Value>productId</Value>
</Value>
<Value name="6">
<Value>productBrand</Value>
</Value>
<Value name="7">
<Value>productFamily</Value>
</Value>
<Value name="8">
<Value>operation</Value>
</Value>
<Value name="9">
<Value>cycleTime</Value>
</Value>
<Value name="10">
<Value>cycleTimeUnit</Value>
</Value>
<Value name="11">
<Value>upperBound</Value>
</Value>
<Value name="12">
<Value>lowerBound</Value>
</Value>
<Value name="13">
<Value>boundUnit</Value>
</Value>
<Value name="14">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.SLAD</DataLocation>
<DefaultData>SLADefaultData</DefaultData>
<IdLocation>^SC.Data.SLAD</IdLocation>
<IndexLocation>^SC.Data.SLAI</IndexLocation>
<StreamLocation>^SC.Data.SLAS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
