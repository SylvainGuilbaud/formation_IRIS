Class common.service.dummy Extends Ens.BusinessService
{

/// Configuration item(s) to which to send file stream messages
Property TargetConfigNames As %String(MAXLEN = 1000);

/// By default messages will be sent asynchronously to the target(s)
Property async As %Boolean [ InitialExpression = 1 ];

Parameter ADAPTER = "Ens.InboundAdapter";

Parameter SETTINGS = "async:Basic,TargetConfigNames:Basic:selector?multiSelect=1&context={Ens.ContextSearch/ProductionItems?targets=1&productionName=@productionId}";

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	set tSC=$$$OK
	for iTarget=1:1:$L(..TargetConfigNames, ",") {
		set tOneTarget=$ZStrip($P(..TargetConfigNames,",",iTarget),"<>W")  Continue:""=tOneTarget
		$$$TRACE("The target '"_tOneTarget_"' will be called "_$SELECT(..async=1:"asynchronously",..async=0:"synchronously"))
		if ..async {
			set tSC1=..SendRequestAsync(tOneTarget,pInput,.pOutput)  Set:$$$ISERR(tSC1) tSC=$$$ADDSC(tSC,tSC1)
		} else {
			set tSC1=..SendRequestSync(tOneTarget,pInput,.pOutput)  Set:$$$ISERR(tSC1) tSC=$$$ADDSC(tSC,tSC1)
		}		
	}
	return tSC
}

/// Return an array of connections for drawing lines on the config diagram
ClassMethod OnGetConnections(Output pArray As %String, pItem As Ens.Config.Item)
{
	Do ##super(.pArray,pItem)
	If pItem.GetModifiedSetting("TargetConfigNames",.tValue) {
		For i=1:1:$L(tValue,",") { Set tOne=$ZStrip($P(tValue,",",i),"<>W")  Continue:""=tOne  Set pArray(tOne)="" }
	}
}

}
