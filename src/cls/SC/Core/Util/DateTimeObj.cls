/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Util.DateTimeObj Extends (%Persistent, %JSON.Adaptor)
{

Property dateField As %Date;

Property dateTimeField As %DateTime;

Property timeStampField As %TimeStamp;

/// Convert a date time string in JSON supported format to a DateTime value. Returns "" if the
/// string is not valid.
ClassMethod getDateTimeFromJsonString(dateTimeString As %String) As %DateTime
{
    set obj = ##class(SC.Core.Util.DateTimeObj).%New()
    set json = {"dateTimeField": (dateTimeString)}
    set sc = obj.%JSONImport(json)
    if $$$ISOK(sc) {
        return obj.dateTimeField
    }
    else {
        return ""
    }
}

/// Convert a date string to a Date value, using the JSON date format. Valid values are: YYYY-MM-DD
ClassMethod getDateFromJsonString(dateString As %String) As %Date
{
    set obj = ##class(SC.Core.Util.DateTimeObj).%New()
    set json = {"dateField": (dateString)}
    set sc = obj.%JSONImport(json)
    if $$$ISOK(sc) {
        return obj.dateField
    }
    else {
        return ""
    }
}

Storage Default
{
<Data name="DateTimeObjDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>dateField</Value>
</Value>
<Value name="3">
<Value>dateTimeField</Value>
</Value>
<Value name="4">
<Value>timeStampField</Value>
</Value>
</Data>
<DataLocation>^SC.Core.Util.DateTimeObjD</DataLocation>
<DefaultData>DateTimeObjDefaultData</DefaultData>
<IdLocation>^SC.Core.Util.DateTimeObjD</IdLocation>
<IndexLocation>^SC.Core.Util.DateTimeObjI</IndexLocation>
<StreamLocation>^SC.Core.Util.DateTimeObjS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
