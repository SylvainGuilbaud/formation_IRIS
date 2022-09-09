/// RECORDMAP: Generated from RecordMap 'formation.RM.patient'
/// on 2022-09-09 at 11:11:14.849 [2022-09-09 11:11:14.849 UTC]
/// by user _SYSTEM
Class formation.RM.patient.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property ID As %String [ SqlColumnNumber = 2 ];

Property Nom As %String [ SqlColumnNumber = 3 ];

Property Prenom As %String [ SqlColumnNumber = 4 ];

Property DateNaissance As %String [ SqlColumnNumber = 5 ];

Property Sexe As %String [ SqlColumnNumber = 6 ];

Parameter RECORDMAPGENERATED = 1;

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
</Data>
<DataLocation>^formation.RM.patient.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^formation.RM.patient.RecordD</IdLocation>
<IndexLocation>^formation.RM.patient.RecordI</IndexLocation>
<StreamLocation>^formation.RM.patient.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
