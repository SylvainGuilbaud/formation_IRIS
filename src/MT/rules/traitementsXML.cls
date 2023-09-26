/// Ceci est une description
/// <?xml version="1.0" encoding="iso-8859-1"?>
/// <File>
///    </client>
/// 
/// </File>
Class MT.rules.traitementsXML Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.RoutingEngine" production="formation.prod.personne" Description="hhhhh">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="MT file XML">
<constraint name="source" value="from MT XML structure File"></constraint>
<when condition="1" comment="">
<send transform="" target="to personne SQL"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
