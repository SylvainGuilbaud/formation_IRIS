Class projet.production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="projet.production" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>

    <Item Name="source factures CSV" Category="" ClassName="EnsLib.RecordMap.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="RecordMap">projet.messages.RM.facture</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/data/CSV/archive</Setting>
    <Setting Target="Adapter" Name="FilePath">/data/CSV/in</Setting>
    <Setting Target="Adapter" Name="WorkPath">/data/CSV/work</Setting>
    <Setting Target="Host" Name="TargetConfigNames">factures</Setting>
    <Setting Target="Host" Name="HeaderCount">1</Setting>
    <Setting Target="Adapter" Name="Charset">utf-8</Setting>
  </Item>
  <Item Name="factures" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">projet.routeur.factures</Setting>
  </Item>
  <Item Name="cibles factures" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
