Class data.patient Extends (%Persistent, %XML.Adaptor, %JSON.Adaptor, %Populate)
{

Property Nom As %String(MAXLEN = 255, POPSPEC = "LastName()") [ SqlColumnNumber = 2 ];

Property Prenom As %String(MAXLEN = 255, POPSPEC = "FirstName()") [ SqlColumnNumber = 3 ];

Property DateNaissance As %Date(FORMAT = 4) [ SqlColumnNumber = 4 ];

Property Sexe As %String(VALUELIST = ",M,F") [ SqlColumnNumber = 5 ];

Storage Default
{
<Data name="patientDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nom</Value>
</Value>
<Value name="3">
<Value>Prenom</Value>
</Value>
<Value name="4">
<Value>DateNaissance</Value>
</Value>
<Value name="5">
<Value>Sexe</Value>
</Value>
</Data>
<DataLocation>^data.patientD</DataLocation>
<DefaultData>patientDefaultData</DefaultData>
<IdLocation>^data.patientD</IdLocation>
<IndexLocation>^data.patientI</IndexLocation>
<StreamLocation>^data.patientS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
