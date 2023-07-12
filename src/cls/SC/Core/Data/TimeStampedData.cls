/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.TimeStampedData Extends (%Persistent, %JSON.Adaptor) [ Abstract, NoExtent ]
{

/// Record created time
Property recordCreatedTime As %DateTime [ InitialExpression = {$ZDATETIME($ZTIMESTAMP, 3, 1, 3)} ];

/// Time the record last updated
Property lastUpdatedTime As %DateTime [ InitialExpression = {$ZDATETIME($ZTIMESTAMP, 3, 1, 3)} ];

/// Do not allow setting value to recordCreatedTime, unless it has not been set yet.
Method recordCreatedTimeSet(value As %DateTime) As %Status
{
    if i%recordCreatedTime="" {
		set i%recordCreatedTime=value
	}
	quit $$$OK
}

/// Always override the lastUpdatedTime with the current time upon save
Method %OnBeforeSave() As %Status
{
    set i%lastUpdatedTime = $ZDATETIME($ZTIMESTAMP, 3, 1, 3)
    quit $$$OK
}

}
