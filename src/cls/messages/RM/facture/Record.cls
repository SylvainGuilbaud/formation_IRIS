/// THIS IS GENERATED CODE. DO NOT EDIT.<br/>
/// RECORDMAP: Generated from RecordMap 'messages.RM.facture'
/// on 2024-07-25 at 09:42:21.588 [2024-07-25 08:42:21.588 UTC]
/// by user _SYSTEM
Class messages.RM.facture.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Numérofacture As %String [ Required, SqlColumnNumber = 2 ];

Property Datefacture As %Date(FORMAT = 4) [ Required, SqlColumnNumber = 3 ];

Property Nomclient As %String(MAXLEN = "") [ Required, SqlColumnNumber = 4 ];

Property Adresseclient As %String(MAXLEN = "") [ SqlColumnNumber = 5 ];

Property Codepostal As %String(MAXLEN = 9) [ SqlColumnNumber = 6 ];

Property Ville As %String(MAXLEN = "") [ SqlColumnNumber = 7 ];

Property Pays As %String(MAXLEN = "") [ SqlColumnNumber = 8 ];

Property Articles As %String(MAXLEN = "") [ SqlColumnNumber = 9 ];

Property MontanttotalHT As %Double [ SqlColumnNumber = 10 ];

Property TVA As %Decimal [ SqlColumnNumber = 11 ];

Property MontanttotalTTC As %Double [ SqlColumnNumber = 12 ];

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Numérofacture</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>Nomclient</Value>
</Value>
<Value name="5">
<Value>Adresseclient</Value>
</Value>
<Value name="6">
<Value>Codepostal</Value>
</Value>
<Value name="7">
<Value>Ville</Value>
</Value>
<Value name="8">
<Value>Pays</Value>
</Value>
<Value name="9">
<Value>Articles</Value>
</Value>
<Value name="10">
<Value>MontanttotalHT</Value>
</Value>
<Value name="11">
<Value>TVA</Value>
</Value>
<Value name="12">
<Value>MontanttotalTTC</Value>
</Value>
<Value name="13">
<Value>Datefacture</Value>
</Value>
</Data>
<DataLocation>^messages.RM.facture.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^messages.RM.facture.RecordD</IdLocation>
<IndexLocation>^messages.RM.facture.RecordI</IndexLocation>
<StreamLocation>^messages.RM.facture.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
