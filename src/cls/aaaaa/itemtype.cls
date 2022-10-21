/// Créé à partir de: /data/XML/shiporder.xsd
Class aaaaa.itemtype Extends (%Persistent, %XML.Adaptor) [ CompileAfter = (aaaaa.dectype, aaaaa.inttype, aaaaa.stringtype), ProcedureBlock ]
{

Parameter XMLNAME = "itemtype";

Parameter XMLSEQUENCE = 1;

Property title As aaaaa.stringtype(XMLNAME = "title") [ Required ];

Property note As aaaaa.stringtype(XMLNAME = "note");

Property quantity As aaaaa.inttype(XMLNAME = "quantity") [ Required ];

Property price As aaaaa.dectype(XMLNAME = "price") [ Required ];

Relationship shipordertype As aaaaa.shipordertype(XMLPROJECTION = "NONE") [ Cardinality = one, Inverse = item ];

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
<DataLocation>^aaaaa.itemtypeD</DataLocation>
<DefaultData>itemtypeDefaultData</DefaultData>
<IdLocation>^aaaaa.itemtypeD</IdLocation>
<IndexLocation>^aaaaa.itemtypeI</IndexLocation>
<StreamLocation>^aaaaa.itemtypeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
