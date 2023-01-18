Class data.test Extends (%Persistent, %XML.Adaptor, %JSON.Adaptor, %Populate) [ ClassType = persistent ]
{

Parameter IDPROPERTY = "String";

Property MT As %String;

Property String As %String(MAXLEN = "", POPSPEC = "Mission()");

Property BStream As %Stream.GlobalBinary(POPSPEC = "##class(data.test).BStreamPop()");

Property CStream As %Stream.GlobalCharacter(POPSPEC = "##class(data.test).CStreamPop()");

Property Numeric As %Numeric;

Property Integer As %Integer;

Property Float As %Float;

Property Double As %Double;

Property Date As %Date;

Property Timestamp As %TimeStamp;

Property Boolean As %Boolean;

Property extension As %String [ InitialExpression = "svg" ];

Property created As %TimeStamp [ InitialExpression = {$zdt($now(),3,,6)} ];

Index StringIndex On String;

Index BStreamIndex On BStream;

Index CStreamIndex On CStream;

Index NumericIndex On Numeric;

Index IntegerIndex On Integer;

Index FloatIndex On Float;

Index DoubleIndex On Double;

Index DateIndex On Date;

Index TimestampIndex On Timestamp;

Index BooleanIndex On Boolean;

ClassMethod add(filename As %String = "") As %Status
{
    set sc=$$$OK
    Try {
        // default value if filename parameter is null
        set:filename="" filename = $system.Util.DataDirectory()_"docs/copyright.pdf"
        if ##class(%File).Exists(filename) {
            set a = ..%New()
            set a.String = $random(10000) _ $PIECE(filename,"/",*)
            set a.extension = $PIECE(a.String,".",*)
            set file=##class(%Stream.FileBinary).%New()
            set sc=file.LinkToFile(filename)
            do a.BStream.CopyFrom(file)
            do a.CStream.Write("<hello>\0é&&&éooiiàçç?%^$$*```£€$$$@#</hello>")
            set a.Numeric = a.BStream.Size
            set a.Integer = a.BStream.Size
            set a.Float = a.BStream.Size
            set a.Double = a.BStream.Size
            set a.Date = +$H
            set a.Timestamp = $zdt($h,3)
            set a.Boolean = 1
            set sc = a.%Save()
        } else {
            set sc = $system.Status.Error("5001",filename _ " doesn't exist")
        }
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    
    return sc
}

ClassMethod BStreamPop() As %Stream.GlobalBinary
{
    set file=##class(%Stream.FileBinary).%New()
    #; set filename=$system.Util.DataDirectory()_"docs/copyright.pdf"
    set filename=$system.Util.DataDirectory()_"docs/images/classroom2.svg"
	set sc=file.LinkToFile(filename)
    set stream=##class(%Stream.GlobalBinary).%New()
    do stream.CopyFrom(file)
    return stream
}

ClassMethod CStreamPop() As %Stream.GlobalCharacter
{
    set file=##class(%Stream.FileCharacter).%New()
    set filename=$system.Util.InstallDirectory()_"iris.cpf"
	set sc=file.LinkToFile(filename)
    set stream=##class(%Stream.GlobalCharacter).%New()
    do stream.CopyFrom(file)
    return stream
}

ClassMethod extractBinary(id As %Integer, extension As %String = "pdf", directory As %String = "tmp") As %Status
{
    set sc=$$$OK
    if ..%ExistsId(id) {
        set data=..%OpenId(id)
        set directory=##class(%File).NormalizeDirectory($system.Util.DataDirectory()_directory)
        do:'##class(%File).DirectoryExists(directory) ##class(%File).CreateDirectoryChain(directory)
        set filename=directory_id_"_BStream."_extension
        set file=##class(%Stream.FileBinary).%New()
        set sc= file.LinkToFile(filename)
        set sc=file.CopyFrom(data.BStream)
        set sc=file.%Save()
        write:sc filename," successfully extracted (",data.BStream.Size,")",file.Size,!
    } else {
        set sc=$SYSTEM.Status.Error(5001,id_" doesn't exist")
    }
    return sc
}

ClassMethod extractCharacter(id As %Integer, extension As %String = "txt", directory As %String = "tmp") As %Status
{
    set sc=$$$OK
    if ..%ExistsId(id) {
        set data=..%OpenId(id)
        set directory=##class(%File).NormalizeDirectory($system.Util.DataDirectory()_directory)
        do:'##class(%File).DirectoryExists(directory) ##class(%File).CreateDirectoryChain(directory)
        set filename=directory_id_"_CStream."_extension
        set file=##class(%Stream.FileCharacter).%New()
        set sc= file.LinkToFile(filename)
        set sc=file.CopyFrom(data.CStream)
        set sc=file.%Save()
        write:sc filename," successfully extracted (",data.CStream.Size,")",file.Size,!
    } else {
        set sc=$SYSTEM.Status.Error(5001,id_" doesn't exist")
    }
    return sc
}

Storage Default
{
<Data name="testDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>String</Value>
</Value>
<Value name="3">
<Value>BStream</Value>
</Value>
<Value name="4">
<Value>CStream</Value>
</Value>
<Value name="5">
<Value>Numeric</Value>
</Value>
<Value name="6">
<Value>Integer</Value>
</Value>
<Value name="7">
<Value>Float</Value>
</Value>
<Value name="8">
<Value>Double</Value>
</Value>
<Value name="9">
<Value>Date</Value>
</Value>
<Value name="10">
<Value>Timestamp</Value>
</Value>
<Value name="11">
<Value>Boolean</Value>
</Value>
<Value name="12">
<Value>extension</Value>
</Value>
<Value name="13">
<Value>created</Value>
</Value>
<Value name="14">
<Value>MT</Value>
</Value>
</Data>
<DataLocation>^data.testD</DataLocation>
<DefaultData>testDefaultData</DefaultData>
<IdLocation>^data.testD</IdLocation>
<IndexLocation>^data.testI</IndexLocation>
<StreamLocation>^data.testS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
