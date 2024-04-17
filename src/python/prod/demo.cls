Class python.prod.demo Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="python.prod.demo" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="python.process.demo" Category="" ClassName="python.process.demo" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ReplyCodeActions">E#2601=S</Setting>
  </Item>
</Production>
}

}
