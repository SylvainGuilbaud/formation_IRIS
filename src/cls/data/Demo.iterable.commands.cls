Class Demo.iterable.commands Extends (%Persistent, %Populate)
{

Property articles As array Of Demo.iterable.articles;

ClassMethod test() As %Status [ Language = python ]
{
    import iris
    commands = iris.cls('Demo.iterable.commands')._OpenId(1)
    for article in commands.articles:
        print(f'key:  {article.oref},  name: {article.Name}')
    # loop over items and key
    for key, article in commands.articles.items():
        print(f'key:  {key},  name: {article.Name}')
}

Storage Default
{
<Data name="articles">
<Attribute>articles</Attribute>
<Structure>subnode</Structure>
<Subscript>"articles"</Subscript>
</Data>
<Data name="commandsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<DataLocation>^Demo.iterable.commandsD</DataLocation>
<DefaultData>commandsDefaultData</DefaultData>
<IdLocation>^Demo.iterable.commandsD</IdLocation>
<IndexLocation>^Demo.iterable.commandsI</IndexLocation>
<StreamLocation>^Demo.iterable.commandsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
