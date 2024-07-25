/// THIS IS GENERATED CODE. DO NOT EDIT.<br/>
/// RECORDMAP: Generated from RecordMap 'projet.messages.RM.facture'
/// on 2024-07-25 at 17:43:05.875 [2024-07-25 16:43:05.875 UTC]
/// by user _SYSTEM
Class projet.messages.RM.facture.Record.Article4 Extends (%SerialObject, %XML.Adaptor) [ Inheritance = right, ProcedureBlock ]
{

Property Code As %String(MAXLEN = 6);

Property Description As %String(MAXLEN = "");

Property Quantite As %Integer;

Property PrixUnitaire As %Double(SCALE = 2);

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="Article4State">
<Value name="1">
<Value>Code</Value>
</Value>
<Value name="2">
<Value>Description</Value>
</Value>
<Value name="3">
<Value>Quantite</Value>
</Value>
<Value name="4">
<Value>NewField4</Value>
</Value>
<Value name="5">
<Value>PrixUnitaire</Value>
</Value>
</Data>
<State>Article4State</State>
<StreamLocation>^projet.messages.R6701.Article4S</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
