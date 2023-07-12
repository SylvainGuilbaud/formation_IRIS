/// Créé à partir de: /data/XML/shiporder-v2.xsd
Class shiporder.v2.shiptotype Extends (%Persistent, %XML.Adaptor) [ CompileAfter = shiporder.v2.stringtype, ProcedureBlock ]
{

Parameter XMLNAME = "shiptotype";

Parameter XMLSEQUENCE = 1;

Property name As shiporder.v2.stringtype(XMLNAME = "name") [ Required ];

Property address As shiporder.v2.stringtype(XMLNAME = "address") [ Required ];

Property city As shiporder.v2.stringtype(XMLNAME = "city") [ Required ];

Property country As shiporder.v2.stringtype(XMLNAME = "country") [ Required ];

Storage Default
{
<Data name="shiptotypeDefaultData">
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
<DataLocation>^shiporder.v2.shiptotypeD</DataLocation>
<DefaultData>shiptotypeDefaultData</DefaultData>
<IdLocation>^shiporder.v2.shiptotypeD</IdLocation>
<IndexLocation>^shiporder.v2.shiptotypeI</IndexLocation>
<StreamLocation>^shiporder.v2.shiptotypeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
