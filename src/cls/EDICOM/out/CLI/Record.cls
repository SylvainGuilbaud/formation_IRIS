/// RECORDMAP: Generated from RecordMap 'EDICOM.out.CLI'
/// on 2021-12-08 at 11:27:42.973 [2021-12-08 11:27:42.973 UTC]
/// by user _SYSTEM
Class EDICOM.out.CLI.Record Extends (EnsLib.RecordMap.ComplexChild, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property NomSociete As %String(MAXLEN = "") [ Required ];

Property adresseLigne1 As %String(MAXLEN = "");

Property adresseLigne2 As %String(MAXLEN = "");

Property adresseLigne3 As %String(MAXLEN = "");

Property CodePostal As %String;

Property Ville As %String(MAXLEN = "");

Property Pays As %String(MAXLEN = "");

Property PaysCode As %String;

Property infoTVA As %String(MAXLEN = "");

Property codeSDI As %String;

Property codePEC As %String;

Property PECEMAIL As %String(MAXLEN = "");

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ##class(EDICOM.out.CLI.Record).%OnDelete($$$oidForm({ID})) If $$$ISERR(%ok) Quit
}

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>NomSociete</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>adresseLigne2</Value>
</Value>
<Value name="5">
<Value>adresseLigne3</Value>
</Value>
<Value name="6">
<Value>CodePostal</Value>
</Value>
<Value name="7">
<Value>Ville</Value>
</Value>
<Value name="8">
<Value>Pays</Value>
</Value>
<Value name="9">
<Value>PaysCode</Value>
</Value>
<Value name="10">
<Value>infoTVA</Value>
</Value>
<Value name="11">
<Value>codeSDI</Value>
</Value>
<Value name="12">
<Value>codePEC</Value>
</Value>
<Value name="13">
<Value>PECEMAIL</Value>
</Value>
<Value name="14">
<Value>adresseLigne1</Value>
</Value>
</Data>
<DataLocation>^EDICOM.out.CLI.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^EDICOM.out.CLI.RecordD</IdLocation>
<IndexLocation>^EDICOM.out.CLI.RecordI</IndexLocation>
<StreamLocation>^EDICOM.out.CLI.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
