/// Créé à partir de: /data/XML/shiporder.xsd
Class aaaaa.shipordertype Extends (%Persistent, %XML.Adaptor) [ CompileAfter = (aaaaa.orderidtype, aaaaa.stringtype), ProcedureBlock ]
{

Parameter XMLNAME = "shipordertype";

Parameter XMLSEQUENCE = 1;

Property orderperson As aaaaa.stringtype(XMLNAME = "orderperson") [ Required ];

Property shipto As aaaaa.shiptotype(XMLNAME = "shipto") [ Required ];

Relationship item As aaaaa.itemtype(XMLNAME = "item", XMLPROJECTION = "ELEMENT") [ Cardinality = many, Inverse = shipordertype ];

Property orderid As aaaaa.orderidtype(XMLNAME = "orderid", XMLPROJECTION = "ATTRIBUTE") [ Required ];

Storage Default
{
<Data name="shipordertypeDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>orderperson</Value>
</Value>
<Value name="3">
<Value>shipto</Value>
</Value>
<Value name="4">
<Value>orderid</Value>
</Value>
</Data>
<DataLocation>^aaaaa.shipordertypeD</DataLocation>
<DefaultData>shipordertypeDefaultData</DefaultData>
<IdLocation>^aaaaa.shipordertypeD</IdLocation>
<IndexLocation>^aaaaa.shipordertypeI</IndexLocation>
<StreamLocation>^aaaaa.shipordertypeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
