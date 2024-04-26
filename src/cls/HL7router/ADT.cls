/// 
Class HL7router.ADT Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.HL7.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.HL7.MsgRouter.RoutingEngine" production="Demo.HL7.MsgRouter.Production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="remove sensitive data">
<constraint name="source" value="ADTService"></constraint>
<constraint name="docCategory" value="2.3.1"></constraint>
<constraint name="docName" value="ADT_A01,ADT_A02,ADT_A03,ADT_A04,ADT_A05,ADT_A06,ADT_A07,ADT_A08"></constraint>
<when condition="1" comment="">
<send transform="HL7.tranfo.ADT" target=",ADT_A08_FileOperation"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
