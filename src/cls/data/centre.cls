Class data.centre Extends %Persistent
{

/// Description
Index IdKeyIndex On (APP, DD, NNN) [ IdKey ];

/// Nom de l'application utilisée par le centre
Property APP As %String;

/// n° du département du centre
Property DD As %Integer;

/// n° séquentiel dans le département
Property NNN As %Integer;

Property description As %String(MAXLEN = "");

ClassMethod create(APP As %String, DD As %Integer, description As %String) As %Status
{
    set a = ..%New()
    set a.APP = APP
    set a.DD = DD
    set a.NNN = $INCREMENT(^data.centreD(APP,DD))
    set a.description = description
    set sc = a.%Save()
    return sc
}

ClassMethod test(nb As %Integer = 10) As %Status
{
    for i=1:1:nb {
        set sc = ..create("departement",83,##class(%PopulateUtils).Mission())
    }
    zw ^data.centreD
    return sc
}

Storage Default
{
<Data name="centreDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>description</Value>
</Value>
</Data>
<DataLocation>^data.centreD</DataLocation>
<DefaultData>centreDefaultData</DefaultData>
<IdLocation>^data.centreD</IdLocation>
<IndexLocation>^data.centreI</IndexLocation>
<StreamLocation>^data.centreS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
