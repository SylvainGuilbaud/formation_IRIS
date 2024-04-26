Class Ajusteo.prod.scm Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Ajusteo.prod.scm" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Données sécurité" Category="sécurité" ClassName="Ajusteo.process.security" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Classes" Category="sécurité" ClassName="Demo.Loan.FindRateDecisionProcessBPL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Mise à jour Articles" Category="sécurité" ClassName="Ajusteo.process.majArticle" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Factures - OD - stock - MO - provisions" Category="sécurité" ClassName="Demo.Loan.FindRateDecisionProcessBPL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Articles - équivalences - OF - Commandes" Category="sécurité" ClassName="Demo.Loan.FindRateDecisionProcessBPL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Mouvements stock" Category="sécurité" ClassName="Demo.Loan.FindRateDecisionProcessBPL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Caract. Résultats DA" Category="sécurité" ClassName="Demo.Loan.FindRateDecisionProcessBPL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Articles OF - DA" Category="sécurité" ClassName="Demo.Loan.FindRateDecisionProcessBPL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Résultats" Category="sécurité" ClassName="Demo.Loan.FindRateDecisionProcessBPL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Enlèvements - chargements" Category="sécurité" ClassName="Demo.Loan.FindRateDecisionProcessBPL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Expéditions" Category="sécurité" ClassName="Demo.Loan.FindRateDecisionProcessBPL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="NEWMAINT GMAO" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">Factures - OD - stock - MO - provisions</Setting>
  </Item>
  <Item Name="Logiciel Étiquetage" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">Données sécurité</Setting>
  </Item>
  <Item Name="Logiciel Spécifique" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Logiciel Traitement des Pièces" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="LIMS" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ERP SAP" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Interf. ARTICLE" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">Données sécurité,Mise à jour Articles</Setting>
  </Item>
  <Item Name="WMS" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">Mouvements stock</Setting>
  </Item>
  <Item Name="Logiciel Transport" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Logiciel Douane" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="vers WMS" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="vers Interf. ARTICLE" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
