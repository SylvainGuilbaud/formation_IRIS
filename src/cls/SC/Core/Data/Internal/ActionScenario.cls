/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.Internal.ActionScenario Extends (%Persistent, %JSON.Adaptor)
{

/// Option number, A, B, C, or 1,2,3, etc
Property optionNumber As %String(MAXLEN = 10) [ SqlColumnNumber = 2 ];

/// name/short description of the scenario
Property optionName As %String(MAXLEN = 64) [ SqlColumnNumber = 3 ];

/// Description of the scenario
Property description As %String(MAXLEN = 512) [ SqlColumnNumber = 4 ];

/// Money impact of the option/scenario
Property costImpact As %Numeric;

/// time impact of the scenario
Property timeImpact As %Numeric;

/// Supporting data used in the analysis, such as inventory position, labor availability, etc.
Property supportingData As %String(MAXLEN = 512);

/// If the scenarios is feasible for the issue
Property feasibility As %Integer;

/// If the scenarios is recommended
Property recommended As %Integer;

Storage Default
{
<Data name="ActionScenarioDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>optionNumber</Value>
</Value>
<Value name="3">
<Value>optionName</Value>
</Value>
<Value name="4">
<Value>description</Value>
</Value>
<Value name="5">
<Value>costImpact</Value>
</Value>
<Value name="6">
<Value>timeImpact</Value>
</Value>
<Value name="7">
<Value>supportingData</Value>
</Value>
<Value name="8">
<Value>feasibility</Value>
</Value>
<Value name="9">
<Value>recommended</Value>
</Value>
</Data>
<DataLocation>^SC.Core.Dat5DF8.ActionScenarioD</DataLocation>
<DefaultData>ActionScenarioDefaultData</DefaultData>
<IdLocation>^SC.Core.Dat5DF8.ActionScenarioD</IdLocation>
<IndexLocation>^SC.Core.Dat5DF8.ActionScenarioI</IndexLocation>
<StreamLocation>^SC.Core.Dat5DF8.ActionScenarioS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
