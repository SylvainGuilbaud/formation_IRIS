Include common

Class common.trace Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor, common.trace.utils)
{

Index nameIndex On name;

Index typeIndex On type;

Index tsIndex On ts;

Index dayIndex On day [ Type = bitmap ];

Index initIndex On init [ Type = bitmap ];

Property name As %String(MAXLEN = 250);

Property type As %String(MAXLEN = 250);

Property ts As %TimeStamp [ InitialExpression = {$zdt($now(),3,,6)} ];

Property day As %Date(FORMAT = 3) [ InitialExpression = {$h+0} ];

Property msg As %String(MAXLEN = "");

Property content As array Of %String(MAXLEN = "");

Property errorsOnSave As %Integer [ Calculated, SqlComputeCode = { Set {errorsOnSave}=##class(common.trace.migration).getErrorsOnSave({ID})}, SqlComputed ];

Property errors As %Integer [ Calculated, SqlComputeCode = { Set {errors}=##class(common.trace.migration).getErrors({ID})}, SqlComputed ];

Property imported As %Integer [ Calculated, SqlComputeCode = { Set {imported}=##class(common.trace.migration).getImported({ID})}, SqlComputed ];

Property size As %Integer [ Calculated, SqlComputeCode = { Set {size}=##class(common.trace.migration).getSize({ID})}, SqlComputed ];

Property elapse As %Numeric [ Calculated, SqlComputeCode = { Set {elapse}=##class(common.trace.migration).getElapse({ID})}, SqlComputed ];

Property exceptionPayload As %String(MAXLEN = "") [ Calculated, SqlComputeCode = { Set {exceptionPayload}=##class(common.trace.migration).getExceptionPayload({ID})}, SqlComputed ];

Property exceptionPayloadOnError As %String(MAXLEN = "") [ Calculated, SqlComputeCode = { Set {exceptionPayloadOnError}=##class(common.trace.migration).getExceptionPayloadOnError({ID})}, SqlComputed ];

Property init As %Integer;

ClassMethod test() As %Status
{
    set content = ##class(%ArrayOfDataTypes).%New()
    set payload = ##class(%PopulateUtils).Mission()
    do content.SetAt($Length(payload) ,"CONTENT SIZE")
    do content.SetAt(payload ,"PAYLOAD")
    
    $$$log("THIS IS A TEST WITH NO CONTENT","no-content","test trace without content")
    $$$logcontent("THIS IS A TEST WITH CONTENT","content","test trace with content",content)

    return $$$OK
}

ClassMethod log(name As %String, type As %String, msg As %String, content As %ArrayOfDataTypes) As %Status
{
    Try {
        set sc = $$$OK
        set a = ..%New()
        set a.name = name
        set a.type = type
        set a.msg = msg
        set key = ""
        if $Data(content) { 
            set a.content = content 
    }
        
    }
    Catch ex {
        Set sc=ex.AsStatus()
        set sc = $SYSTEM.Security.Audit("Business Service get EMAIL","pb de droits","exception 5",a.%XMLEXport(), a.%JSONExport())
    }
 
    set sc = a.%Save()
    return sc
}

ClassMethod getName(name As %String) As %String
{
    set response = ""
    if name = "EXCEPTION" {
        set response = "exception"
    }
    elseif name = "0-HTTP REQUEST" {
        set response = "post"
    } else {
        set response = $piece(name,".",2)
    }
    return response
}

ClassMethod getExceptionPayload(id As %String) As %String
{
    set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        #; if a.name = "EXCEPTION"
        #;  & a.type = "payload" {
            for i = 1 : 1 : 9 {
                set response = response _ a.content.GetAt(i)
            }
        #; }
    }
    return response
}

ClassMethod getExceptionPayloadOnError(id As %String) As %String
{
    set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        #; if a.name = "EXCEPTION"
        #;  & a.type = "on error" {
            for i = 1 : 1 : 9 {
                set response = response _ a.content.GetAt("EXCEPTION OCCURS ON THIS PART OF PAYLOAD " _i)
            }
        #; }
    }
    return response
}

ClassMethod getImported(id As %String) As %Integer
{
    Set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        if a.name '= "EXCEPTION" {
            set response = a.content.GetAt("IMPORTED")
        }
    }
    set:response="" response = 0
    Return response
}

ClassMethod getErrorsOnSave(id As %String) As %Integer
{
    Set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        if a.type = "save error" {
            set response = 1
        }
    }
    set:response="" response = 0
    Return response
}

ClassMethod getErrors(id As %String) As %Integer
{
    Set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        if a.name '= "EXCEPTION" {
            set response = a.content.GetAt("ERRORS")
        }
    }
    set:response="" response = 0
    Return response
}

ClassMethod getElapse(id As %String) As %Numeric
{
    Set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        if a.name '= "EXCEPTION" {
            set response = a.content.GetAt("ELAPSE")
        }
    }
    set:response="" response = 0
    Return response
}

ClassMethod getElapseMIN(id As %String) As %Numeric
{
    Set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        if a.name '= "EXCEPTION" {
            set response = a.content.GetAt("ELAPSE")
        }
    }
    #; set:response="" response = 0
    Return response
}

ClassMethod getSize(id As %String) As %Numeric
{
    Set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        if a.name '= "EXCEPTION" {
            set response = a.content.GetAt("CONTENT SIZE")
        }
    }
    set:response="" response = 0
    Return response
}

ClassMethod getSizeMIN(id As %String) As %Numeric
{
    Set response = ""
    if ..%ExistsId(id) {
        set a = ..%OpenId(id)
        if a.name '= "EXCEPTION" {
            set response = a.content.GetAt("CONTENT SIZE")
        }
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
<Value>name</Value>
</Value>
<Value name="3">
<Value>type</Value>
</Value>
<Value name="4">
<Value>ts</Value>
</Value>
<Value name="5">
<Value>day</Value>
</Value>
<Value name="6">
<Value>msg</Value>
</Value>
<Value name="7">
<Value>init</Value>
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
