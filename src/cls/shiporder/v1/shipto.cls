/// Créé à partir de: /data/XML/shiporder-v1.xsd
Class shiporder.v1.shipto Extends (%Persistent, %XML.Adaptor) [ ProcedureBlock ]
{

Parameter XMLNAME = "shipto";

Parameter XMLSEQUENCE = 1;

Property name As %String(MAXLEN = "", XMLNAME = "name") [ Required ];

Property address As %String(MAXLEN = "", XMLNAME = "address") [ Required ];

Property city As %String(MAXLEN = "", XMLNAME = "city") [ Required ];

Property country As %String(MAXLEN = "", XMLNAME = "country") [ Required ];

Storage Default
{
<Data name="shiptoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>address</Value>
</Value>
<Value name="4">
<Value>city</Value>
</Value>
<Value name="5">
<Value>country</Value>
</Value>
</Data>
<DataLocation>^shiporder.v1.shiptoD</DataLocation>
<DefaultData>shiptoDefaultData</DefaultData>
<IdLocation>^shiporder.v1.shiptoD</IdLocation>
<IndexLocation>^shiporder.v1.shiptoI</IndexLocation>
<StreamLocation>^shiporder.v1.shiptoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
