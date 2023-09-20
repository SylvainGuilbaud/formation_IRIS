Class EP.process.replication Extends Ens.BusinessProcess [ ClassType = persistent, ProcedureBlock ]
{

Property Server As %String [ InitialExpression = "host.docker.internal" ];

Property Port As %Integer [ InitialExpression = 12773 ];

Property classname As %String [ InitialExpression = "data.client" ];

Parameter SETTINGS = "Server:target,Port:target,classname:target";

Method OnRequest(pRequest As Ens.Request, Output pResponse As Ens.StringContainer) As %Status
{
    set sc = $$$OK
    set tHttpRequest             = ##class(%Net.HttpRequest).%New()
    set pContainer               = ##class(Ens.StreamContainer).%New()
    set stream                   = ##class(%Stream.GlobalCharacter).%New()
    set tHttpRequest.Server      = ..Server
    set tHttpRequest.Port        = ..Port
    set location                 = "/common/list/" _ ..classname _ "/json"

    set tHttpRequest.ContentType   ="application/json"
    
    set tSC = tHttpRequest.Get(location)
  
   if $ISOBJECT(tHttpRequest.HttpResponse) {
    Set jsonObject               = [].%FromJSON(tHttpRequest.HttpResponse.Data)
    Do jsonObject.%ToJSON(.stream)
    set pContainer.Stream = stream

    set sc = ..SendRequestSync("EP.operation.replication",pContainer,.pResponse)
    
   }
   return sc
}

Storage Default
{
<Data name="replicationDefaultData">
<Subscript>"replication"</Subscript>
<Value name="1">
<Value>Server</Value>
</Value>
<Value name="2">
<Value>Port</Value>
</Value>
<Value name="3">
<Value>classname</Value>
</Value>
</Data>
<DefaultData>replicationDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
