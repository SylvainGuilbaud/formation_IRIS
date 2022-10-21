/// 
Class shiporder.v1.shiporder Extends (%Persistent, %XML.Adaptor) [ ProcedureBlock ]
{

Parameter XMLNAME = "shiporder";

Parameter XMLSEQUENCE = 1;

Property orderperson As %String(MAXLEN = "", XMLNAME = "orderperson") [ Required ];

Property shipto As shiporder.v1.shipto(XMLNAME = "shipto") [ Required ];

Relationship item As shiporder.v1.item(XMLNAME = "item", XMLPROJECTION = "ELEMENT") [ Cardinality = many, Inverse = shiporder ];

Property orderid As %String(MAXLEN = "", XMLNAME = "orderid", XMLPROJECTION = "ATTRIBUTE") [ Required ];

}
