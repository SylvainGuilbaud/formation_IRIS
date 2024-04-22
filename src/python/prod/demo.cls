Class python.prod.demo Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="python.prod.demo" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="EnsLib.EMail.AlertOperation" Category="" ClassName="EnsLib.EMail.AlertOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="call alert" Category="" ClassName="dc.process.dynamicCall" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">EnsLib.EMail.AlertOperation</Setting>
    <Setting Target="Host" Name="TargetConfigNames">EnsLib.EMail.AlertOperation</Setting>
  </Item>
  <Item Name="call hot beverage" Category="" ClassName="dc.process.dynamicCall" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">call hot beverage</Setting>
    <Setting Target="Host" Name="TargetConfigNames">hot beverage</Setting>
  </Item>
  <Item Name="hot beverage" Category="" ClassName="python.process.demo" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
