Class adm.maxime Extends Ens.BusinessOperation
{

Property Adapter As Ens.OutboundAdapter;

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Property aaaa;

Method aaa(pRequest As Ens.Request, Output pResponse As Ens.Response) As %Status
{
    
    Return $$$ERROR($$$NotImplemented)
}

/// Description
ClassMethod MethodName() As %Status
{
    Set sc = $$$OK
    // do something

    Try {
        set kgjfdgdjkfh = 1
        set gdfgfd = 0
        set gdfgfdgdfg = 3
        set defstoragedfg = 1


    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return sc
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="Ens.Request">
        <Method>aaa</Method>
    </MapItem>
</MapItems>
}

}
