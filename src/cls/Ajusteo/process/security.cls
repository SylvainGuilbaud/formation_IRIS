/// 
Class Ajusteo.process.security Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='377' >
<call name='LIMS' target='LIMS' async='1' xpos='291' ypos='254' >
<request type='data.RM.customer.Record' />
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
