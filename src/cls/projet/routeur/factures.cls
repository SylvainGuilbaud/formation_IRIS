/// 
Class projet.routeur.factures Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.RoutingEngine" production="formation.prod.personne">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<send transform="projet.transform.factures" target=",cibles factures"></send>
</ruleSet>
</ruleDefinition>
}

}
