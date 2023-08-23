/// 
Class world.process Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='world.data' height='2000' width='2000' >
<sequence xend='200' yend='450' >
<sql name='get rows' xpos='200' ypos='250' >
<![CDATA[SELECT 
top 1 Country, DensityPKm2, Abbreviation, AgriculturalLand
INTO :response.Country,:response.DensityPKm2, :response.Abbreviation, :response.AgriculturalLand
FROM world_RM.Record]]>
</sql>
<call name='to JSON' target='to JSON FILE' async='1' xpos='200' ypos='350' >
<request type='world.data' >
<assign property="callrequest" value="response" action="set" />
</request>
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
