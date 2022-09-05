/// 
Class cube.trace Extends %DeepSee.CubeDefinition [ DependsOn = common.trace, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="trace" displayName="trace" disabled="false" abstract="false" sourceClass="common.trace" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="msg" disabled="false" hasAll="false" allCaption="All msg" allDisplayName="msg" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="msg" disabled="false" sourceProperty="msg" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="name" disabled="false" hasAll="false" allCaption="All name" allDisplayName="name" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="name" disabled="false" sourceProperty="name" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="ts" disabled="false" hasAll="false" allCaption="All ts" allDisplayName="ts" sourceProperty="ts" type="time" calendar="gregorian" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="day" disabled="false" timeFunction="DayMonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
      <level name="hour" disabled="false" timeFunction="HourNumber" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
      <level name="minute" disabled="false" timeFunction="MinuteNumber" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="6">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="type" disabled="false" hasAll="false" allCaption="All type" allDisplayName="type" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="type" disabled="false" sourceProperty="type" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="7">
      </level>
    </hierarchy>
  </dimension>
  <measure name="imported" disabled="false" sourceExpression="##class(common.trace).getImported(%source.%ID)" aggregate="SUM" type="number" scale="0" hidden="false" searchable="false" factNumber="1">
  </measure>
  <measure name="errors" disabled="false" sourceExpression="##class(common.trace).getErrors(%source.%ID)" aggregate="SUM" type="number" scale="0" hidden="false" searchable="false" factNumber="2">
  </measure>
  <measure name="elapsedMAX" disabled="false" sourceExpression="##class(common.trace).getElapse(%source.%ID)" aggregate="MAX" type="number" scale="6" hidden="false" searchable="false" factNumber="3">
  </measure>
  <measure name="elapse" disabled="false" sourceExpression="##class(common.trace).getElapse(%source.%ID)" aggregate="SUM" type="number" scale="6" hidden="false" searchable="false" factNumber="3">
  </measure>
  <measure name="elapseMIN" disabled="false" sourceExpression="##class(common.trace).getElapseMIN(%source.%ID)" aggregate="MIN" type="number" scale="6" hidden="false" searchable="false" factNumber="4">
  </measure>
  <measure name="elapseAVG" disabled="false" sourceExpression="##class(common.trace).getElapse(%source.%ID)" aggregate="AVG" type="number" scale="6" hidden="false" searchable="false" factNumber="3">
  </measure>
  <listing name="listing" disabled="false" listingType="table" fieldList="%ID,name,type,ts,msg">
  </listing>
</cube>
}

Parameter DOMAIN;

}
