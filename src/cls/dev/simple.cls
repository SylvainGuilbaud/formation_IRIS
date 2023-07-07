Class User.simple Extends %Persistent
{

ClassMethod Hello(name As %String, ByRef message As %String) As %Status [ SqlProc ]
{
    Set sc = $$$OK
    set message = "Hello " _ name
    Return 1
}

Storage Default
{
<Data name="simpleDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<DataLocation>^User.simpleD</DataLocation>
<DefaultData>simpleDefaultData</DefaultData>
<IdLocation>^User.simpleD</IdLocation>
<IndexLocation>^User.simpleI</IndexLocation>
<StreamLocation>^User.simpleS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
