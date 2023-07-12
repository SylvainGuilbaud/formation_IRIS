/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.DemandPlan Extends SC.Core.Data.Plan [ Abstract, NoExtent ]
{

Property DailyDemand As %Numeric [ Calculated, SqlComputeCode = {SET {DailyDemand} = $Case(+{timeFrameDays},0:"",:{quantity}/{timeFrameDays})}, SqlComputed ];

}
