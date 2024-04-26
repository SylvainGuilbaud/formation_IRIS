/// 
Class Ajusteo.process.majArticle Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='python' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='700' >
<call name='Données sécurité' target='Données sécurité' async='1' xpos='200' ypos='250' >
<request type='data.RM.customer.Record' />
</call>
<flow xpos='200' ypos='350' xend='200' yend='600' >
<sequence >
<call name='Logiciel Transport' target='Logiciel Transport' async='0' xpos='200' ypos='500' >
<request type='data.RM.customer.Record' />
</call>
</sequence>
<sequence name='vers WMS' >
<call name='WMS' target='vers WMS' async='0' xpos='470' ypos='500' >
<request type='data.RM.customer.Record' />
</call>
</sequence>
<sequence >
<call name='SAP' target='ERP SAP' async='0' xpos='740' ypos='500' >
<request type='data.RM.customer.Record' />
</call>
</sequence>
</flow>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
