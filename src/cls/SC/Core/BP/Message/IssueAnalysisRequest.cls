/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.BP.Message.IssueAnalysisRequest Extends Ens.Request
{

Property issueId As %String;

Property targetProcess As %String;

Storage Default
{
<Data name="IssueAnalysisRequestDefaultData">
<Subscript>"IssueAnalysisRequest"</Subscript>
<Value name="1">
<Value>issueId</Value>
</Value>
<Value name="2">
<Value>targetProcess</Value>
</Value>
</Data>
<DefaultData>IssueAnalysisRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
