/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is represents a leg in a route. It can be a transportation arc, or a leg in a manufacturing
/// process. 
Class SC.Data.RouteLeg Extends SC.Core.Data.RouteLeg
{

Storage Default
{
<Data name="RouteLegDefaultData">
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
<Value>startLocationId</Value>
</Value>
<Value name="5">
<Value>endLocationId</Value>
</Value>
<Value name="6">
<Value>type</Value>
</Value>
<Value name="7">
<Value>mode</Value>
</Value>
<Value name="8">
<Value>status</Value>
</Value>
<Value name="9">
<Value>route</Value>
</Value>
<Value name="10">
<Value>network</Value>
</Value>
<Value name="11">
<Value>leadTime</Value>
</Value>
<Value name="12">
<Value>leadTimeUom</Value>
</Value>
<Value name="13">
<Value>cost</Value>
</Value>
<Value name="14">
<Value>costCurrency</Value>
</Value>
<Value name="15">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.RouteLegD</DataLocation>
<DefaultData>RouteLegDefaultData</DefaultData>
<IdLocation>^SC.Data.RouteLegD</IdLocation>
<IndexLocation>^SC.Data.RouteLegI</IndexLocation>
<StreamLocation>^SC.Data.RouteLegS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
