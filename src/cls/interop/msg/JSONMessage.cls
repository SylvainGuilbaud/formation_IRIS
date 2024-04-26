Class interop.msg.JSONMessage Extends (Ens.Request, %JSON.Adaptor)
{

/// This method is called by the Management Portal to determine the content type that will be returned by the <method>%ShowContents</method> method.
/// The return value is a string containing an HTTP content type.
Method %GetContentType() As %String
{
    Quit "text/html"
}

/// This method is called by the Management Portal to display a message-specific content viewer.<br>
/// This method displays its content by writing out to the current device.
/// The content should match the type returned by the <method>%GetContentType</method> method.<br>
Method %ShowContents(pZenOutput As %Boolean = 0)
{
   do ..%JSONExportToString(.jsonExport)
    set formatter = ##class(%JSON.Formatter).%New()
    do formatter.FormatToString(jsonExport, .json)
    &html<
        <i style="color:green;">type: #($classname())#  id: #(..%Id())# </i>
        <pre>#(json)#</pre>
    >
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
