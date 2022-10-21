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

}
