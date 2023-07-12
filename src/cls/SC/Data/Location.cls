/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Location object can be used to store any kind of addresses, such as those for
/// supplier, customers, ship-to, ship-from, manufacturing plant, warehouses, etc. 
/// It can also be used to save any geo location with coordinates without an address.
Class SC.Data.Location Extends SC.Core.Data.Location
{

Storage Default
{
<Data name="LocationDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>recordCreatedTime</Value>
</Value>
<Value name="3">
<Value>lastUpdatedTime</Value>
</Value>
<Value name="4">
<Value>name</Value>
</Value>
<Value name="5">
<Value>type</Value>
</Value>
<Value name="6">
<Value>status</Value>
</Value>
<Value name="7">
<Value>street</Value>
</Value>
<Value name="8">
<Value>city</Value>
</Value>
<Value name="9">
<Value>stateProvince</Value>
</Value>
<Value name="10">
<Value>country</Value>
</Value>
<Value name="11">
<Value>postalCode</Value>
</Value>
<Value name="12">
<Value>coordinates</Value>
</Value>
<Value name="13">
<Value>latitude</Value>
</Value>
<Value name="14">
<Value>longitude</Value>
</Value>
<Value name="15">
<Value>gln</Value>
</Value>
<Value name="16">
<Value>uid</Value>
</Value>
<Value name="17">
<Value>stateProvinceIso2</Value>
</Value>
<Value name="18">
<Value>countryIso2</Value>
</Value>
<Value name="19">
<Value>countryIso3</Value>
</Value>
<Value name="20">
<Value>countryPhoneCode</Value>
</Value>
<Value name="21">
<Value>currencyIso3</Value>
</Value>
<Value name="22">
<Value>region</Value>
</Value>
<Value name="23">
<Value>subregion</Value>
</Value>
</Data>
<DataLocation>^SC.Data.LocationD</DataLocation>
<DefaultData>LocationDefaultData</DefaultData>
<IdLocation>^SC.Data.LocationD</IdLocation>
<IndexLocation>^SC.Data.LocationI</IndexLocation>
<StreamLocation>^SC.Data.LocationS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
