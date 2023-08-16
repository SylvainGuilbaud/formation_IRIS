Class formation.operation.email Extends Ens.BusinessOperation
{

Property Adapter As Ens.OutboundAdapter;

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method send(pRequest As Ens.Request, Output pResponse As Ens.Response) As %Status
{
    set sc = $$$OK
    
    return sc
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="Ens.Request">
        <Method>send</Method>
    </MapItem>
</MapItems>
}

}
