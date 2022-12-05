/// RECORDMAP: Generated from RecordMap 'EDICOM.out.CANT'
/// on 2021-12-08 at 11:27:43.955 [2021-12-08 11:27:43.955 UTC]
/// by user _SYSTEM
Class EDICOM.out.CANT.Record Extends (EnsLib.RecordMap.ComplexChild, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

/// facture
Property totalFacture As %Integer;

/// pourcentage IVA facture
Property pctIVA As %Integer;

/// depuis cond paiement
Property importoBaseLordo As %Integer;

/// pourcentage sc facture onto
Property pcptScFactureOnto As %Integer;

Property sconto As %Integer;

Property importoBaseNetto As %Integer;

Property montantIVA As %Integer;

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ##class(EDICOM.out.CANT.Record).%OnDelete($$$oidForm({ID})) If $$$ISERR(%ok) Quit
}

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>totalFacture</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>importoBaseLordo</Value>
</Value>
<Value name="5">
<Value>pcptScFactureOnto</Value>
</Value>
<Value name="6">
<Value>sconto</Value>
</Value>
<Value name="7">
<Value>importoBaseNetto</Value>
</Value>
<Value name="8">
<Value>montantIVA</Value>
</Value>
<Value name="9">
<Value>pctIVA</Value>
</Value>
</Data>
<DataLocation>^EDICOM.out.CANT.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^EDICOM.out.CANT.RecordD</IdLocation>
<IndexLocation>^EDICOM.out.CANT.RecordI</IndexLocation>
<StreamLocation>^EDICOM.out.CANT.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
