/// RECORDMAP: Generated from RecordMap 'formation.RM.patient'
/// on 2022-09-09 at 13:16:19.829 [2022-09-09 13:16:19.829 UTC]
/// by user _SYSTEM
Class formation.RM.patient.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Relationship Records As formation.RM.patient.Batch [ Cardinality = one, Inverse = Records ];

Parameter INCLUDETOPFIELDS = 1;

Property ID As %Integer [ SqlColumnNumber = 2 ];

Property DateNaissance As %Date(FORMAT = 4) [ SqlColumnNumber = 3 ];

Property Nom As %String(MAXLEN = 255) [ SqlColumnNumber = 4 ];

Property Prenom As %String(MAXLEN = 255) [ SqlColumnNumber = 5 ];

Property Sexe As %String [ SqlColumnNumber = 6 ];

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ID</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>Prenom</Value>
</Value>
<Value name="5">
<Value>DateNaissance</Value>
</Value>
<Value name="6">
<Value>Sexe</Value>
</Value>
<Value name="7">
<Value>Nom</Value>
</Value>
<Value name="8">
<Value>Records</Value>
</Value>
</Data>
<DataLocation>^formation.RM.patient.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^formation.RM.patient.RecordD</IdLocation>
<IndexLocation>^formation.RM.patient.RecordI</IndexLocation>
<StreamLocation>^formation.RM.patient.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

Parameter RECORDMAPGENERATED = 1;

}
