/// 
Class EDIFACT.process.IFTDGN.InterChangeToDocuments Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='EnsLib.EDI.EDIFACT.Document' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='InterChangeStart' type='%String' initialexpression='"UNB"' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='InterChangeStop' type='%String' initialexpression='"UNZ"' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='DocumentHeader' type='%String' initialexpression='"UNH+"' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='RawContent' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='' />
</parameters>
</property>
<property name='key' type='%Integer' initialexpression='1' instantiate='0' />
<property name='content' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='' />
</parameters>
</property>
<property name='document' type='EnsLib.EDI.EDIFACT.Document' instantiate='0' />
<property name='documents' type='EDIFACT.msg.array' instantiate='0' />
<property name='hasDocuments' type='%Boolean' initialexpression='1' instantiate='0' />
</context>
<sequence xend='200' yend='650' >
<assign name="RawContent" property="context.RawContent" value="$piece($piece(request.RawContent,request.FindSegment(context.InterChangeStart).OutputToString(),2),context.InterChangeStop)" action="set" xpos='200' ypos='250' />
<trace name='RawContent' value='context.RawContent' xpos='200' ypos='350' />
<while name='documents' condition='context.hasDocuments' xpos='200' ypos='450' xend='200' yend='1100' >
<assign name="content=&quot;&quot;" property="context.content" value="&quot;&quot;" action="set" xpos='200' ypos='250' />
<assign name="key" property="context.key" value="context.key+1" action="set" xpos='200' ypos='350' />
<assign name="content" property="context.content" value="context.DocumentHeader_$piece(context.RawContent,context.DocumentHeader,context.key)_&quot; &quot;" action="set" xpos='200' ypos='450' />
<if name='has Document ?' condition='$length(context.content)&lt;10' xpos='200' ypos='550' xend='200' yend='1000' >
<true>
<assign name="no more documents" property="context.hasDocuments" value="0" action="set" xpos='200' ypos='700' />
</true>
<false>
<trace name='content' value='"CONTENT:"_context.content' xpos='470' ypos='700' />
<assign name="document" property="context.document" value="##class(EnsLib.EDI.EDIFACT.Document).ImportFromString(context.content)" action="set" xpos='470' ypos='800' />
<assign name="documents" property="context.documents.documents" value="context.document" action="set" key="context.key-1" xpos='470' ypos='900' />
<call name='send EDIFACT out' target='EDIFACT IFTDGN out' async='1' xpos='720' ypos='1007' >
<request type='EnsLib.EDI.EDIFACT.Document' >
<assign property="callrequest" value="context.document" action="set" />
</request>
<response type='Ens.Response' />
</call>
</false>
</if>
</while>
<trace name='nb documents' value='context.documents.documents.Count()_" documents"' xpos='200' ypos='550' />
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
