/// 
Class EP.process.replication Extends Ens.BusinessProcessBPL
{

Property Server As %String [ InitialExpression = "host.docker.internal" ];

Property Port As %Integer [ InitialExpression = 12773 ];

Property classname As %String [ InitialExpression = "data.client" ];

Parameter SETTINGS = "Server:target,Port:target,classname:target";

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

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.StreamContainer' response='Ens.StringContainer' height='2000' width='2000' >
<context>
<property name='pContainer' type='Ens.StreamContainer' instantiate='0' />
<property name='array' type='%Iterator.Array' instantiate='0' />
<property name='replicationResult' type='Ens.StringContainer' instantiate='0' />
<property name='json' type='%Library.DynamicArray' instantiate='0' />
<property name='key' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='value' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='' />
</parameters>
</property>
</context>
<sequence xend='200' yend='550' >
<code name='replication' xpos='200' ypos='250' >
<![CDATA[    
    set tHttpRequest             = ##class(%Net.HttpRequest).%New()
    set stream                   = ##class(%Stream.GlobalCharacter).%New()
    set tHttpRequest.Server      = process.Server
    set tHttpRequest.Port        = process.Port
    set location                 = "/common/list/data.client/json"

    set tHttpRequest.ContentType   ="application/json"

    set tSC = tHttpRequest.Get(location)
  
   if $ISOBJECT(tHttpRequest.HttpResponse) {
    Set jsonObject               = [].%FromJSON(tHttpRequest.HttpResponse.Data)
    Do jsonObject.%ToJSON(.stream)
    set context.pContainer.Stream = stream
   }]]>
</code>
<call name='replication' target='EP.operation.replication' async='0' xpos='200' ypos='350' >
<request type='Ens.StreamContainer' >
<assign property="callrequest" value="context.pContainer" action="set" />
</request>
<response type='Ens.StringContainer' >
<assign property="context.replicationResult" value="callresponse" action="set" />
</response>
</call>
<assign name="response" property="response.StringValue" value="request.Stream.Read(1000)_&quot;:&quot;_key" action="set" xpos='200' ypos='450' />
</sequence>
</process>
}

}
