Class DC.TextData Extends %Persistent
{

Property Comment As %Text(LANGUAGECLASS = "%Text.English", MAXLEN = 1000);

/// Description
ClassMethod init() As %Status
{
    Set sc = $$$OK
    
    do ##class(DC.TextData).%KillExtentData()

    set tt=##class(DC.TextData).%New(),tt.Comment="Notice, time is money." w tt.%Save()
    set tt=##class(DC.TextData).%New(),tt.Comment="It's time for a break." w tt.%Save()
    set tt=##class(DC.TextData).%New(),tt.Comment="There is no business like show business." w tt.%Save()
   
    return sc
}

Storage Default
{
<Data name="TextDataDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Comment</Value>
</Value>
</Data>
<DataLocation>^DC.TextDataD</DataLocation>
<DefaultData>TextDataDefaultData</DefaultData>
<IdLocation>^DC.TextDataD</IdLocation>
<IndexLocation>^DC.TextDataI</IndexLocation>
<StreamLocation>^DC.TextDataS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
