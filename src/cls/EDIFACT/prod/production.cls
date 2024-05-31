Class EDIFACT.prod.production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="EDIFACT.prod.production" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="EDIFACT IFTDGN in" Category="" ClassName="EnsLib.EDI.EDIFACT.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/data/EDIFACT/in</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.EDIFACT</Setting>
    <Setting Target="Host" Name="TargetConfigNames">EDIFACTRouter</Setting>
    <Setting Target="Host" Name="DocSchemaCategory">D01B</Setting>
    <Setting Target="Adapter" Name="Charset">Binary</Setting>
    <Setting Target="Host" Name="BatchHandling">Whole</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="EDIFACTRouter" Category="" ClassName="EnsLib.MsgRouter.VDocRoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">EDIFACT.rules.EDIFACTRouter</Setting>
    <Setting Target="Host" Name="RuleLogging">a</Setting>
  </Item>
  <Item Name="EDIFACT IFTDGN out" Category="" ClassName="EnsLib.EDI.EDIFACT.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/data/EDIFACT/out</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
</Production>
}

}
