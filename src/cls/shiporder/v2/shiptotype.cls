/// Créé à partir de: /data/XML/shiporder-v2.xsd
Class shiporder.v2.shiptotype Extends (%Persistent, %XML.Adaptor) [ CompileAfter = shiporder.v2.stringtype, ProcedureBlock ]
{

Parameter XMLNAME = "shiptotype";

Parameter XMLSEQUENCE = 1;

Property name As shiporder.v2.stringtype(XMLNAME = "name") [ Required ];

Property address As shiporder.v2.stringtype(XMLNAME = "address") [ Required ];

Property city As shiporder.v2.stringtype(XMLNAME = "city") [ Required ];

Property country As shiporder.v2.stringtype(XMLNAME = "country") [ Required ];

}
