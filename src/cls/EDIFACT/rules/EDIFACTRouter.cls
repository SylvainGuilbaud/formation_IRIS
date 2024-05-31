/// 
Class EDIFACT.rules.EDIFACTRouter Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.VDocRuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.VDocRoutingEngine" production="EDIFACT.prod.production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="" disabled="false">
<constraint name="source" value="EDIFACT IFTDGN in"></constraint>
<constraint name="msgClass" value="EnsLib.EDI.EDIFACT.Document"></constraint>
<constraint name="docCategory" value="D01B"></constraint>
<constraint name="docName" value="IFTDGN,Interchange"></constraint>
<when condition="1" comment="">
<send transform="" target="EDIFACT IFTDGN out"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
