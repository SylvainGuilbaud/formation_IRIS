/// 
Class JDBC.demo.process.customers Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='data.RM.customer.Batch' response='Ens.StringResponse' height='2000' width='2000' >
<context>
<property name='customersExternal' type='data.EXTERNAL.customer.Batch' instantiate='0' />
<property name='customer' type='data.EXTERNAL.customer.Record' instantiate='0' />
<property name='i' type='%Integer' instantiate='0' />
<property name='MAJbaseExterne' type='Ens.StringResponse' instantiate='0' />
</context>
<sequence xend='200' yend='650' >
<transform name='ajout hashtag' class='data.transfo.ajoutHashtag' source='request' target='context.customersExternal' xpos='200' ypos='250' />
<foreach name='ajout genre clients ' property='context.customersExternal.records' key='context.i' xpos='200' ypos='350' xend='200' yend='650' >
<trace name='id client' value='context.customersExternal.records.GetAt(context.i).id' xpos='200' ypos='250' />
<assign name="client" property="context.customer" value="context.customersExternal.records.GetAt(context.i)" action="set" xpos='200' ypos='350' />
<call name='recherche le genre' target='get gender' async='0' xpos='200' ypos='450' >
<request type='HTTP.msg.genderRequest' >
<assign property="callrequest.firstName" value="context.customer.firstName" action="set" />
</request>
<response type='HTTP.msg.genderResponse' >
<assign property="context.customer.gender" value="callresponse.gender" action="set" />
</response>
</call>
<code name='ajout genre' xpos='200' ypos='550' >
<![CDATA[ do context.customersExternal.records.SetAt(context.customer,context.i)]]>
</code>
</foreach>
<call name='MAJ clients base externe' target='MAJ clients base externe' async='0' xpos='200' ypos='450' >
<request type='data.EXTERNAL.customer.Batch' >
<assign property="callrequest" value="context.customersExternal" action="set" />
</request>
<response type='Ens.StringResponse' >
<assign property="context.MAJbaseExterne" value="callresponse" action="set" />
</response>
</call>
<assign name="réponse" property="response.StringValue" value="&quot;process successfully executed&quot;" action="set" xpos='200' ypos='550' />
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
