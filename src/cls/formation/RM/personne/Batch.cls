/// RECORDMAP: Modified during compilation of RecordMap 'formation.RM.personne'
/// on 2022-10-25 at 14:27:10.232 [2022-10-25 14:27:10.232 UTC]
/// by user _SYSTEM
Class formation.RM.personne.Batch Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch, Grongier.JsonTraceViewer.Message) [ Inheritance = right, ProcedureBlock ]
{

Parameter XMLNAME = "personneBatch";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader = "ID;DateNaissance;Nom;Prenom;Sexe";

Parameter HeaderTerm = "\x0a";

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As formation.RM.personne.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "personneBatchOut";

Storage Default
{
<Data name="BatchDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>%Source</Value>
</Value>
<Value name="3">
<Value>BatchHeader</Value>
</Value>
<Value name="4">
<Value>BatchTrailer</Value>
</Value>
</Data>
<DataLocation>^formation.RM.personne.BatchD</DataLocation>
<DefaultData>BatchDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^formation.RM.personne.BatchD</IdLocation>
<IndexLocation>^formation.RM.personne.BatchI</IndexLocation>
<StreamLocation>^formation.RM.personne.BatchS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
