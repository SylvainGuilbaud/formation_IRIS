/// 
Class JDBC.demo.routage.clients Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.RoutingEngine" production="JDBC.demo.production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<send transform="data.transfo.ajoutHashtag" target="MAJ clients base externe"></send>
</ruleSet>
</ruleDefinition>
}

}
