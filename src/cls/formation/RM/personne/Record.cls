/// RECORDMAP: Generated from RecordMap 'formation.RM.personne'
/// on 2022-10-25 at 14:27:10.212 [2022-10-25 14:27:10.212 UTC]
/// by user _SYSTEM
Class formation.RM.personne.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base, %JSON.Adaptor, Grongier.JsonTraceViewer.Message) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property ID As %Integer [ SqlColumnNumber = 2 ];

Property DateNaissance As %Date(FORMAT = 4) [ SqlColumnNumber = 5 ];

Property Nom As %String(MAXLEN = 255) [ SqlColumnNumber = 3 ];

Property Prenom As %String(MAXLEN = 255) [ SqlColumnNumber = 4 ];

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
<Value name="9">
<Value>%ParentBatch</Value>
</Value>
</Data>
<DataLocation>^formation.RM.personne.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^formation.RM.personne.RecordD</IdLocation>
<IndexLocation>^formation.RM.personne.RecordI</IndexLocation>
<StreamLocation>^formation.RM.personne.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

Parameter RECORDMAPGENERATED = 1;

Relationship %ParentBatch As formation.RM.personne.Batch [ Cardinality = one, Inverse = Records ];

Index %ParentBatchIdx On %ParentBatch;

}
