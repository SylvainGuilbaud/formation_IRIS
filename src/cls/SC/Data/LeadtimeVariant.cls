/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Object for variant values for different leadtimes, such as leadtime for PO delivery, production 
/// leadtime, etc. These are values calculated from actual transaction data over specific time 
/// period in an external system, and saved in IRIS for planning or optimization purposes. 
Class SC.Data.LeadtimeVariant Extends SC.Core.Data.LeadtimeVariant
{

Storage Default
{
<Data name="LeadtimeVariantDefaultData">
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
<Value>facilityLocationId</Value>
</Value>
<Value name="6">
<Value>timePeriod</Value>
</Value>
<Value name="7">
<Value>type</Value>
</Value>
<Value name="8">
<Value>meanValue</Value>
</Value>
<Value name="9">
<Value>standardDeviation</Value>
</Value>
<Value name="10">
<Value>unitOfMeasure</Value>
</Value>
<Value name="11">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.LeadtimeVariantD</DataLocation>
<DefaultData>LeadtimeVariantDefaultData</DefaultData>
<IdLocation>^SC.Data.LeadtimeVariantD</IdLocation>
<IndexLocation>^SC.Data.LeadtimeVariantI</IndexLocation>
<StreamLocation>^SC.Data.LeadtimeVariantS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
