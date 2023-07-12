/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture master data of a customer. 
Class SC.Data.Customer Extends SC.Core.Data.Customer
{

Storage Default
{
<Data name="CustomerDefaultData">
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
<Value>dataSource</Value>
</Value>
<Value name="6">
<Value>sourceId</Value>
</Value>
<Value name="7">
<Value>primaryLocationId</Value>
</Value>
<Value name="8">
<Value>shipToLocationId</Value>
</Value>
<Value name="9">
<Value>type</Value>
</Value>
<Value name="10">
<Value>status</Value>
</Value>
<Value name="11">
<Value>primaryPhone</Value>
</Value>
<Value name="12">
<Value>primaryContact</Value>
</Value>
<Value name="13">
<Value>url</Value>
</Value>
<Value name="14">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.CustomerD</DataLocation>
<DefaultData>CustomerDefaultData</DefaultData>
<IdLocation>^SC.Data.CustomerD</IdLocation>
<IndexLocation>^SC.Data.CustomerI</IndexLocation>
<StreamLocation>^SC.Data.CustomerS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
