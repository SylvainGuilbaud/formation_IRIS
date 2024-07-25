/// THIS IS GENERATED CODE. DO NOT EDIT.<br/>
/// RECORDMAP: Generated from RecordMap 'messages.RM.factures'
/// on 2024-07-25 at 11:17:47.347 [2024-07-25 10:17:47.347 UTC]
/// by user _SYSTEM
Class messages.RM.factures.Record.Articles.Ref Extends (%SerialObject, %XML.Adaptor) [ Inheritance = right, ProcedureBlock ]
{

Property Code As %String(MAXLEN = "");

Property Description As %String(MAXLEN = "");

Property Quantite As %Integer;

Property PrixUnitaire As %Double(SCALE = 2);

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RefState">
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
<Value>PrixUnitaire</Value>
</Value>
</Data>
<State>RefState</State>
<StreamLocation>^messages.RM.factures.RFB71.RefS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
