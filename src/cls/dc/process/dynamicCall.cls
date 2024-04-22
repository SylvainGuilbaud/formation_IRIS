/// Description
Class dc.process.dynamicCall Extends Ens.BusinessProcessBPL
{

Property TargetConfigName As Ens.DataType.ConfigName;

Parameter SETTINGS = "TargetConfigName:Basic";

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='450' >
<call name='Call configurable target' target='@process.TargetConfigName' async='1' xpos='200' ypos='250' >
<request type='Ens.Request' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Ens.Response' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait' calls='Call configurable target' type='all' xpos='200' ypos='350' />
</sequence>
</process>
}

Storage Default
{
<Data name="dynamicCallDefaultData">
<Subscript>"dynamicCall"</Subscript>
<Value name="1">
<Value>TargetConfigName</Value>
</Value>
</Data>
<DefaultData>dynamicCallDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
