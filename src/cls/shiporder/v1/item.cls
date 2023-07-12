/// Créé à partir de: /data/XML/shiporder-v1.xsd
Class shiporder.v1.item Extends (%Persistent, %XML.Adaptor) [ ProcedureBlock ]
{

Parameter XMLNAME = "item";

Parameter XMLSEQUENCE = 1;

Property title As %String(MAXLEN = "", XMLNAME = "title") [ Required ];

Property note As %String(MAXLEN = "", XMLNAME = "note");

Property quantity As %xsd.positiveInteger(XMLNAME = "quantity") [ Required ];

Property price As %Numeric(XMLNAME = "price") [ Required ];

Relationship shiporder As shiporder.v1.shiporder(XMLPROJECTION = "NONE") [ Cardinality = one, Inverse = item ];

Storage Default
{
<Data name="itemDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>title</Value>
</Value>
<Value name="3">
<Value>note</Value>
</Value>
<Value name="4">
<Value>quantity</Value>
</Value>
<Value name="5">
<Value>price</Value>
</Value>
<Value name="6">
<Value>shiporder</Value>
</Value>
</Data>
<DataLocation>^shiporder.v1.itemD</DataLocation>
<DefaultData>itemDefaultData</DefaultData>
<IdLocation>^shiporder.v1.itemD</IdLocation>
<IndexLocation>^shiporder.v1.itemI</IndexLocation>
<StreamLocation>^shiporder.v1.itemS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
