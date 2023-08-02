Class petshop.Production Extends Ens.Production [ ProcedureBlock ]
{

XData ProductionDefinition
{
<Production Name="petshop" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="petshop.bs.ProxyService" Category="" ClassName="petshop.bs.ProxyService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.addPet" Category="" ClassName="petshop.bs.addPet" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.createUser" Category="" ClassName="petshop.bs.createUser" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.createUsersWithListInput" Category="" ClassName="petshop.bs.createUsersWithListInput" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.deleteOrder" Category="" ClassName="petshop.bs.deleteOrder" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.deletePet" Category="" ClassName="petshop.bs.deletePet" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.deleteUser" Category="" ClassName="petshop.bs.deleteUser" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.findPetsByStatus" Category="" ClassName="petshop.bs.findPetsByStatus" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.findPetsByTags" Category="" ClassName="petshop.bs.findPetsByTags" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.getInventory" Category="" ClassName="petshop.bs.getInventory" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.getOrderById" Category="" ClassName="petshop.bs.getOrderById" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.getPetById" Category="" ClassName="petshop.bs.getPetById" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.getUserByName" Category="" ClassName="petshop.bs.getUserByName" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.loginUser" Category="" ClassName="petshop.bs.loginUser" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.logoutUser" Category="" ClassName="petshop.bs.logoutUser" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.placeOrder" Category="" ClassName="petshop.bs.placeOrder" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.updatePet" Category="" ClassName="petshop.bs.updatePet" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.updatePetWithForm" Category="" ClassName="petshop.bs.updatePetWithForm" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.updateUser" Category="" ClassName="petshop.bs.updateUser" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bs.uploadFile" Category="" ClassName="petshop.bs.uploadFile" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule=""></Item>
  <Item Name="petshop.bo.Operation" Category="" ClassName="petshop.bo.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="HTTPServer">petstore3.swagger.io</Setting>
    <Setting Target="Adapter" Name="SSLConfig">DefaultSSL</Setting>
    <Setting Target="Adapter" Name="HTTPPort"></Setting>
    <Setting Target="Adapter" Name="URL">/api/v3</Setting>
  </Item>
  <Item Name="petshop.bp.Process" Category="" ClassName="petshop.bp.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="petshop.bp.SyncProcess" Category="" ClassName="petshop.bp.SyncProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
