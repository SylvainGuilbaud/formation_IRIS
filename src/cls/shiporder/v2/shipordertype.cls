/// Créé à partir de: /data/XML/shiporder-v2.xsd
Class shiporder.v2.shipordertype Extends (%Persistent, %XML.Adaptor) [ CompileAfter = (shiporder.v2.orderidtype, shiporder.v2.stringtype), ProcedureBlock ]
{

Parameter XMLNAME = "shipordertype";

Parameter XMLSEQUENCE = 1;

Property orderperson As shiporder.v2.stringtype(XMLNAME = "orderperson") [ Required ];

Property shipto As shiporder.v2.shiptotype(XMLNAME = "shipto") [ Required ];

Relationship item As shiporder.v2.itemtype(XMLNAME = "item", XMLPROJECTION = "ELEMENT") [ Cardinality = many, Inverse = shipordertype ];

Property orderid As shiporder.v2.orderidtype(XMLNAME = "orderid", XMLPROJECTION = "ATTRIBUTE") [ Required ];

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
<DataLocation>^shiporder.v2.shipordertypeD</DataLocation>
<DefaultData>shipordertypeDefaultData</DefaultData>
<IdLocation>^shiporder.v2.shipordertypeD</IdLocation>
<IndexLocation>^shiporder.v2.shipordertypeI</IndexLocation>
<StreamLocation>^shiporder.v2.shipordertypeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
