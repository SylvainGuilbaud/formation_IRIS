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

}
