/// RECORDMAP: Generated from RecordMap 'EDICOM.out.NUMLIN'
/// on 2021-12-08 at 11:27:44.376 [2021-12-08 11:27:44.376 UTC]
/// by user _SYSTEM
Class EDICOM.out.NUMLIN.Record Extends (EnsLib.RecordMap.ComplexChild, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

/// nombre de lignes de détail factures
Property nombreLignes As %Integer;

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ##class(EDICOM.out.NUMLIN.Record).%OnDelete($$$oidForm({ID})) If $$$ISERR(%ok) Quit
}

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>nombreLignes</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
</Data>
<DataLocation>^EDICOM.out.NUMLIN.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^EDICOM.out.NUMLIN.RecordD</IdLocation>
<IndexLocation>^EDICOM.out.NUMLIN.RecordI</IndexLocation>
<StreamLocation>^EDICOM.out.NUMLIN.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
