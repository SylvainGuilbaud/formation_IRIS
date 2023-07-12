/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// KPI spec using DeepSee cubes
Class SC.Core.Analytics.KPI.DeepseeKpiSpec Extends (%Persistent, %JSON.Adaptor)
{

/// IRIS namespace for the cube
Property namespace As %String(MAXLEN = 32);

/// DeepSee cube name
Property cube As %String(MAXLEN = 32) [ Required ];

/// Cube measure for the KPI
Property kpiMeasure As %String(MAXLEN = 128);

/// Value type: raw measure, or percentage
Property valueType As %String(VALUELIST = ",raw,percentage") [ Required ];

/// KPI conditions, the MDX filter string for the KPI, can have multiple filter conditions.
/// This is required for a KPI definition.
Property kpiConditions As list Of %String(MAXLEN = 512);

/// KPI base condition. If KPI type is percentage, this set of conditions will be used for denominator.
/// The numerator will be querried by combining this set and the set of conditions in kpiConditions.
/// This is optional for a KPI definition
Property baseConditions As list Of %String(MAXLEN = 512);

/// KPI dimensions, which can be used for both further drilldown, or to show KPI value breakdowns.
/// This value is optional.
Property kpiDimensions As list Of SC.Core.Analytics.KPI.KpiDimension;

Parameter PERCENTAGETYPE = "percentage";

Parameter RAWTYPE = "raw";

/// CHecks if the KPI data type is percentage
Method isPercentageType() As %Integer
{
    set ret = 0
    if (..valueType = ..#PERCENTAGETYPE) { set ret = 1}
    return ret
}

/// CHeck if a dimension is defined in the spec as kpiDimension
Method HasDimension(dimName As %String) As %Integer
{
    Set ret = 0
    if ..kpiDimensions '= "" {
        set size = ..kpiDimensions.Size
        for i=1:1:size {
            if ..kpiDimensions.GetAt(i).name = dimName {
                set ret = 1
                Quit
            }
        }
    }
    Return ret
}

/// Get the dimension expression by name. Return "" if the dimension is not defined in the KPI
Method GetMdxDimensionByName(dimName As %String) As %String
{
    Set ret = ""
    if ..kpiDimensions '= "" {
        set size = ..kpiDimensions.Size
        for i=1:1:size {
            if ..kpiDimensions.GetAt(i).name = dimName {
                set ret = ..kpiDimensions.GetAt(i).cubeDimension
                Quit
            }
        }
    }
    Return ret
}

Storage Default
{
<Data name="DeepseeKpiSpecDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>namespace</Value>
</Value>
<Value name="3">
<Value>cube</Value>
</Value>
<Value name="4">
<Value>kpiMeasure</Value>
</Value>
<Value name="5">
<Value>valueType</Value>
</Value>
<Value name="6">
<Value>kpiConditions</Value>
</Value>
<Value name="7">
<Value>baseConditions</Value>
</Value>
<Value name="8">
<Value>kpiDimensions</Value>
</Value>
</Data>
<DataLocation>^SC.Core.AnaF0C7.DeepseeKpiSpecD</DataLocation>
<DefaultData>DeepseeKpiSpecDefaultData</DefaultData>
<IdLocation>^SC.Core.AnaF0C7.DeepseeKpiSpecD</IdLocation>
<IndexLocation>^SC.Core.AnaF0C7.DeepseeKpiSpecI</IndexLocation>
<StreamLocation>^SC.Core.AnaF0C7.DeepseeKpiSpecS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
