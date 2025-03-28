/// This class is generated by the world.process BPL class.
/// This class should not be edited or modified in any way.
/// Do not make direct use of this class in your application.
Class world.process.Thread1 Extends Ens.BP.Thread [ ClassType = persistent, CompileAfter = world.process, GeneratedBy = Ens.BPL.Compiler.CLS, ProcedureBlock ]
{

Method S1(process As Ens.BusinessProcess, context As Ens.BP.Context, synctimedout As %Boolean, syncresponses As %ArrayOfObjects(ELEMENTTYPE="%Library.Persistent"), request As %Library.Persistent, response As %Library.Persistent) As %Status [ Language = objectscript, PublicList = (process, context) ]
{
 Set $ZT="Trap",status=$$$OK do {
 &SQL(
SELECT 
top 1 Country, DensityPKm2, Abbreviation, AgriculturalLand
INTO :response.Country,:response.DensityPKm2, :response.Abbreviation, :response.AgriculturalLand
FROM world_RM.Record
 )
 #; --- Begin Call to JSON ---
 #; --- Begin Request ---
 Set callrequest=##class(world.data).%New()
 If '$IsObject(callrequest) Set status=%objlasterror Quit
 Set status=$$$OK,callrequest=response
 If $$$ISERR(status) Quit
 Set status=..MakeAsyncCall("","to JSON FILE",callrequest,"to JSON",0,0,"to JSON",0)
 If $$$ISERR(status) Quit
 Kill callrequest
 #; --- End Request ---
 #; --- End Call to JSON ---
 Do process.ClearAllPendingResponses()
 Set ..%NextState="Stop"
 } while (0)
Exit Quit ..ManageState(status)
Trap Set $ZT="",status=..ManageStatus(status,"S1") Goto Exit
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
