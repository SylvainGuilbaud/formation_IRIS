/// 
Class formation.rules.personnes Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.RoutingEngine" production="formation.prod.production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="fichiers locaux ou FTP" disabled="false">
<constraint name="msgClass" value="formation.RM.personne.Record"></constraint>
<when condition="1">
<send transform="formation.transfo.personne" target="to personne SQL"></send>
<return></return>
</when>
</rule>
<rule name="fichiers locaux BATCH" disabled="false">
<constraint name="source" value="from personnes BATCH"></constraint>
<constraint name="msgClass" value="formation.RM.personne.Batch"></constraint>
<when condition="1">
<send transform="formation.transfo.personneBatch" target="to personne SQL"></send>
<return></return>
</when>
</rule>
<rule name="fichiers locaux BATCH" disabled="false">
<constraint name="source" value="from personnes BATCH"></constraint>
<constraint name="msgClass" value="formation.RM.personne.Batch"></constraint>
<when condition="1">
<send transform="formation.transfo.personneBatch" target="to personne SQL"></send>
<return></return>
</when>
</rule>
<rule name="fichiers FTP BATCH" disabled="false">
<constraint name="source" value="from personnes FTP BATCH"></constraint>
<constraint name="msgClass" value="formation.RM.personne.Batch"></constraint>
<when condition="1">
<send transform="formation.transfo.personneBatch" target="to personne SQL"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
