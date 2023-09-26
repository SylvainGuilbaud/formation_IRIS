/// 
Class MT.rules.traitementEDIXML Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.VDocRuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.VDocRoutingEngine" production="formation.prod.personne">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="">
<constraint name="source" value="from MT XML structure File"></constraint>
<constraint name="msgClass" value="EnsLib.EDI.XML.Document"></constraint>
<constraint name="docCategory" value="file"></constraint>
<constraint name="docName" value="File"></constraint>
<when condition="Document.{conf.PrixConf}&gt;=10" comment="">
<send transform="MT.transfo.EDIXMLtoSQLPersonne" target="to personne SQL"></send>
<return></return>
</when>
</rule>
<rule name="" disabled="false">
<constraint name="source" value="from MT FTP"></constraint>
<constraint name="msgClass" value="EnsLib.EDI.XML.Document"></constraint>
<constraint name="docCategory" value="file"></constraint>
<constraint name="docName" value="File"></constraint>
<when condition="Document.{conf.PrixConf}&gt;=10" comment="">
<send transform="MT.transfo.EDIXMLtoSQLPersonne" target="to personne SQL"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
