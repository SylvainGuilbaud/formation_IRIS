/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.Milestone Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// name
Property name As %String(MAXLEN = 128);

/// milestone number
Property milestoneNumber As %Integer;

/// description
Property description As %String(MAXLEN = 512);

/// associated object
Property associatedObjectType As %String(MAXLEN = 128);

/// associated object ID
Property associatedObjectId As %String(MAXLEN = 256);

// Remove the following foreign key, as this can be an ID of any object in our cuspply chain data model

// ForeignKey associatedObjectIdFK(associatedObjectId) References SC.Core.Data.SalesOrder(uidIndex);

/// milestoneOwner
Property milestoneOwner As %String(MAXLEN = 128);

/// notes
Property notes As %String(MAXLEN = 512);

/// planned start date
Property plannedStartDate As %DateTime;

/// planned end date
Property plannedEndDate As %DateTime;

/// actual start date
Property actualStartDate As %DateTime;

/// actual end date
Property actualEndDate As %DateTime;

/// status
Property status As %String(MAXLEN = 128);

/// primary location
Property milestoneLocationId As %String(MAXLEN = 256);

ForeignKey milestoneLocationIdFK(milestoneLocationId) References SC.Data.Location(uidIndex) [ NoCheck ];

Index milestoneLocationIdIndex On milestoneLocationId;

}
