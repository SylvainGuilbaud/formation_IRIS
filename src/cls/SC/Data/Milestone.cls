/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to track milestones related to a process, a transaction, or something else.
/// Example milestones can be shipment milestones, order fulfillment milestones, manufacturing order milestones, etc.
/// A milestone record typically has some target datetime values, and tracked by actual datetime values.  
Class SC.Data.Milestone Extends SC.Core.Data.Milestone
{

Storage Default
{
<Data name="MilestoneDefaultData">
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
<Value>milestoneNumber</Value>
</Value>
<Value name="6">
<Value>description</Value>
</Value>
<Value name="7">
<Value>associatedObjectType</Value>
</Value>
<Value name="8">
<Value>associatedObjectId</Value>
</Value>
<Value name="9">
<Value>milestoneOwner</Value>
</Value>
<Value name="10">
<Value>notes</Value>
</Value>
<Value name="11">
<Value>plannedStartDate</Value>
</Value>
<Value name="12">
<Value>plannedEndDate</Value>
</Value>
<Value name="13">
<Value>actualStartDate</Value>
</Value>
<Value name="14">
<Value>actualEndDate</Value>
</Value>
<Value name="15">
<Value>status</Value>
</Value>
<Value name="16">
<Value>milestoneLocationId</Value>
</Value>
<Value name="17">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.MilestoneD</DataLocation>
<DefaultData>MilestoneDefaultData</DefaultData>
<IdLocation>^SC.Data.MilestoneD</IdLocation>
<IndexLocation>^SC.Data.MilestoneI</IndexLocation>
<StreamLocation>^SC.Data.MilestoneS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
