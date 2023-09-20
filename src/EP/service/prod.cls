Class EP.instruments.prod Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="EP.instruments.prod" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="from titreur XML" Category="" ClassName="EnsLib.EDI.XML.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">EnsLib.Testing.Process</Setting>
    <Setting Target="Host" Name="DocSchemaCategory">titreur</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.xml</Setting>
    <Setting Target="Adapter" Name="FilePath">/data/EP/in</Setting>
    <Setting Target="Host" Name="Validation">1</Setting>
  </Item>
  <Item Name="EnsLib.Testing.Process" Category="" ClassName="EnsLib.Testing.Process" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
