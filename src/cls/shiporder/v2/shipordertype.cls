/// Créé à partir de: /data/XML/shiporder-v2.xsd
Class shiporder.v2.shipordertype Extends (%Persistent, %XML.Adaptor) [ CompileAfter = (shiporder.v2.orderidtype, shiporder.v2.stringtype), ProcedureBlock ]
{

Parameter XMLNAME = "shipordertype";

Parameter XMLSEQUENCE = 1;

Property orderperson As shiporder.v2.stringtype(XMLNAME = "orderperson") [ Required ];

Property shipto As shiporder.v2.shiptotype(XMLNAME = "shipto") [ Required ];

Relationship item As shiporder.v2.itemtype(XMLNAME = "item", XMLPROJECTION = "ELEMENT") [ Cardinality = many, Inverse = shipordertype ];

Property orderid As shiporder.v2.orderidtype(XMLNAME = "orderid", XMLPROJECTION = "ATTRIBUTE") [ Required ];

}
