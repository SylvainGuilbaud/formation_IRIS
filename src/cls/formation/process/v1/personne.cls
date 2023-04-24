/// 
Class formation.process.v1.personne Extends Ens.BusinessProcessBPL
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
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
