/// RECORDMAP: Generated from RecordMap 'EDICOM.out.LIN'
/// on 2021-12-08 at 11:27:44.562 [2021-12-08 11:27:44.562 UTC]
/// by user _SYSTEM
Class EDICOM.out.LIN.Record Extends (EnsLib.RecordMap.ComplexChild, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

/// numéro de commande EP
Property numCdeEP As %Integer;

/// ref externe produit
Property refClient As %Integer;

/// Internal
Property typeVente As %String;

Property description As %String(MAXLEN = "");

Property QTY As %Numeric;

/// Kg, etc.
Property unitMesure As %String;

Property unitPrice As %Numeric;

Property totalPrice As %Numeric;

Property refCdeCli As %String(MAXLEN = "");

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ##class(EDICOM.out.LIN.Record).%OnDelete($$$oidForm({ID})) If $$$ISERR(%ok) Quit
}

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>numCdeEP</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>typeVente</Value>
</Value>
<Value name="5">
<Value>description</Value>
</Value>
<Value name="6">
<Value>QTY</Value>
</Value>
<Value name="7">
<Value>unitMesure</Value>
</Value>
<Value name="8">
<Value>unitPrice</Value>
</Value>
<Value name="9">
<Value>totalPrice</Value>
</Value>
<Value name="10">
<Value>refCdeCli</Value>
</Value>
<Value name="11">
<Value>refClient</Value>
</Value>
</Data>
<DataLocation>^EDICOM.out.LIN.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^EDICOM.out.LIN.RecordD</IdLocation>
<IndexLocation>^EDICOM.out.LIN.RecordI</IndexLocation>
<StreamLocation>^EDICOM.out.LIN.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
