/// Créé à partir de: /data/XML/shiporder-v1.xsd
Class shiporder.v1.shipto Extends (%Persistent, %XML.Adaptor) [ ProcedureBlock ]
{

Parameter XMLNAME = "shipto";

Parameter XMLSEQUENCE = 1;

Property name As %String(MAXLEN = "", XMLNAME = "name") [ Required ];

Property address As %String(MAXLEN = "", XMLNAME = "address") [ Required ];

Property city As %String(MAXLEN = "", XMLNAME = "city") [ Required ];

Property country As %String(MAXLEN = "", XMLNAME = "country") [ Required ];

}
