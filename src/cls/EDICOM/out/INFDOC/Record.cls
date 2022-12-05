/// RECORDMAP: Generated from RecordMap 'EDICOM.out.INFDOC'
/// on 2021-12-08 at 11:27:43.249 [2021-12-08 11:27:43.249 UTC]
/// by user _SYSTEM
Class EDICOM.out.INFDOC.Record Extends (EnsLib.RecordMap.ComplexChild, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

/// num facture
Property numDocument As %String(MAXLEN = "") [ Required ];

/// date expédition
Property dateDocument As %Date(FORMAT = 8);

/// date d'expédition
Property dateExpedition As %Date(FORMAT = 8);

/// Bon livraison associé à la facture
Property numBL As %String(MAXLEN = "");

/// num TVA du client sur facture
Property PIVA As %String;

/// sur facture champ devisa
Property devise As %String(MAXLEN = "");

/// code compta pragma client
Property codeClient As %String(MAXLEN = "");

/// sur fiche commande champ transporteur
Property transporteur As %String(MAXLEN = "");

/// facture
Property condizioniDiPagamento As %String(MAXLEN = "");

Property TPXX As %String;

/// depuis cond paiement
Property delaiPaiement As %String;

/// facture
Property dueDatePaiement As %String(MAXLEN = "");

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ##class(EDICOM.out.INFDOC.Record).%OnDelete($$$oidForm({ID})) If $$$ISERR(%ok) Quit
}

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>numDocument</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>dateExpedition</Value>
</Value>
<Value name="5">
<Value>numBL</Value>
</Value>
<Value name="6">
<Value>PIVA</Value>
</Value>
<Value name="7">
<Value>devise</Value>
</Value>
<Value name="8">
<Value>codeClient</Value>
</Value>
<Value name="9">
<Value>transporteur</Value>
</Value>
<Value name="10">
<Value>condizioniDiPagamento</Value>
</Value>
<Value name="11">
<Value>TPXX</Value>
</Value>
<Value name="12">
<Value>delaiPaiement</Value>
</Value>
<Value name="13">
<Value>dueDatePaiement</Value>
</Value>
<Value name="14">
<Value>dateDocument</Value>
</Value>
</Data>
<DataLocation>^EDICOM.out.INFDOC.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^EDICOM.out.INFDOC.RecordD</IdLocation>
<IndexLocation>^EDICOM.out.INFDOC.RecordI</IndexLocation>
<StreamLocation>^EDICOM.out.INFDOC.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
