/// RECORDMAP: Generated from RecordMap 'EDICOM.out.BANQ'
/// on 2021-12-08 at 11:27:44.174 [2021-12-08 11:27:44.174 UTC]
/// by user _SYSTEM
Class EDICOM.out.BANQ.Record Extends (EnsLib.RecordMap.ComplexChild, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

/// facture
Property banquePaiement As %String(MAXLEN = "");

Property IBAN As %String;

Property BIC As %String;

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ##class(EDICOM.out.BANQ.Record).%OnDelete($$$oidForm({ID})) If $$$ISERR(%ok) Quit
}

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>banquePaiement</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>BIC</Value>
</Value>
<Value name="5">
<Value>IBAN</Value>
</Value>
</Data>
<DataLocation>^EDICOM.out.BANQ.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^EDICOM.out.BANQ.RecordD</IdLocation>
<IndexLocation>^EDICOM.out.BANQ.RecordI</IndexLocation>
<StreamLocation>^EDICOM.out.BANQ.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
