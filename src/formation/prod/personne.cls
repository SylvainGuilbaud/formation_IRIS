Class formation.prod.personne Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="formation.prod.personne" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description>aaaaa</Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="get gender" Category="transfo + traitements" ClassName="HTTP.operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="HTTPServer">api.genderize.io</Setting>
    <Setting Target="Adapter" Name="SSLConfig">API</Setting>
    <Setting Target="Adapter" Name="URL">/</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="personnes" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">formation.rules.personnes</Setting>
  </Item>
  <Item Name="to personne SQL" Category="" ClassName="formation.operation.personne" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="JGService">JG</Setting>
  </Item>
  <Item Name="JG" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="from personnes FTP" Category="" ClassName="EnsLib.RecordMap.Service.FTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="RecordMap">formation.RM.personne</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/data/personne/archive</Setting>
    <Setting Target="Adapter" Name="FilePath">./ftp/in</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
    <Setting Target="Host" Name="TargetConfigNames">process personne</Setting>
    <Setting Target="Host" Name="HeaderCount">1</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.0.0.100</Setting>
    <Setting Target="Adapter" Name="Credentials">ftp</Setting>
  </Item>
  <Item Name="from personnes FTP BATCH" Category="" ClassName="EnsLib.RecordMap.Service.BatchFTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="RecordMap">formation.RM.personne</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/data/personne/archive</Setting>
    <Setting Target="Adapter" Name="FilePath">./ftp/batch</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
    <Setting Target="Host" Name="TargetConfigNames">personnes</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.0.0.100</Setting>
    <Setting Target="Adapter" Name="Credentials">ftp</Setting>
    <Setting Target="Host" Name="BatchClass">formation.RM.personne.Batch</Setting>
    <Setting Target="Host" Name="BatchHandling">Whole</Setting>
  </Item>
  <Item Name="from personnes BATCH" Category="" ClassName="EnsLib.RecordMap.Service.BatchFileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="RecordMap">formation.RM.personne</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/data/personne/archive</Setting>
    <Setting Target="Adapter" Name="FilePath">/data/personne/batch/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
    <Setting Target="Host" Name="TargetConfigNames">personnes</Setting>
    <Setting Target="Host" Name="BatchClass">formation.RM.personne.Batch</Setting>
    <Setting Target="Host" Name="BatchHandling">Whole</Setting>
  </Item>
  <Item Name="from personnes" Category="" ClassName="EnsLib.RecordMap.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="RecordMap">formation.RM.personne</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/data/personne/archive</Setting>
    <Setting Target="Adapter" Name="FilePath">/data/personne/in/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
    <Setting Target="Adapter" Name="WorkPath">/data/personne/work</Setting>
    <Setting Target="Host" Name="TargetConfigNames">process personne</Setting>
    <Setting Target="Host" Name="HeaderCount">1</Setting>
  </Item>
  <Item Name="process personne" Category="" ClassName="formation.process.personne" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="from personnes REST" Category="" ClassName="REST.service" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">process personne</Setting>
  </Item>
  <Item Name="from personne EMAIL" Category="" ClassName="formation.service.personne" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">personnes</Setting>
    <Setting Target="Adapter" Name="POP3Port">110</Setting>
    <Setting Target="Adapter" Name="POP3Server">pop.free.fr</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="Credentials">email</Setting>
  </Item>
  <Item Name="EP.service.replication" Category="" ClassName="EP.service.replication" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">EP.operation.replication</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Host" Name="Server">host.docker.internal</Setting>
  </Item>
  <Item Name="EP.operation.replication" Category="" ClassName="EP.operation.replication" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
</Production>
}

}
