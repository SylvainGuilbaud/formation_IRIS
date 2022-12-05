/// RECORDMAP: Modified during compilation of RecordMap 'RM.salaire1'
/// on 2022-08-19 at 16:11:04.895 [2022-08-19 16:11:04.895 UTC]
/// by user _SYSTEM
Class formation.RM.patient.Batch Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch) [ Inheritance = right, ProcedureBlock ]
{

Parameter XMLNAME = "patientBatch";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader = "ID;DateNaissance;Nom;Prenom;Sexe";

Parameter HeaderTerm = "\x0a";

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As formation.RM.patient.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "patientBatchOut";

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
<DataLocation>^formation.RM.patient.BatchD</DataLocation>
<DefaultData>BatchDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^formation.RM.patient.BatchD</IdLocation>
<IndexLocation>^formation.RM.patient.BatchI</IndexLocation>
<StreamLocation>^formation.RM.patient.BatchS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
