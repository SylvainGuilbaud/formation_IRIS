Class ProdEye.Prod.ProdEyeProduction Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="ProdEye.Prod.ProdEyeProduction" LogGeneralTraceEvents="false">
  <Description>Production with one REST service to monitor other productions</Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="ProdEyeRestService" Category="" ClassName="ProdEye.Prod.ProdEyeRest" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Host" Name="PageSize">5</Setting>
    <Setting Target="Adapter" Name="Charset">Auto</Setting>
    <Setting Target="Adapter" Name="ForceCharset">0</Setting>
    <Setting Target="Adapter" Name="SSLConfig"></Setting>
    <Setting Target="Adapter" Name="LocalInterface"></Setting>
  </Item>
</Production>
}

}
