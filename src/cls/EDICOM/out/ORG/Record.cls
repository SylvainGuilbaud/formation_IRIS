/// RECORDMAP: Generated from RecordMap 'EDICOM.out.ORG'
/// on 2021-12-08 at 11:27:42.179 [2021-12-08 11:27:42.179 UTC]
/// by user _SYSTEM
Class EDICOM.out.ORG.Record Extends (EnsLib.RecordMap.ComplexChild, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property NomSociete As %String(MAXLEN = "");

Property adresseLigne1 As %String(MAXLEN = "");

Property adresseLigne2 As %String(MAXLEN = "");

Property adresseLigne3 As %String(MAXLEN = "");

Property CodePostal As %String;

Property Ville As %String(MAXLEN = "");

Property Pays As %String(MAXLEN = "");

Property PaysCode As %String;

Property NumTVA As %String;

Property facturationPour As %String(MAXLEN = "");

Property codeTVA As %String(MAXLEN = "");

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ##class(EDICOM.out.ORG.Record).%OnDelete($$$oidForm({ID})) If $$$ISERR(%ok) Quit
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
<Value>NumTVA</Value>
</Value>
<Value name="11">
<Value>facturationPour</Value>
</Value>
<Value name="12">
<Value>codeTVA</Value>
</Value>
<Value name="13">
<Value>adresseLigne1</Value>
</Value>
</Data>
<DataLocation>^EDICOM.out.ORG.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^EDICOM.out.ORG.RecordD</IdLocation>
<IndexLocation>^EDICOM.out.ORG.RecordI</IndexLocation>
<StreamLocation>^EDICOM.out.ORG.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
