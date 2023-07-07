Class User.simple Extends (%Persistent, %Populate, %XML.Adaptor, %JSON.Adaptor)
{

// Index idKey On (name, dateNaissance, sex) [ IdKey ];

Index PK On (name, dateNaissance, sex) [ Unique ];

Index nameIdx On name;

Index sexIdx On sex [ Type = bitmap ];

Property name As %String [ InitialExpression = "zzzzzzzz" ];

Property name2 As %String(POPSPEC = "##class(User.simple).City()");

Property domicile As User.address;

Property notes As %DynamicObject;

ClassMethod City() As %String
{
 s t1=$lb("Grasse","Antibes","Opio","Nice")
 Quit $li(t1,$$$PRand($ll(t1))+1)
}

Property dateNaissance As %Date(FORMAT = 4);

Property dateDeces As %Date(FORMAT = 4);

Property sex As %Integer(DISPLAYLIST = ",homme,femme,inconnu,transgenre", VALUELIST = ",1,2,3,4");

ClassMethod Hello(name As %String, ByRef message As %String) As %Status
{
    Set sc = $$$OK
    set message = "Hello " _ name
    Return 1
}

Storage Default
{
<Data name="notes">
<Attribute>notes</Attribute>
<Structure>node</Structure>
<Subscript>"notes"</Subscript>
</Data>
<Data name="simpleDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>name2</Value>
</Value>
<Value name="4">
<Value>dateNaissance</Value>
</Value>
<Value name="5">
<Value>dateDeces</Value>
</Value>
<Value name="6">
<Value>sex</Value>
</Value>
<Value name="7">
<Value>domicile</Value>
</Value>
</Data>
<DataLocation>^User.simpleD</DataLocation>
<DefaultData>simpleDefaultData</DefaultData>
<IdLocation>^User.simpleD</IdLocation>
<IndexLocation>^User.simpleYYYYYYI</IndexLocation>
<StreamLocation>^User.simpleS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
