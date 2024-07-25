/// THIS IS GENERATED CODE. DO NOT EDIT.<br/>
/// RECORDMAP: Generated from RecordMap 'projet.messages.RM.facture'
/// on 2024-07-25 at 12:17:17.614 [2024-07-25 11:17:17.614 UTC]
/// by user _SYSTEM
Class projet.messages.RM.facture.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Numérofacture As %String [ Required, SqlColumnNumber = 2 ];

Property Datefacture As %Date(FORMAT = 3) [ Required, SqlColumnNumber = 3 ];

Property Nomclient As %String(MAXLEN = "") [ SqlColumnNumber = 4 ];

Property Adresseclient As %String(MAXLEN = "") [ SqlColumnNumber = 5 ];

Property Codepostal As %String(MAXLEN = 9) [ SqlColumnNumber = 6 ];

Property Ville As %String(MAXLEN = "") [ SqlColumnNumber = 7 ];

Property Pays As %String(MAXLEN = "") [ SqlColumnNumber = 8 ];

Property Article1 As projet.messages.RM.facture.Record.Article1;

Property Article2 As projet.messages.RM.facture.Record.Article2;

Property Article3 As projet.messages.RM.facture.Record.Article3;

Property Article4 As projet.messages.RM.facture.Record.Article4;

Property Article5 As projet.messages.RM.facture.Record.Article5;

Property MontanttotalHT As %Double(SCALE = 2) [ SqlColumnNumber = 14 ];

Property TVA As %Decimal(SCALE = 2) [ SqlColumnNumber = 15 ];

Property MontanttotalTTC As %Double(SCALE = 2) [ SqlColumnNumber = 16 ];

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
<Value>Article1</Value>
</Value>
<Value name="10">
<Value>Article2</Value>
</Value>
<Value name="11">
<Value>Article3</Value>
</Value>
<Value name="12">
<Value>Article4</Value>
</Value>
<Value name="13">
<Value>Article5</Value>
</Value>
<Value name="14">
<Value>MontanttotalHT</Value>
</Value>
<Value name="15">
<Value>TVA</Value>
</Value>
<Value name="16">
<Value>MontanttotalTTC</Value>
</Value>
<Value name="17">
<Value>Datefacture</Value>
</Value>
</Data>
<DataLocation>^projet.messages.RM26B3.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^projet.messages.RM26B3.RecordD</IdLocation>
<IndexLocation>^projet.messages.RM26B3.RecordI</IndexLocation>
<StreamLocation>^projet.messages.RM26B3.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
