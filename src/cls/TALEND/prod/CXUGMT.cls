Class TALEND.prod.CXUGMT Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="TALEND.prod.CXUGMT" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="de ARTICLES GMT" Category="" ClassName="common.service.generic" PoolSize="0" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="de COMMANDES GMT" Category="" ClassName="common.service.generic" PoolSize="0" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="de XYZ GMT" Category="" ClassName="common.service.generic" PoolSize="0" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="GMTtoCXU" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">TALEND.rules.GMTtoCXU</Setting>
  </Item>
</Production>
}

}
