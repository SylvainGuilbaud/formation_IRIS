/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture shipment carrier information. 
Class SC.Data.Carrier Extends SC.Core.Data.Carrier
{

Storage Default
{
<Data name="CarrierDefaultData">
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
<Value>name</Value>
</Value>
<Value name="5">
<Value>type</Value>
</Value>
<Value name="6">
<Value>trackingUrl</Value>
</Value>
<Value name="7">
<Value>status</Value>
</Value>
<Value name="8">
<Value>primaryContact</Value>
</Value>
<Value name="9">
<Value>primaryPhone</Value>
</Value>
<Value name="10">
<Value>url</Value>
</Value>
<Value name="11">
<Value>scac</Value>
</Value>
<Value name="12">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.CarrierD</DataLocation>
<DefaultData>CarrierDefaultData</DefaultData>
<IdLocation>^SC.Data.CarrierD</IdLocation>
<IndexLocation>^SC.Data.CarrierI</IndexLocation>
<StreamLocation>^SC.Data.CarrierS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
