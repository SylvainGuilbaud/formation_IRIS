/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used for master data for suppliers. 
Class SC.Data.Supplier Extends SC.Core.Data.Supplier
{

Storage Default
{
<Data name="SupplierDefaultData">
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
<Value>dataSource</Value>
</Value>
<Value name="6">
<Value>sourceId</Value>
</Value>
<Value name="7">
<Value>primaryLocationId</Value>
</Value>
<Value name="8">
<Value>primaryPhone</Value>
</Value>
<Value name="9">
<Value>primaryContact</Value>
</Value>
<Value name="10">
<Value>url</Value>
</Value>
<Value name="11">
<Value>type</Value>
</Value>
<Value name="12">
<Value>status</Value>
</Value>
<Value name="13">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.SupplierD</DataLocation>
<DefaultData>SupplierDefaultData</DefaultData>
<IdLocation>^SC.Data.SupplierD</IdLocation>
<IndexLocation>^SC.Data.SupplierI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="dataSource">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="lastUpdatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="name">
<AverageFieldSize>19.3</AverageFieldSize>
<Selectivity>10.0000%</Selectivity>
</Property>
<Property name="primaryContact">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="primaryLocationId">
<AverageFieldSize>12.1</AverageFieldSize>
<Selectivity>10.0000%</Selectivity>
</Property>
<Property name="primaryPhone">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="recordCreatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="sourceId">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="status">
<AverageFieldSize>8</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="type">
<AverageFieldSize>11.2</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="uid">
<AverageFieldSize>10</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="url">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="uidIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^SC.Data.SupplierS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
