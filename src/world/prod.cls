Class world.prod Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="world.prod" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="from world-data CSV" Category="" ClassName="EnsLib.RecordMap.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">EnsLib.Testing.Process</Setting>
    <Setting Target="Host" Name="RecordMap">world.RM</Setting>
    <Setting Target="Adapter" Name="FilePath">/data/kaggle/world/in</Setting>
    <Setting Target="Adapter" Name="FileSpec">*</Setting>
    <Setting Target="Host" Name="HeaderCount">1</Setting>
  </Item>
  <Item Name="from world-data SQL" Category="" ClassName="EnsLib.SQL.Service.GenericService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Query">SELECT 
ID, Country, DensityPKm2, Abbreviation, AgriculturalLand, LandAreaKm2, ArmedForcessize, BirthRate, CallingCode, CapitalMajorCity, Co2Emissions, CPI, CPIChange, CurrencyCode, FertilityRate, ForestedArea, GasolinePrice, GDP, Grossprimaryeducationenrollment, Grosstertiaryeducationenrollment, Infantmortality, Largestcity, Lifeexpectancy, Maternalmortalityratio, Minimumwage, Officiallanguage, Outofpockethealthexpenditure, Physiciansperthousand, Population, PopulationLaborforceparticipation, Taxrevenue, Totaltaxrate, Unemploymentrate, Urbanpopulation, Latitude, Longitude, %Source
FROM world_RM.Record</Setting>
    <Setting Target="Adapter" Name="JGService">JG</Setting>
    <Setting Target="Adapter" Name="DSN">iris</Setting>
    <Setting Target="Host" Name="TargetConfigNames">to JSON FILE,to CIBLE 2,data,dummy</Setting>
    <Setting Target="Host" Name="MessageClass">world.data</Setting>
    <Setting Target="Adapter" Name="CallInterval">3600</Setting>
  </Item>
  <Item Name="JG" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="to JSON FILE" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/data/kaggle/world/out</Setting>
  </Item>
  <Item Name="to CIBLE 2" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/data/kaggle/world/out</Setting>
  </Item>
  <Item Name="from world-data EUROPE SQL" Category="" ClassName="EnsLib.SQL.Service.GenericService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Query">SELECT 
ID, Country, DensityPKm2, Abbreviation, AgriculturalLand, LandAreaKm2, ArmedForcessize, BirthRate, CallingCode, CapitalMajorCity, Co2Emissions, CPI, CPIChange, CurrencyCode, FertilityRate, ForestedArea, GasolinePrice, GDP, Grossprimaryeducationenrollment, Grosstertiaryeducationenrollment, Infantmortality, Largestcity, Lifeexpectancy, Maternalmortalityratio, Minimumwage, Officiallanguage, Outofpockethealthexpenditure, Physiciansperthousand, Population, PopulationLaborforceparticipation, Taxrevenue, Totaltaxrate, Unemploymentrate, Urbanpopulation, Latitude, Longitude, %Source
FROM world_RM.Record
where country in ('France','Italy','Spain')</Setting>
    <Setting Target="Adapter" Name="JGService">JG</Setting>
    <Setting Target="Adapter" Name="DSN">iris</Setting>
    <Setting Target="Host" Name="TargetConfigNames">to JSON FILE,to CIBLE 2,data,dummy</Setting>
    <Setting Target="Host" Name="MessageClass">world.data</Setting>
  </Item>
  <Item Name="data" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">world.router.data</Setting>
  </Item>
  <Item Name="world.process" Category="" ClassName="world.process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="dummy" Category="" ClassName="EnsLib.Testing.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="common.service.dummy" Category="" ClassName="common.service.dummy" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">data</Setting>
    <Setting Target="Host" Name="async">1</Setting>
  </Item>
</Production>
}

}
