/// This class is generated by the EDIFACT.process.IFTDGN.InterChangeToDocuments BPL class.
/// This class should not be edited or modified in any way.
/// Do not make direct use of this class in your application.
Class EDIFACT.process.IFTDGN.InterChangeToDocuments.Thread1 Extends Ens.BP.Thread [ ClassType = persistent, CompileAfter = EDIFACT.process.IFTDGN.InterChangeToDocuments, GeneratedBy = Ens.BPL.Compiler.CLS, ProcedureBlock ]
{

Method S1(process As Ens.BusinessProcess, context As Ens.BP.Context, synctimedout As %Boolean, syncresponses As %ArrayOfObjects(ELEMENTTYPE="%Library.Persistent"), request As %Library.Persistent, response As %Library.Persistent) As %Status [ Language = objectscript, PublicList = (process, context) ]
{
 Set $ZT="Trap",status=$$$OK do {
 Set status=$$$OK,context.RawContent=$piece($piece(request.RawContent,request.FindSegment(context.InterChangeStart).OutputToString(),2),context.InterChangeStop)
 If $$$ISERR(status) Quit
 Do ##class(Ens.Util.Trace).WriteTrace("user","EDIFACT.process.IFTDGN.InterChangeToDocuments","S1",context.RawContent)
 Set ..%NextState="S2"
 } while (0)
Exit Quit ..ManageState(status)
Trap Set $ZT="",status=..ManageStatus(status,"S1") Goto Exit
}

Method S2(process As Ens.BusinessProcess, context As Ens.BP.Context, synctimedout As %Boolean, syncresponses As %ArrayOfObjects(ELEMENTTYPE="%Library.Persistent"), request As %Library.Persistent, response As %Library.Persistent) As %Status [ Language = objectscript, PublicList = (process, context) ]
{
 Set $ZT="Trap",status=$$$OK do {
 If (context.hasDocuments) {
  Set ..%NextState="S4"
 } else {
  Set ..%NextState="S3"
 }
 } while (0)
Exit Quit ..ManageState(status)
Trap Set $ZT="",status=..ManageStatus(status,"S2") Goto Exit
}

Method S3(process As Ens.BusinessProcess, context As Ens.BP.Context, synctimedout As %Boolean, syncresponses As %ArrayOfObjects(ELEMENTTYPE="%Library.Persistent"), request As %Library.Persistent, response As %Library.Persistent) As %Status [ Language = objectscript, PublicList = (process, context) ]
{
 Set $ZT="Trap",status=$$$OK do {
 Do ##class(Ens.Util.Trace).WriteTrace("user","EDIFACT.process.IFTDGN.InterChangeToDocuments","S3",context.documents.documents.Count()_" documents")
 Do process.ClearAllPendingResponses()
 Set ..%NextState="Stop"
 } while (0)
Exit Quit ..ManageState(status)
Trap Set $ZT="",status=..ManageStatus(status,"S3") Goto Exit
}

Method S4(process As Ens.BusinessProcess, context As Ens.BP.Context, synctimedout As %Boolean, syncresponses As %ArrayOfObjects(ELEMENTTYPE="%Library.Persistent"), request As %Library.Persistent, response As %Library.Persistent) As %Status [ Language = objectscript, PublicList = (process, context) ]
{
 Set $ZT="Trap",status=$$$OK do {
 Set status=$$$OK,context.content=""
 If $$$ISERR(status) Quit
 Set status=$$$OK,context.key=context.key+1
 If $$$ISERR(status) Quit
 Set status=$$$OK,context.content=context.DocumentHeader_$piece(context.RawContent,context.DocumentHeader,context.key)_" "
 If $$$ISERR(status) Quit
 If ($length(context.content)<10) {
 Set ..%NextState="S6"
 } else {
 Set ..%NextState="S7"
 }
 } while (0)
Exit Quit ..ManageState(status)
Trap Set $ZT="",status=..ManageStatus(status,"S4") Goto Exit
}

Method S5(process As Ens.BusinessProcess, context As Ens.BP.Context, synctimedout As %Boolean, syncresponses As %ArrayOfObjects(ELEMENTTYPE="%Library.Persistent"), request As %Library.Persistent, response As %Library.Persistent) As %Status [ Language = objectscript, PublicList = (process, context) ]
{
 Set $ZT="Trap",status=$$$OK do {
 Set ..%NextState="S2"
 } while (0)
Exit Quit ..ManageState(status)
Trap Set $ZT="",status=..ManageStatus(status,"S5") Goto Exit
}

Method S6(process As Ens.BusinessProcess, context As Ens.BP.Context, synctimedout As %Boolean, syncresponses As %ArrayOfObjects(ELEMENTTYPE="%Library.Persistent"), request As %Library.Persistent, response As %Library.Persistent) As %Status [ Language = objectscript, PublicList = (process, context) ]
{
 Set $ZT="Trap",status=$$$OK do {
 Set status=$$$OK,context.hasDocuments=0
 If $$$ISERR(status) Quit
 Set ..%NextState="S5"
 } while (0)
Exit Quit ..ManageState(status)
Trap Set $ZT="",status=..ManageStatus(status,"S6") Goto Exit
}

Method S7(process As Ens.BusinessProcess, context As Ens.BP.Context, synctimedout As %Boolean, syncresponses As %ArrayOfObjects(ELEMENTTYPE="%Library.Persistent"), request As %Library.Persistent, response As %Library.Persistent) As %Status [ Language = objectscript, PublicList = (process, context) ]
{
 Set $ZT="Trap",status=$$$OK do {
 Do ##class(Ens.Util.Trace).WriteTrace("user","EDIFACT.process.IFTDGN.InterChangeToDocuments","S7","CONTENT:"_context.content)
 Set status=$$$OK,context.document=##class(EnsLib.EDI.EDIFACT.Document).ImportFromString(context.content)
 If $$$ISERR(status) Quit
 Do ##class(Ens.DataTransform).instantiateProps(context,"context.documents.documents")
 Set status=context.documents.documents.SetAt(context.document,context.key-1)
 If $$$ISERR(status) Quit
 #; --- Begin Call send EDIFACT out ---
 #; --- Begin Request ---
 Set callrequest=##class(EnsLib.EDI.EDIFACT.Document).%New()
 If '$IsObject(callrequest) Set status=%objlasterror Quit
 Set status=$$$OK,callrequest=context.document
 If $$$ISERR(status) Quit
 Set status=..MakeAsyncCall("","EDIFACT IFTDGN out",callrequest,"send EDIFACT out",1,0,"send EDIFACT out",0)
 If $$$ISERR(status) Quit
 Kill callrequest
 #; --- End Request ---
 #; --- End Call send EDIFACT out ---
 Set ..%NextState="S5"
 } while (0)
Exit Quit ..ManageState(status)
Trap Set $ZT="",status=..ManageStatus(status,"S7") Goto Exit
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
