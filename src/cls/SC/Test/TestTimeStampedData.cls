/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// A test class for TimeStampedData
Class SC.Test.TestTimeStampedData Extends SC.Core.Data.TimeStampedData
{

/// Name
Property name As %String;

Storage Default
{
<Data name="TestTimeStampedDataDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>lastUpdatedTime</Value>
</Value>
<Value name="4">
<Value>recordCreatedTime</Value>
</Value>
</Data>
<DataLocation>^SC.Test.TestTimeStampedDataD</DataLocation>
<DefaultData>TestTimeStampedDataDefaultData</DefaultData>
<IdLocation>^SC.Test.TestTimeStampedDataD</IdLocation>
<IndexLocation>^SC.Test.TestTimeStampedDataI</IndexLocation>
<StreamLocation>^SC.Test.TestTimeStampedDataS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
