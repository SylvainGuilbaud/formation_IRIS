Class JDBC.demo.production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="JDBC.demo.production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="JG" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="fichiers clients" Category="fichiers directs,archive" ClassName="EnsLib.RecordMap.Service.BatchFileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="BatchClass">data.RM.customer.Batch</Setting>
    <Setting Target="Host" Name="RecordMap">data.RM.customer</Setting>
    <Setting Target="Host" Name="TargetConfigNames">MAJ clients base externe,archive fichiers clients,archive fichiers clients ftp</Setting>
    <Setting Target="Adapter" Name="FilePath">/data/in</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
    <Setting Target="Host" Name="BatchHandling">Whole</Setting>
  </Item>
  <Item Name="fichiers clients + transfo" Category="transfo,archive" ClassName="EnsLib.RecordMap.Service.BatchFileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="BatchClass">data.RM.customer.Batch</Setting>
    <Setting Target="Host" Name="RecordMap">data.RM.customer</Setting>
    <Setting Target="Host" Name="TargetConfigNames">routage + transfo clients</Setting>
    <Setting Target="Adapter" Name="FilePath">/data/in+transfo/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
    <Setting Target="Host" Name="BatchHandling">Whole</Setting>
  </Item>
  <Item Name="fichiers clients + transfo + traitements" Category="transfo + traitements,archive" ClassName="EnsLib.RecordMap.Service.BatchFileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="BatchClass">data.RM.customer.Batch</Setting>
    <Setting Target="Host" Name="RecordMap">data.RM.customer</Setting>
    <Setting Target="Host" Name="TargetConfigNames">transfo + traitements fichiers clients</Setting>
    <Setting Target="Adapter" Name="FilePath">/data/in+transfo+traitements/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
    <Setting Target="Host" Name="BatchHandling">Whole</Setting>
  </Item>
  <Item Name="MAJ clients base interne" Category="" ClassName="JDBC.demo.SELECT.operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="JGService">JG</Setting>
    <Setting Target="Adapter" Name="StayConnected">10</Setting>
    <Setting Target="Adapter" Name="DSN">jdbc:postgresql://postgres:5432/postgres</Setting>
    <Setting Target="Adapter" Name="JDBCClasspath">/app/jdbc/postgresql-42.2.23.jar</Setting>
    <Setting Target="Adapter" Name="JDBCDriver">org.postgresql.Driver</Setting>
    <Setting Target="Adapter" Name="Credentials">PostgreSQL</Setting>
    <Setting Target="Host" Name="batchSize">1000</Setting>
  </Item>
  <Item Name="MAJ clients base externe" Category="fichiers directs,transfo,transfo + traitements" ClassName="JDBC.demo.INSERT.operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="JGService">JG</Setting>
    <Setting Target="Adapter" Name="StayConnected">10</Setting>
    <Setting Target="Adapter" Name="DSN">jdbc:postgresql://postgres:5432/postgres</Setting>
    <Setting Target="Adapter" Name="JDBCClasspath">/app/jdbc/postgresql-42.2.23.jar</Setting>
    <Setting Target="Adapter" Name="JDBCDriver">org.postgresql.Driver</Setting>
    <Setting Target="Adapter" Name="Credentials">PostgreSQL</Setting>
    <Setting Target="Host" Name="batchSize">10</Setting>
  </Item>
  <Item Name="routage + transfo clients" Category="transfo" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">JDBC.demo.routage.clients</Setting>
  </Item>
  <Item Name="transfo + traitements fichiers clients" Category="transfo + traitements" ClassName="JDBC.demo.process.customers" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="get gender" Category="transfo + traitements" ClassName="HTTP.operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="HTTPServer">api.genderize.io</Setting>
    <Setting Target="Adapter" Name="SSLConfig">API</Setting>
    <Setting Target="Adapter" Name="URL">/</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">1</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="archive fichiers clients" Category="archive" ClassName="EnsLib.RecordMap.Operation.BatchFileOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="Filename">%Q_%f</Setting>
    <Setting Target="Adapter" Name="FilePath">/data/out/</Setting>
    <Setting Target="Host" Name="RecordMap">data.RM.customer</Setting>
  </Item>
  <Item Name="crcind.Operation.SOAPDemoSoap" Category="" ClassName="crcind.Operation.SOAPDemoSoap" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="SSLConfig">API</Setting>
  </Item>
  <Item Name="w3schools.Operation.TempConvertSoap" Category="" ClassName="w3schools.Operation.TempConvertSoap" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="SSLConfig">API</Setting>
  </Item>
  <Item Name="fichiers" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">bastideRouteur.fichiers</Setting>
  </Item>
  <Item Name="GET DATA CLINICOM SQL" Category="fichiers directs,transfo,transfo + traitements" ClassName="JDBC.demo.INSERT.operation" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="JGService">JG</Setting>
    <Setting Target="Adapter" Name="StayConnected">10</Setting>
    <Setting Target="Adapter" Name="DSN">jdbc:IRIS://172.18.1.73:1972/DSA-CLA-PRD</Setting>
    <Setting Target="Adapter" Name="JDBCClasspath">/app/jdbc/intersystems-jdbc-3.3.1.jar</Setting>
    <Setting Target="Adapter" Name="JDBCDriver">com.intersystems.jdbc.IRISDriver</Setting>
    <Setting Target="Adapter" Name="Credentials">CLINICOM</Setting>
    <Setting Target="Host" Name="batchSize">10</Setting>
  </Item>
  <Item Name="from customer SQL" Category="" ClassName="EnsLib.SQL.Service.GenericService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">routage + transfo clients</Setting>
    <Setting Target="Adapter" Name="Credentials">PostgreSQL</Setting>
    <Setting Target="Adapter" Name="Query">select ID,
    last_name lastname,
    first_name firstname,
    city,
    active,
    category,
    gender,
    created,
    inserted,
    lastupdate
from app.customer</Setting>
    <Setting Target="Adapter" Name="DSN">postgres</Setting>
    <Setting Target="Adapter" Name="JGService">JG</Setting>
    <Setting Target="Host" Name="MessageClass">SQL.msg.customerRequest</Setting>
  </Item>
  <Item Name="from IRIS SQL" Category="" ClassName="EnsLib.SQL.Service.GenericService" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">routage + transfo clients</Setting>
    <Setting Target="Adapter" Name="Credentials"></Setting>
    <Setting Target="Adapter" Name="Query">SELECT 
ID, BStream, Boolean, CStream, "Date", "Double", "Float", "Integer", MT, "Numeric", String, Timestamp, created, extension
FROM data.test</Setting>
    <Setting Target="Adapter" Name="DSN">iris</Setting>
    <Setting Target="Adapter" Name="JGService">JG</Setting>
    <Setting Target="Host" Name="MessageClass"></Setting>
  </Item>
  <Item Name="ftp clients" Category="fichiers directs,archive" ClassName="EnsLib.RecordMap.Service.BatchFTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="BatchClass">data.RM.customer.Batch</Setting>
    <Setting Target="Host" Name="RecordMap">data.RM.customer</Setting>
    <Setting Target="Host" Name="TargetConfigNames">MAJ clients base externe,archive fichiers clients</Setting>
    <Setting Target="Adapter" Name="FilePath">./ftp/in</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
    <Setting Target="Host" Name="BatchHandling">Whole</Setting>
    <Setting Target="Adapter" Name="Credentials">ftp</Setting>
    <Setting Target="Adapter" Name="FTPPort">21</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.0.0.100</Setting>
    <Setting Target="Adapter" Name="Protocol">FTP</Setting>
    <Setting Target="Adapter" Name="SSLConfig"></Setting>
  </Item>
  <Item Name="ftp clients + transfo" Category="transfo,archive" ClassName="EnsLib.RecordMap.Service.BatchFTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="BatchClass">data.RM.customer.Batch</Setting>
    <Setting Target="Host" Name="RecordMap">data.RM.customer</Setting>
    <Setting Target="Host" Name="TargetConfigNames">routage + transfo clients</Setting>
    <Setting Target="Adapter" Name="FilePath">./ftp/in+transfo</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
    <Setting Target="Host" Name="BatchHandling">Whole</Setting>
    <Setting Target="Adapter" Name="Credentials">ftp</Setting>
    <Setting Target="Adapter" Name="FTPPort">21</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.0.0.100</Setting>
    <Setting Target="Adapter" Name="Protocol">FTP</Setting>
  </Item>
  <Item Name="ftp clients + transfo + traitements" Category="transfo + traitements,archive" ClassName="EnsLib.RecordMap.Service.BatchFTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="BatchClass">data.RM.customer.Batch</Setting>
    <Setting Target="Host" Name="RecordMap">data.RM.customer</Setting>
    <Setting Target="Host" Name="TargetConfigNames">transfo + traitements fichiers clients</Setting>
    <Setting Target="Adapter" Name="FilePath">./ftp/in+transfo+traitements</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
    <Setting Target="Host" Name="BatchHandling">Whole</Setting>
    <Setting Target="Adapter" Name="Credentials">ftp</Setting>
    <Setting Target="Adapter" Name="FTPPort">21</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.0.0.100</Setting>
    <Setting Target="Adapter" Name="Protocol">FTP</Setting>
  </Item>
  <Item Name="archive fichiers clients ftp" Category="archive" ClassName="EnsLib.RecordMap.Operation.BatchFTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="Filename">%Q_%f</Setting>
    <Setting Target="Adapter" Name="FilePath">./ftp/out</Setting>
    <Setting Target="Host" Name="RecordMap">data.RM.customer</Setting>
    <Setting Target="Adapter" Name="Credentials">ftp</Setting>
    <Setting Target="Adapter" Name="FTPPort">21</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.0.0.100</Setting>
    <Setting Target="Adapter" Name="Protocol">FTP</Setting>
  </Item>
</Production>
}

}
