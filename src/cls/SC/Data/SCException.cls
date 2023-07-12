/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture supply chain exceptions, such as order exceptions, shipment exceptions, etc.. 
Class SC.Data.SCException Extends SC.Core.Data.SCException
{

Storage Default
{
<Data name="SCExceptionDefaultData">
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
<Value>description</Value>
</Value>
<Value name="5">
<Value>type</Value>
</Value>
<Value name="6">
<Value>reason</Value>
</Value>
<Value name="7">
<Value>category</Value>
</Value>
<Value name="8">
<Value>action</Value>
</Value>
<Value name="9">
<Value>actionDetails</Value>
</Value>
<Value name="10">
<Value>associatedObjectType</Value>
</Value>
<Value name="11">
<Value>associatedObjectId</Value>
</Value>
<Value name="12">
<Value>uid</Value>
</Value>
<Value name="13">
<Value>source</Value>
</Value>
</Data>
<DataLocation>^SC.Data.SCExceptionD</DataLocation>
<DefaultData>SCExceptionDefaultData</DefaultData>
<IdLocation>^SC.Data.SCExceptionD</IdLocation>
<IndexLocation>^SC.Data.SCExceptionI</IndexLocation>
<StreamLocation>^SC.Data.SCExceptionS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
