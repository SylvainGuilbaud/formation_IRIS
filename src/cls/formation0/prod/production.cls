Class formation.prod.production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="formation.prod.production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="get gender" Category="transfo + traitements" ClassName="HTTP.operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="HTTPServer">api.genderize.io</Setting>
    <Setting Target="Adapter" Name="SSLConfig">API</Setting>
    <Setting Target="Adapter" Name="URL">/</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="from Patients CSV" Category="" ClassName="EnsLib.RecordMap.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="RecordMap">formation.RM.patient</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/data/patient/archive</Setting>
    <Setting Target="Adapter" Name="FilePath">/data/patient/in/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
    <Setting Target="Adapter" Name="WorkPath">/data/patient/work</Setting>
    <Setting Target="Host" Name="TargetConfigNames">patients</Setting>
    <Setting Target="Host" Name="HeaderCount">1</Setting>
  </Item>
  <Item Name="patients" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">formation.rules.patients</Setting>
  </Item>
  <Item Name="to patient SQL" Category="" ClassName="formation.operation.patient" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">mysql</Setting>
    <Setting Target="Adapter" Name="JGService">JG</Setting>
  </Item>
  <Item Name="JG" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
