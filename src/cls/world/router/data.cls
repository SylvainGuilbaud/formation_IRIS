/// 
Class world.router.data Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.RoutingEngine" production="world.prod">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="">
<constraint name="source" value="from world-data EUROPE SQL"></constraint>
<when condition="1" comment="">
<send transform="world.transfo.data" target="to JSON FILE"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
