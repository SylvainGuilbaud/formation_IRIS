/// 
Class shiporder.v1.shiporder Extends (%Persistent, %XML.Adaptor) [ ProcedureBlock ]
{

Parameter XMLNAME = "shiporder";

Parameter XMLSEQUENCE = 1;

Property orderperson As %String(MAXLEN = "", XMLNAME = "orderperson") [ Required ];

Property shipto As shiporder.v1.shipto(XMLNAME = "shipto") [ Required ];

Relationship item As shiporder.v1.item(XMLNAME = "item", XMLPROJECTION = "ELEMENT") [ Cardinality = many, Inverse = shiporder ];

Property orderid As %String(MAXLEN = "", XMLNAME = "orderid", XMLPROJECTION = "ATTRIBUTE") [ Required ];

Storage Default
{
<Data name="shiporderDefaultData">
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
<DataLocation>^shiporder.v1.shiporderD</DataLocation>
<DefaultData>shiporderDefaultData</DefaultData>
<IdLocation>^shiporder.v1.shiporderD</IdLocation>
<IndexLocation>^shiporder.v1.shiporderI</IndexLocation>
<StreamLocation>^shiporder.v1.shiporderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
