/// RECORDMAP: Generated from RecordMap 'EDICOM.out.PED'
/// on 2021-12-08 at 11:27:43.758 [2021-12-08 11:27:43.758 UTC]
/// by user _SYSTEM
Class EDICOM.out.PED.Record Extends (EnsLib.RecordMap.ComplexChild, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

/// num commande
Property riferimentoEP As %Integer;

/// ref commande client
Property riferimentoClient As %String(MAXLEN = "");

/// depuis cond paiement
Property descMessage As %String(MAXLEN = "");

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ##class(EDICOM.out.PED.Record).%OnDelete($$$oidForm({ID})) If $$$ISERR(%ok) Quit
}

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>riferimentoEP</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>descMessage</Value>
</Value>
<Value name="5">
<Value>riferimentoClient</Value>
</Value>
</Data>
<DataLocation>^EDICOM.out.PED.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^EDICOM.out.PED.RecordD</IdLocation>
<IndexLocation>^EDICOM.out.PED.RecordI</IndexLocation>
<StreamLocation>^EDICOM.out.PED.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
