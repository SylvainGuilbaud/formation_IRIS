Class data.personne Extends %Persistent
{

Property Nom As %String;

Property Age As %Integer;

Property Ville As %String;

/// Description
ClassMethod insert() As %Status
{
    Set sc = $$$OK
    &sql(
        INSERT INTO data.personne (Nom, Age, Ville)
        SELECT nom, age, ville
        FROM JSON_TABLE(
        '{"personnes": [
            {"nom": "Dupont", "age": 30, "ville": "Paris"},
            {"nom": "Martin", "age": 25, "ville": "Lyon"}
        ]}',
        '$.personnes[*]'
        COLUMNS (
            nom VARCHAR(50) PATH '$.nom',
            age INTEGER PATH '$.age',
            ville VARCHAR(50) PATH '$.ville'
        )
        ) AS jt
    )
    Return sc
}

Storage Default
{
<Data name="personneDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nom</Value>
</Value>
<Value name="3">
<Value>Age</Value>
</Value>
<Value name="4">
<Value>Ville</Value>
</Value>
</Data>
<DataLocation>^data.personneD</DataLocation>
<DefaultData>personneDefaultData</DefaultData>
<IdLocation>^data.personneD</IdLocation>
<IndexLocation>^data.personneI</IndexLocation>
<StreamLocation>^data.personneS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
