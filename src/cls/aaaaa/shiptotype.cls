/// Créé à partir de: /data/XML/shiporder.xsd
Class aaaaa.shiptotype Extends (%Persistent, %XML.Adaptor) [ CompileAfter = aaaaa.stringtype, ProcedureBlock ]
{

Parameter XMLNAME = "shiptotype";

Parameter XMLSEQUENCE = 1;

Property name As aaaaa.stringtype(XMLNAME = "name") [ Required ];

Property address As aaaaa.stringtype(XMLNAME = "address") [ Required ];

Property city As aaaaa.stringtype(XMLNAME = "city") [ Required ];

Property country As aaaaa.stringtype(XMLNAME = "country") [ Required ];

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
<DataLocation>^aaaaa.shiptotypeD</DataLocation>
<DefaultData>shiptotypeDefaultData</DefaultData>
<IdLocation>^aaaaa.shiptotypeD</IdLocation>
<IndexLocation>^aaaaa.shiptotypeI</IndexLocation>
<StreamLocation>^aaaaa.shiptotypeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
