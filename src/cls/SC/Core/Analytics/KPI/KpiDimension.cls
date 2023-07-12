/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Dimension object used by Deepsee KPI spec
Class SC.Core.Analytics.KPI.KpiDimension Extends (%Persistent, %JSON.Adaptor)
{

/// name, to be used in API parameter name  
Property name As %String(MAXLEN = 64) [ SqlColumnNumber = 2 ];

/// DImension display label
Property label As %String(MAXLEN = 64) [ SqlColumnNumber = 3 ];

/// Cube dimension, in MDX format
Property cubeDimension As %String(MAXLEN = 128) [ SqlColumnNumber = 4 ];

/// Parent dimension name. In case of hierarchy, a month dimension will have parent dimension year.
Property parent As %String(MAXLEN = 64) [ SqlColumnNumber = 5 ];

Storage Default
{
<Data name="KpiDimensionDefaultData">
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
<Value>cubeDimension</Value>
</Value>
<Value name="5">
<Value>parent</Value>
</Value>
</Data>
<DataLocation>^SC.Core.AnalyF0C7.KpiDimensionD</DataLocation>
<DefaultData>KpiDimensionDefaultData</DefaultData>
<IdLocation>^SC.Core.AnalyF0C7.KpiDimensionD</IdLocation>
<IndexLocation>^SC.Core.AnalyF0C7.KpiDimensionI</IndexLocation>
<StreamLocation>^SC.Core.AnalyF0C7.KpiDimensionS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
