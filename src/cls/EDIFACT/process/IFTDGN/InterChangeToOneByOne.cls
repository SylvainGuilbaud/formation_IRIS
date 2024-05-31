/// 
Class EDIFACT.process.IFTDGN.InterChangeToOneByOne Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='EnsLib.EDI.EDIFACT.Document' response='EDIFACT.msg.array' height='2000' width='2000' >
<context>
<property name='document' type='EnsLib.EDI.EDIFACT.Document' instantiate='0' />
<property name='moreDocuments' type='%Boolean' initialexpression='1' instantiate='0' />
<property name='UNBS0002' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='msg' type='EDIFACT.msg.transformed' instantiate='0' />
<property name='key' type='%Integer' initialexpression='0' instantiate='0' />
</context>
<sequence xend='200' yend='650' >
<assign name="UNBS0002" property="context.UNBS0002" value="request.GetValueAt(&quot;UNB-1:S002(1).0004&quot;)" action="set" xpos='200' ypos='250' >
<annotation><![CDATA[store value from UNB segment]]></annotation>
</assign>
<assign name="document=&quot;&quot;" property="context.document" value="&quot;&quot;" action="set" xpos='200' ypos='350' />
<while name='documents' condition='context.moreDocuments' xpos='200' ypos='450' xend='200' yend='1350' >
<annotation>parse children EDIFACT documents</annotation>
<assign name="document" property="context.document" value="request.NextChild(context.document)" action="set" xpos='200' ypos='250' />
<if name='document ?' condition='context.document=""' xpos='200' ypos='350' xend='200' yend='1250' >
<true>
<assign name="no more documents" property="context.moreDocuments" value="0" action="set" xpos='200' ypos='500' />
</true>
<false>
<trace name='content' value='context.document.RawContent' xpos='470' ypos='500' />
<assign name="DocType" property="context.document.DocType" value="&quot;IFTDGN_D98B:IFTDGN&quot;" action="set" xpos='470' ypos='600' >
<annotation><![CDATA[IFTDGN_D98B:IFTDGN]]></annotation>
</assign>
<flow xpos='470' ypos='700' xend='470' yend='1150' >
<sequence >
<call name='send EDIFACT out' target='EDIFACT IFTDGN out' async='1' xpos='470' ypos='850' >
<request type='EnsLib.EDI.EDIFACT.Document' >
<assign property="callrequest" value="context.document" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
<sequence >
<transform name='IFTDGNtoMsg' class='EDIFACT.transfo.IFTDGNtoMsg' source='context.document' target='context.msg' xpos='740' ypos='850' />
<assign name="key" property="context.key" value="context.key+1" action="set" xpos='740' ypos='950' />
<assign name="documents array" property="response.documents" value="context.msg" action="set" key="context.key" xpos='740' ypos='1050' />
</sequence>
</flow>
</false>
</if>
</while>
<call name='EDIFACT Router' target='EDIFACTRouter' async='1' xpos='200' ypos='550' >
<request type='Ens.Request' >
<assign property="callrequest" value="response" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
