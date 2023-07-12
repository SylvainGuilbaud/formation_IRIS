/// Créé à partir de: /data/XML/shiporder-v2.xsd
Class shiporder.v2.itemtype Extends (%Persistent, %XML.Adaptor) [ CompileAfter = (shiporder.v2.dectype, shiporder.v2.inttype, shiporder.v2.stringtype), ProcedureBlock ]
{

Parameter XMLNAME = "itemtype";

Parameter XMLSEQUENCE = 1;

Property title As shiporder.v2.stringtype(XMLNAME = "title") [ Required ];

Property note As shiporder.v2.stringtype(XMLNAME = "note");

Property quantity As shiporder.v2.inttype(XMLNAME = "quantity") [ Required ];

Property price As shiporder.v2.dectype(XMLNAME = "price") [ Required ];

Relationship shipordertype As shiporder.v2.shipordertype(XMLPROJECTION = "NONE") [ Cardinality = one, Inverse = item ];

Storage Default
{
<Data name="itemtypeDefaultData">
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
<Value>shipordertype</Value>
</Value>
</Data>
<DataLocation>^shiporder.v2.itemtypeD</DataLocation>
<DefaultData>itemtypeDefaultData</DefaultData>
<IdLocation>^shiporder.v2.itemtypeD</IdLocation>
<IndexLocation>^shiporder.v2.itemtypeI</IndexLocation>
<StreamLocation>^shiporder.v2.itemtypeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
