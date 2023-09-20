Class EP.service.replication Extends Ens.BusinessService
{

Property Adapter As Ens.InboundAdapter;

Parameter ADAPTER = "Ens.InboundAdapter";

Property sync As %Boolean [ InitialExpression = 1 ];

Property Server As %String [ InitialExpression = "host.docker.internal" ];

Property Port As %Integer [ InitialExpression = 12773 ];

Property TargetConfigNames As %String(MAXLEN = 1000);

Parameter SETTINGS = "TargetConfigNames:Basic:selector?multiSelect=1&context={Ens.ContextSearch/ProductionItems?targets=1&productionName=@productionId},Server:target,Port:target,sync:target";

Method OnProcessInput(pInput As %RegisteredObject, Output pResponse As Ens.StringResponse) As %Status
{
    set tSC                      = $$$OK
    set pResponse                = ##class(Ens.StringResponse).%New()
    set tHttpRequest             = ##class(%Net.HttpRequest).%New()
    set pContainer               = ##class(Ens.StreamContainer).%New()
    set stream                   = ##class(%Stream.GlobalCharacter).%New()
    set tHttpRequest.Server      = ..Server
    set tHttpRequest.Port        = ..Port
    set location                 = "/common/list/data.client/json"

    set tHttpRequest.ContentType   ="application/json"

    set tSC = tHttpRequest.Get(location)
    if 'tSC {
      $$$TRACE("tSC :"_$system.Status.GetErrorText(tSC))
    }
  
   // set pContainer.Stream        = tHttpRequest.HttpResponse.Data
   // do pContainer.CopyFrom(tHttpRequest.HttpResponse.Data)
   if $ISOBJECT(tHttpRequest.HttpResponse) {
    $$$TRACE("tHttpRequest.HttpResponse.Data :"_tHttpRequest.HttpResponse.Data)
    Set jsonObject               = [].%FromJSON(tHttpRequest.HttpResponse.Data)
    Do jsonObject.%ToJSON(.stream)
    #; Do ##class(%JSON.Formatter).%New().Format(jsonObject)

    set pContainer.Stream = stream
    $$$TRACE("stream size:"_stream.Size)
    $$$TRACE("stream :"_stream.Read())

      for iTarget=1:1:$L(..TargetConfigNames, ",") {
            set tOneTarget=$ZStrip($P(..TargetConfigNames,",",iTarget),"<>W")  Continue:""=tOneTarget
            $$$TRACE("The target '"_tOneTarget_"' will be called "_$SELECT(..sync=1:"synchronously",..sync=0:"synchronously"))
            
            set tSC1=..SendRequestSync(tOneTarget,pContainer,.pResponse)  Set:$$$ISERR(tSC1) tSC=$$$ADDSC(tSC,tSC1)
        }
   } else { 
      set pResponse.StringValue = "aucune donnée retournée par http://" _ ..Server _ ":" _ ..Port _ location
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
