/*
Copyright (c) 2022-2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Tasks.PredictSupplyShipmentLateArrival Extends %SYS.Task.Definition
{

Parameter TaskName = "PredictedTimeOfArrival";

Method OnTask() As %Status
{
    return $$$ERROR("SupplyShipTimeModel not yet supported")
	#; &sql(UPDATE SC_Data.SupplyShipment SET predictedTimeOfArrival=DATEADD('day',PREDICT(SupplyShipTimeModel),actualShipDate) WHERE predictedTimeOfArrival is NULL)
    #; if SQLCODE<0 quit $$$ERROR($$$SQLError, SQLCODE, $g(%msg))
    #; return $$$OK
}

}
