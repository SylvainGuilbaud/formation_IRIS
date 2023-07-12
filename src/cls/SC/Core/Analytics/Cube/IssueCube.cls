/// 
Class SC.Core.Analytics.Cube.IssueCube Extends %DeepSee.CubeDefinition [ DependsOn = SC.Data.Issue, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="IssueCube" displayName="IssueCube" description="Issue Cube" disabled="false" abstract="false" sourceClass="SC.Data.Issue" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="issueRegion" displayName="Issue Region" description="Issue Region" disabled="false" hasAll="false" allCaption="All issueRegion" allDisplayName="issueRegion" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="issueRegion" displayName="Issue Region" disabled="false" sourceProperty="issueRegion" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="processName" displayName="Process Name" description="Default process name for issue analysis" disabled="false" hasAll="false" allCaption="All processName" allDisplayName="processName" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="processName" disabled="false" sourceProperty="processName" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="status" displayName="Issue Status" description="Issue status value" disabled="false" hasAll="false" allCaption="All status" allDisplayName="status" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="status" disabled="false" sourceProperty="status" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="severity" displayName="Issue Severity" description="Issue Severity" disabled="false" hasAll="false" allCaption="All severity" allDisplayName="severity" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="severity" disabled="false" sourceProperty="severity" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="urgency" displayName="Issue Urgency" description="Issue Urgency" disabled="false" hasAll="false" allCaption="All urgency" allDisplayName="urgency" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="urgency" disabled="false" sourceProperty="urgency" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="6">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="triggerObjectId" displayName="Trigger Object ID" disabled="false" hasAll="false" allCaption="All triggerObjectId" allDisplayName="triggerObjectId" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="triggerObjectId" disabled="false" sourceProperty="triggerObjectId" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="7">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="triggerType" displayName="Trigger Type" description="Trigger Type" disabled="false" hasAll="false" allCaption="All triggerType" allDisplayName="triggerType" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="triggerType" disabled="false" sourceProperty="triggerType" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="8">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="issueCategory" displayName="Issue Category" description="Issue Category" disabled="false" hasAll="false" allCaption="All issueCategory" allDisplayName="issueCategory" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="issueCategory" disabled="false" sourceProperty="issueCategory" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="9">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="resolutionType" displayName="Resolution Type" description="Resolution Type" disabled="false" hasAll="false" allCaption="All resolutionType" allDisplayName="resolutionType" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="resolutionType" disabled="false" sourceProperty="resolutionType" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="10">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="impactedObjectType" displayName="Impacted Object Type" disabled="false" hasAll="false" allCaption="All impactedObjectType" allDisplayName="impactedObjectType" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="impactedObjectType" disabled="false" sourceProperty="impactedObjectType" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="11">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="recordCreatedTime" disabled="false" hasAll="false" allCaption="All recordCreatedTime" allDisplayName="recordCreatedTime" sourceProperty="recordCreatedTime" type="time" calendar="gregorian" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Year" displayName="Issue Created Year" description="Issue Created Year" disabled="false" timeFunction="Year" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="12">
      </level>
      <level name="Month" displayName="Issue Created Month" description="Issue Created Month" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="13">
      </level>
      <level name="Week" displayName="Issue Created Week" description="Issue Created Week" disabled="false" timeFunction="WeekYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="14">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="issueLocation" disabled="false" hasAll="false" allCaption="All source" allDisplayName="source" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="country" displayName="Location Country" description="Location Country" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getIssueImpactedCountry(%source.%ID)" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="15">
      </level>
    </hierarchy>
  </dimension>
  <measure name="impactedValue" displayName="Impacted Value" description="Sum of the total value impacted" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getIssueImpactedValue(%source.%ID)" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="1">
  </measure>
  <measure name="averageOpenTime" displayName="Average Issue Open Time" description="Average Issue Open Time in hours" disabled="false" sourceExpression="##class(SC.Core.Util.CubeUtil).getHoursLateWithDefaultActual(%source.recordCreatedTime,%source.closeTime)" aggregate="AVG" type="number" hidden="false" searchable="false" factNumber="2">
  </measure>
</cube>
}

Parameter DOMAIN;

}
