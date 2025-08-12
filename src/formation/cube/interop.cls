/// 
Class formation.cube.interop Extends %DeepSee.CubeDefinition [ DependsOn = Ens.MessageHeader, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="interop" displayName="interop" disabled="false" abstract="false" sourceClass="Ens.MessageHeader" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="Priority" disabled="false" hasAll="false" allCaption="All Priority" allDisplayName="Priority" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Priority" disabled="false" sourceProperty="Priority" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Resent" disabled="false" hasAll="false" allCaption="All Resent" allDisplayName="Resent" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Resent" disabled="false" sourceProperty="Resent" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Status" disabled="false" hasAll="false" allCaption="All Status" allDisplayName="Status" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Status" disabled="false" sourceProperty="Status" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="TargetBusinessType" disabled="false" hasAll="false" allCaption="All TargetBusinessType" allDisplayName="TargetBusinessType" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="TargetBusinessType" disabled="false" sourceProperty="TargetBusinessType" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="6">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="TargetConfigName" disabled="false" hasAll="false" allCaption="All TargetConfigName" allDisplayName="TargetConfigName" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="TargetConfigName" disabled="false" sourceProperty="TargetConfigName" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="7">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="TargetQueueName" disabled="false" hasAll="false" allCaption="All TargetQueueName" allDisplayName="TargetQueueName" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="TargetQueueName" disabled="false" sourceProperty="TargetQueueName" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="8">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="TimeCreated" disabled="false" hasAll="false" allCaption="All TimeCreated" allDisplayName="TimeCreated" sourceProperty="TimeCreated" type="time" calendar="gregorian" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="TimeCreated" disabled="false" timeFunction="DayMonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="9">
      </level>
      <level name="hourCreated" disabled="false" timeFunction="HourNumber" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="12">
      </level>
      <level name="MinuteCreated" disabled="false" timeFunction="MinuteNumber" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="13">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="TimeProcessed" disabled="false" hasAll="false" allCaption="All TimeProcessed" allDisplayName="TimeProcessed" sourceProperty="TimeProcessed" type="time" calendar="gregorian" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="TimeProcessed" disabled="false" timeFunction="DayMonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="10">
      </level>
      <level name="HourProcessed" disabled="false" timeFunction="HourNumber" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="14">
      </level>
      <level name="MinuteProcessed" disabled="false" timeFunction="MinuteNumber" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="15">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Type" disabled="false" hasAll="false" allCaption="All Type" allDisplayName="Type" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Type" disabled="false" sourceProperty="Type" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="11">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="ErrorStatus" disabled="false" hasAll="false" allCaption="All ErrorStatus1" allDisplayName="ErrorStatus1" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="isError" disabled="false" sourceExpression="$select($extract(%source.ErrorStatus,1,1)=1:&quot;NO ERROR&quot;,$extract(%source.ErrorStatus,1,1)=0:&quot;ERROR&quot;)" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
    </hierarchy>
  </dimension>
  <listing name="listing" disabled="false" listingType="table" fieldList="%ID,Banked,BusinessProcessId,CorrespondingMessageId,Description,ErrorStatus,Invocation,IsError,MessageBodyClassName,MessageBodyId,Priority,Resent,ReturnQueueName,SessionId,SourceBusinessType,SourceConfigName,Status,SuperSession,TargetBusinessType,TargetConfigName" selectMode="2">
  </listing>
</cube>
}

Parameter DOMAIN;

}
