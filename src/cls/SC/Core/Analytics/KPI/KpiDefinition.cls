/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// KPI definition class
Class SC.Core.Analytics.KPI.KpiDefinition Extends (%Persistent, %JSON.Adaptor)
{

/// KPI name, must be unique
Property name As %String(MAXLEN = 128) [ SqlColumnNumber = 2 ];

Index nameIDX On name [ PrimaryKey ];

/// KPI display name
Property label As %String(MAXLEN = 128) [ SqlColumnNumber = 3 ];

/// Description of the KPI
Property description As %String(MAXLEN = 512) [ SqlColumnNumber = 4 ];

/// KPI type: DeepSee, SQL, ObjectScrip, etc.
Property type As %String(MAXLEN = 64) [ SqlColumnNumber = 5 ];

/// Base object for the KPI (for listing etc.)
Property baseObject As %String(MAXLEN = 64) [ SqlColumnNumber = 6 ];

/// KPI status, Active/Inactive/etc.
Property status As %String(MAXLEN = 32) [ SqlColumnNumber = 7 ];

/// Threshold for watching (yellow)
Property watchingThreshold As %Numeric [ SqlColumnNumber = 8 ];

/// warning threshold (red)
Property warningThreshold As %Numeric [ SqlColumnNumber = 9 ];

/// FLag to indicate if an issue should be raised for the impacted records
Property issueKpi As %Boolean [ SqlColumnNumber = 10 ];

/// Default severity level for the issue raised through the KPI
Property defaultIssueSeverity As %Integer [ SqlColumnNumber = 11 ];

/// BPL service name for issue resolution/recommendation 
Property analysisService As %String(MAXLEN = 64) [ SqlColumnNumber = 12 ];

/// KPI spec using DeepSee Cube
Property deepseeKpiSpec As SC.Core.Analytics.KPI.DeepseeKpiSpec;

Storage Default
{
<Data name="KpiDefinitionDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>label</Value>
</Value>
<Value name="4">
<Value>description</Value>
</Value>
<Value name="5">
<Value>type</Value>
</Value>
<Value name="6">
<Value>baseObject</Value>
</Value>
<Value name="7">
<Value>status</Value>
</Value>
<Value name="8">
<Value>watchingThreshold</Value>
</Value>
<Value name="9">
<Value>warningThreshold</Value>
</Value>
<Value name="10">
<Value>issueKpi</Value>
</Value>
<Value name="11">
<Value>defaultIssueSeverity</Value>
</Value>
<Value name="12">
<Value>analysisService</Value>
</Value>
<Value name="13">
<Value>deepseeKpiSpec</Value>
</Value>
</Data>
<DataLocation>^SC.Core.AnalF0C7.KpiDefinitionD</DataLocation>
<DefaultData>KpiDefinitionDefaultData</DefaultData>
<ExtentSize>0</ExtentSize>
<IdLocation>^SC.Core.AnalF0C7.KpiDefinitionD</IdLocation>
<IndexLocation>^SC.Core.AnalF0C7.KpiDefinitionI</IndexLocation>
<StreamLocation>^SC.Core.AnalF0C7.KpiDefinitionS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
