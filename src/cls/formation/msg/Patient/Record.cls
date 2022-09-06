/// RECORDMAP: Generated from RecordMap 'formation.msg.Patient'
/// on 2022-09-06 at 12:24:46.634 [2022-09-06 12:24:46.634 UTC]
/// by user _SYSTEM
Class formation.msg.Patient.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Nom As %String [ Required, SqlColumnNumber = 2 ];

Property Prenom As %String [ Required, SqlColumnNumber = 3 ];

Property DateNaissance As %Date(FORMAT = 4) [ Required, SqlColumnNumber = 4 ];

Property Sexe As %String(MAXLEN = 1) [ Required, SqlColumnNumber = 5 ];

Parameter RECORDMAPGENERATED = 1;

Index DateNaissanceIdx On DateNaissance;

Index SexeIdx On Sexe [ Type = bitmap ];

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nom</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>DateNaissance</Value>
</Value>
<Value name="5">
<Value>Sexe</Value>
</Value>
<Value name="6">
<Value>Prenom</Value>
</Value>
</Data>
<DataLocation>^formation.msg.Patient.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^formation.msg.Patient.RecordD</IdLocation>
<IndexLocation>^formation.msg.Patient.RecordI</IndexLocation>
<StreamLocation>^formation.msg.Patient.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
