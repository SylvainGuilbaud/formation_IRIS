Class prodadmin.Production Extends Ens.Production [ ProcedureBlock ]
{

XData ProductionDefinition
{
<Production Name="prodadmin" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="prodadmin.bs.GetNamespaces" Category="" ClassName="prodadmin.bs.GetNamespaces" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.ProxyService" Category="" ClassName="prodadmin.bs.ProxyService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.SecurityExport" Category="" ClassName="prodadmin.bs.SecurityExport" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.SecurityImport" Category="" ClassName="prodadmin.bs.SecurityImport" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.SwaggerSpec" Category="" ClassName="prodadmin.bs.SwaggerSpec" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.analytics" Category="" ClassName="prodadmin.bs.analytics" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.createNamespace" Category="" ClassName="prodadmin.bs.createNamespace" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.createProduction" Category="" ClassName="prodadmin.bs.createProduction" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.deleteNamespace" Category="" ClassName="prodadmin.bs.deleteNamespace" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.disableNamespace" Category="" ClassName="prodadmin.bs.disableNamespace" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.enableNamespace" Category="" ClassName="prodadmin.bs.enableNamespace" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.enableNamespace01" Category="" ClassName="prodadmin.bs.enableNamespace01" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.namespaceExists" Category="" ClassName="prodadmin.bs.namespaceExists" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.newKey" Category="" ClassName="prodadmin.bs.newKey" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.service" Category="" ClassName="prodadmin.bs.service" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bs.version" Category="" ClassName="prodadmin.bs.version" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="prodadmin.bo.Operation" Category="" ClassName="prodadmin.bo.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="HTTPServer"></Setting>
    <Setting Target="Adapter" Name="SSLConfig">DefaultSSL</Setting>
    <Setting Target="Adapter" Name="HTTPPort"></Setting>
    <Setting Target="Adapter" Name="URL">/admin</Setting>
  </Item>
  <Item Name="prodadmin.bp.Process" Category="" ClassName="prodadmin.bp.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="prodadmin.bp.SyncProcess" Category="" ClassName="prodadmin.bp.SyncProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
