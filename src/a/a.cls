Include EnsEDI

Class a.a Extends %RegisteredObject
{

ClassMethod MethodName() As %Status
{
    Set sc = $$$OK
    set a=$$$Text("E1238","EDIDocumentView")

    Return sc
}

}
