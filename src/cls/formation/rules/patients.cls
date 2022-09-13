/// 
Class formation.rules.patients Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.RoutingEngine" production="formation.prod.production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="" disabled="false">
<constraint name="source" value="from Patients CSV Batch"></constraint>
<constraint name="msgClass" value="formation.RM.patient.Batch"></constraint>
<when condition="1">
<send transform="formation.transfo.patientBatch" target="to patient SQL"></send>
<return></return>
</when>
</rule>
<send transform="formation.transfo.patient" target="to patient SQL"></send>
</ruleSet>
</ruleDefinition>
}

}
