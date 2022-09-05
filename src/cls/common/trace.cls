Class common.trace Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor, common.trace.utils)
{

Index KEY On (name, type, ts) [ IdKey ];

Property name As %String(MAXLEN = 250) [ SqlColumnNumber = 2 ];

Property type As %String [ SqlColumnNumber = 3 ];

Property ts As %TimeStamp [ InitialExpression = {$zdt($now(),3,,6)}, SqlColumnNumber = 5 ];

Property msg As %String(MAXLEN = "") [ SqlColumnNumber = 4 ];

Property content As array Of %String(MAXLEN = "");

Property errors As %Integer [ Calculated, SqlColumnNumber = 7, SqlComputeCode = { Set {errors}=##class(common.trace).getErrors({ID})}, SqlComputed ];

Property imported As %Integer [ Calculated, SqlColumnNumber = 6, SqlComputeCode = { Set {imported}=##class(common.trace).getImported({ID})}, SqlComputed ];

Property elapse As %Numeric [ Calculated, SqlColumnNumber = 9, SqlComputeCode = { Set {elapse}=##class(common.trace).getElapse({ID})}, SqlComputed ];

Property size As %Integer [ Calculated, SqlColumnNumber = 8, SqlComputeCode = { Set {size}=##class(common.trace).getSize({ID})}, SqlComputed ];

ClassMethod log(name As %String, type As %String, msg As %String, content As %ArrayOfDataTypes) As %Status
{
    set sc = $$$OK
    set a = ..%New()
    set a.name = name
    set a.type = type
    set a.msg = msg
    set key = ""
    if $Data(content) {
        for i=1:1:content.Count() {
            do a.content.SetAt(content.GetNext(.key),key)
        }
    }
    set sc = a.%Save()
    Return sc
}

/// Description
ClassMethod getImported(id As %String) As %Integer
{
    Set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        set response = a.content.GetAt("RESULT")
    }
    set:response="" response = 0
    Return response
}

ClassMethod getErrors(id As %String) As %Integer
{
    Set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        set response = a.content.GetAt("ERRORS")
    }
    set:response="" response = 0
    Return response
}

ClassMethod getElapse(id As %String) As %Numeric
{
    Set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        set response = a.content.GetAt("ELAPSE")
    }
    set:response="" response = 0
    Return response
}

ClassMethod getElapseMIN(id As %String) As %Numeric
{
    Set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        set response = a.content.GetAt("ELAPSE")
    }
    #; set:response="" response = 0
    Return response
}

ClassMethod getSize(id As %String) As %Numeric
{
    Set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        set response = a.content.GetAt("CONTENT SIZE")
    }
    set:response="" response = 0
    Return response
}

ClassMethod getSizeMIN(id As %String) As %Numeric
{
    Set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        set response = a.content.GetAt("CONTENT SIZE")
    }
    #; set:response="" response = 0
    Return response
}

Storage Default
{
<Data name="content">
<Attribute>content</Attribute>
<Structure>subnode</Structure>
<Subscript>"content"</Subscript>
</Data>
<Data name="traceDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>msg</Value>
</Value>
</Data>
<DataLocation>^common.traceD</DataLocation>
<DefaultData>traceDefaultData</DefaultData>
<IdLocation>^common.traceD</IdLocation>
<IndexLocation>^common.traceI</IndexLocation>
<StreamLocation>^common.traceS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
