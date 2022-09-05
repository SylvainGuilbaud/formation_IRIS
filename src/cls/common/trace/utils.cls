Class common.trace.utils [ Abstract ]
{

/// Nom du CUBE à reconstruire
Parameter cubeName = "trace";

/// This callback method is invoked by the <METHOD>%Save</METHOD> method to 
/// provide notification that the object is being saved. It is called after 
/// the object's data has been successfully written to disk.
/// 
/// <P><VAR>insert</VAR> will be set to 1 if this object is being saved for the first time.
/// 
/// <P>If this method returns an error then the call to <METHOD>%Save</METHOD> will fail.
Method %OnAfterSave(insert As %Boolean) As %Status [ Private, ServerOnly = 1 ]
{
	if ##class(%Dictionary.ClassDefinition).%ExistsId("%DeepSee.Utils") {
		do ##class(%DeepSee.Utils).%ProcessFact(..#cubeName,..%Id())
	}
	Quit $$$OK
}

/// This callback method is invoked by the <METHOD>%Delete</METHOD> method to 
/// provide notification that the object specified by <VAR>oid</VAR> has been deleted.
/// The callback occurs immediately after %DeleteData has been called. If %DeleteData returns
/// an error then %OnAfterDelete is not called.
/// 
/// <P>If %OnAfterDelete returns an error (%Status) then the transaction is rolled back.
ClassMethod %OnAfterDelete(oid As %ObjectIdentity) As %Status [ Private, ServerOnly = 1 ]
{
	if ##class(%Dictionary.ClassDefinition).%ExistsId("%DeepSee.Utils") {
		do ##class(%DeepSee.Utils).%DeleteFact(..#cubeName,oid)
	}
	Quit $$$OK
}

Trigger AfterDeleteTrigger [ Event = DELETE, Time = AFTER ]
{
	if ##class(%Dictionary.ClassDefinition).%ExistsId("%DeepSee.Utils") {
		do ##class(%DeepSee.Utils).%DeleteFact(..#cubeName,{ID})
	}
}

Trigger AfterInsertTrigger [ Event = INSERT, Time = AFTER ]
{
	if ##class(%Dictionary.ClassDefinition).%ExistsId("%DeepSee.Utils") {
		do ##class(%DeepSee.Utils).%ProcessFact(..#cubeName,{ID})
	}
}

Trigger AfterUpdateTrigger [ Event = UPDATE, Time = AFTER ]
{
	if ##class(%Dictionary.ClassDefinition).%ExistsId("%DeepSee.Utils") {
		do ##class(%DeepSee.Utils).%ProcessFact(..#cubeName,{ID})
	}
}

/*
Parameter ROWLEVELSECURITY = 1;

ClassMethod %SecurityPolicy(ZoneClesSociete As %String) As %String [ SqlProc ]
{
	set roles=""
	if $roles [ "%All" {
		set roles="%All"
	} 
	set roles=roles_","_ZoneClesSociete
	
    QUIT roles
}
*/
ClassMethod init(pInput As %Library.AbstractStream, Output pOutput As %Stream.Object) As %Status
{
	set status = $$$OK
	set tProxy = []
	
	try{
		set start=$zh
		set daysToKeep=0,keepIntegrity=0,bodiesToo=1,deleted=0
		set sc=##class(Ens.Purge).PurgeAll(.deleted,daysToKeep,keepIntegrity,bodiesToo)
		set tProxy.BitmapChunks=$g(deleted("Bitmap Chunks"))_" deleted"
		set tProxy.BusinessProcesses=$g(deleted("Business Processes"))_" deleted"
		set tProxy.BusinessRuleLogs=$g(deleted("Business Rule Logs"))_" deleted"
		set tProxy.EnsembleMessages=$g(deleted("Ensemble Messages"))_" deleted"
		set tProxy.EventLogs=$g(deleted("Event Logs"))_" deleted"
		set tProxy.HostMonitorData=$g(deleted("Host Monitor Data"))_" deleted"
		set tProxy.IOLogs=$g(deleted("I/O Logs"))_" deleted"
		set tProxy.ManagedAlerts=$g(deleted("Managed Alerts"))_" deleted"
		set tProxy.MessageBodies=$g(deleted("Message Bodies"))_" deleted"
		set:'sc tProxy.status = $system.Status.GetErrorText(sc)
		set tProxy.purge=deleted_" deleted"
		&sql(delete from agl_msg.orderconfirmation) 
		set tProxy.AglMsgOrderConfirmation=%ROWCOUNT_" deleted"
		&sql(delete FROM EnsLib_Workflow.Worklist) 
		set tProxy.EnsLibWorkflowWorklist=%ROWCOUNT_" deleted"
		&sql(delete FROM EnsLib_Workflow.TaskRequest) 
		set tProxy.EnsLibWorkflowTaskRequest=%ROWCOUNT_" deleted"
		&sql(delete FROM EnsLib_Workflow.TaskResponse) 
		set tProxy.EnsLibWorkflowTaskResponse=%ROWCOUNT_" deleted"
		set sc=##class(%DeepSee.Utils).%BuildCube("AGLCommandes",0,0)
		set:sc tProxy.AGLCommandes="cube rebuilt successfully"
		set tProxy.elapse=$num($zh-start,2)_" seconds"
		set JSON=tProxy.%ToJSON()
		do pOutput.Write(JSON)
		
	} catch (e) {
		set status = e.AsStatus()
		set tProxy.error = $system.Status.GetErrorText(status)_"("_$system.Status.GetErrorCodes(status)_")"
	}
	set sc=##class(%ZEN.Auxiliary.jsonProvider).%WriteJSONStreamFromObject(.pOutput,.tProxy,,,,"iw")
	do pOutput.Clear()
	set JSON=tProxy.%ToJSON()
	for i=1:1:$l(JSON,",") {
		set sc=pOutput.WriteLine($p(JSON,",",i))
	}
	do pOutput.Rewind()
	do:$$$ISOK(sc) pOutput.SetAttribute("Content-Type","application/json")
    quit $$$OK
}

}
