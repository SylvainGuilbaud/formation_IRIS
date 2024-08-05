Class fromJSON.source.message Extends Ens.Request
{

Property content As %Stream.GlobalCharacter;

/// Test
ClassMethod test(filename As %String = "/data/json/personne.json", verbose As %Boolean = 1) As %Status
{
    Set sc = $$$OK

    set file=##class(%Stream.FileCharacter).%New()
	set sc=file.LinkToFile(filename)
    set source = ..%New() 
    do source.content.CopyFrom(file)
    write:verbose source.content.Read(),!
    do source.content.Rewind()

    set target = ##class(fromJSON.target.personne).%New()
    set sc = ##class(fromJSON.transfo.personne).Transform(source,target)

    zw target
    Return sc
}

/// Test Python
ClassMethod testPy(filename As %String = "/data/json/personne2.json", verbose As %Boolean = 1) As %Status
{
    Set sc = $$$OK

    set file=##class(%Stream.FileCharacter).%New()
	set sc=file.LinkToFile(filename)
    set source = ..%New() 
    do source.content.CopyFrom(file)
    write:verbose source.content.Read(),!
    do source.content.Rewind()

    set target = ##class(fromJSON.target.personne).%New()
    set sc = ##class(fromJSON.transfo.personne).TransformPy(source,target)

    zw target
    Return sc
}

Storage Default
{
<Data name="messageDefaultData">
<Subscript>"message"</Subscript>
<Value name="1">
<Value>content</Value>
</Value>
</Data>
<DefaultData>messageDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
