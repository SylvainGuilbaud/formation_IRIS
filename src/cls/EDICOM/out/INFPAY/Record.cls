/// RECORDMAP: Generated from RecordMap 'EDICOM.out.INFPAY'
/// on 2021-12-08 at 11:27:43.509 [2021-12-08 11:27:43.510 UTC]
/// by user _SYSTEM
Class EDICOM.out.INFPAY.Record Extends (EnsLib.RecordMap.ComplexChild, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

/// facture
Property condizioniDiPagamento As %String(MAXLEN = "");

Property TPXX As %String(MAXLEN = "");

/// depuis cond paiement
Property delaiPaiement As %Integer;

/// facture
Property dueDatePaiement As %Date(FORMAT = 8);

Property typeFacture As %String(MAXLEN = 1);

Property regimeFiscal As %String;

Property codeArticle As %String;

Property nature As %String(MAXLEN = "");

Property esegibilitaIVA As %String(MAXLEN = "");

Property referimentoNormativo As %String(MAXLEN = "");

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ##class(EDICOM.out.INFPAY.Record).%OnDelete($$$oidForm({ID})) If $$$ISERR(%ok) Quit
}

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>condizioniDiPagamento</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>delaiPaiement</Value>
</Value>
<Value name="5">
<Value>dueDatePaiement</Value>
</Value>
<Value name="6">
<Value>typeFacture</Value>
</Value>
<Value name="7">
<Value>regimeFiscal</Value>
</Value>
<Value name="8">
<Value>codeArticle</Value>
</Value>
<Value name="9">
<Value>nature</Value>
</Value>
<Value name="10">
<Value>esegibilitaIVA</Value>
</Value>
<Value name="11">
<Value>referimentoNormativo</Value>
</Value>
<Value name="12">
<Value>TPXX</Value>
</Value>
</Data>
<DataLocation>^EDICOM.out.INFPAY.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^EDICOM.out.INFPAY.RecordD</IdLocation>
<IndexLocation>^EDICOM.out.INFPAY.RecordI</IndexLocation>
<StreamLocation>^EDICOM.out.INFPAY.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
