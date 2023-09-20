Class EP.service.replication Extends Ens.BusinessService
{

Property Adapter As Ens.InboundAdapter;

Parameter ADAPTER = "Ens.InboundAdapter";

Property TargetConfigNames As %String(MAXLEN = 1000);

Property sync As %Boolean [ InitialExpression = 1 ];

Parameter SETTINGS = "sync:Advanced,TargetConfigNames:Basic:selector?multiSelect=1&context={Ens.ContextSearch/ProductionItems?targets=1&productionName=@productionId}";

Method OnProcessInput(pInput As %RegisteredObject, Output pResponse As Ens.StringResponse) As %Status
{
  set tSC = $$$OK
  for iTarget=1:1:$L(..TargetConfigNames, ",") {
        set tOneTarget=$ZStrip($P(..TargetConfigNames,",",iTarget),"<>W")  Continue:""=tOneTarget
        $$$TRACE("The target '"_tOneTarget_"' will be called "_$SELECT(..sync=1:"synchronously",..sync=0:"synchronously"))
        if ..sync {
          set tSC1=..SendRequestSync(tOneTarget,pInput,.pResponse)  Set:$$$ISERR(tSC1) tSC=$$$ADDSC(tSC,tSC1)
        } else {
          set tSC1=..SendRequestAsync(tOneTarget,pInput)  Set:$$$ISERR(tSC1) tSC=$$$ADDSC(tSC,tSC1)
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
