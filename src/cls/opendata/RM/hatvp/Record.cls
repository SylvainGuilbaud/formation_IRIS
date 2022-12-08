/// RECORDMAP: Generated from RecordMap 'opendata.RM.hatvp'
/// on 2022-12-08 at 11:16:27.726 [2022-12-08 11:16:27.726 UTC]
/// by user _SYSTEM
Class opendata.RM.hatvp.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property civilite As %String [ SqlColumnNumber = 2 ];

Property prenom As %String [ SqlColumnNumber = 3 ];

Property nom As %String [ SqlColumnNumber = 4 ];

Property classement As %String [ SqlColumnNumber = 5 ];

Property typemandat As %String [ SqlColumnNumber = 6 ];

Property qualite As %String [ SqlColumnNumber = 7 ];

Property typedocument As %String [ SqlColumnNumber = 8 ];

Property departement As %String [ SqlColumnNumber = 9 ];

Property datepublication As %Date(FORMAT = 3) [ SqlColumnNumber = 10 ];

Property datedepot As %Date(FORMAT = 3) [ SqlColumnNumber = 11 ];

Property nomfichier As %String [ SqlColumnNumber = 12 ];

Property urldossier As %String [ SqlColumnNumber = 13 ];

Property opendata As %String [ SqlColumnNumber = 14 ];

Property statutpublication As %String [ SqlColumnNumber = 15 ];

Property idorigine As %String [ SqlColumnNumber = 16 ];

Property urlphoto As opendata.RM.hatvp.Record.urlphoto;

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>civilite</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>nom</Value>
</Value>
<Value name="5">
<Value>classement</Value>
</Value>
<Value name="6">
<Value>typemandat</Value>
</Value>
<Value name="7">
<Value>qualite</Value>
</Value>
<Value name="8">
<Value>typedocument</Value>
</Value>
<Value name="9">
<Value>departement</Value>
</Value>
<Value name="10">
<Value>datepublication</Value>
</Value>
<Value name="11">
<Value>datedepot</Value>
</Value>
<Value name="12">
<Value>nomfichier</Value>
</Value>
<Value name="13">
<Value>urldossier</Value>
</Value>
<Value name="14">
<Value>opendata</Value>
</Value>
<Value name="15">
<Value>statutpublication</Value>
</Value>
<Value name="16">
<Value>idorigine</Value>
</Value>
<Value name="17">
<Value>urlphoto</Value>
</Value>
<Value name="18">
<Value>prenom</Value>
</Value>
</Data>
<DataLocation>^opendata.RM.hatvp.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^opendata.RM.hatvp.RecordD</IdLocation>
<IndexLocation>^opendata.RM.hatvp.RecordI</IndexLocation>
<StreamLocation>^opendata.RM.hatvp.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
