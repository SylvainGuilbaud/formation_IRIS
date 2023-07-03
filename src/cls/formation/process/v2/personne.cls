/// 
Class formation.process.v2.personne Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='formation.RM.personne.Record' response='formation.msg.mysql.response.personne' height='2000' width='2000' >
<context>
<property name='personneSQL' type='formation.msg.mysql.personne' instantiate='0' />
<property name='validation' type='%String' instantiate='0' />
</context>
<sequence xend='200' yend='1000' >
<call name='check gender' target='get gender' async='0' xpos='200' ypos='250' >
<request type='HTTP.msg.genderRequest' >
<assign property="callrequest.firstName" value="request.Prenom" action="set" />
</request>
<response type='HTTP.msg.genderResponse' >
<assign property="request.Sexe" value="callresponse.gender" action="set" />
</response>
</call>
<transform name='transfo gender' class='formation.transfo.gender' source='request' target='request' xpos='200' ypos='350' />
<transform name='RM vers SQL' class='formation.transfo.personne' source='request' target='context.personneSQL' xpos='200' ypos='450' />
<call name='validation' target='validation personne' async='0' xpos='200' ypos='550' >
<request type='EnsLib.Workflow.TaskRequest' >
<assign property="callrequest.%Actions" value="&quot;ok,refus&quot;" action="set" />
<assign property="callrequest.%Subject" value="&quot;Validation &quot;_request.Nom" action="set" />
<assign property="callrequest.%Message" value="request.Prenom_&quot; &quot;_request.Nom" action="set" />
</request>
<response type='EnsLib.Workflow.TaskResponse' >
<assign property="context.validation" value="callresponse.%Action" action="set" />
</response>
</call>
<if name='valide ?' condition='context.validation="ok"' xpos='200' ypos='650' xend='200' yend='900' >
<true>
<call name='MAJ SQL' target='to personne SQL' async='0' xpos='470' ypos='800' >
<request type='formation.msg.mysql.personne' >
<assign property="callrequest" value="context.personneSQL" action="set" />
</request>
<response type='formation.msg.mysql.response.personne' >
<assign property="callresponse" value="response" action="set" />
</response>
</call>
</true>
<false>
<alert name='ALERTE' value='"ALERT"' xpos='200' ypos='800' />
</false>
</if>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
