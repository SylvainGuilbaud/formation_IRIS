Class My.Person Extends %Persistent
{

Property Name As %Name;

Property Address As My.Address;

/// Description
ClassMethod insert() As %Status
{
    Set sc = $$$OK
    set address = ##class(My.Address).%New()
    set address.Country = "France"
    set address.City = "Marseille"
    set person = ##class(My.Person).%New()
    set person.Address = address
    set person.Name = "Quouinaut, Martin"
    do person.%Save()    
    Return sc
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Address</Value>
</Value>
</Data>
<DataLocation>^My.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^My.PersonD</IdLocation>
<IndexLocation>^My.PersonI</IndexLocation>
<StreamLocation>^My.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
