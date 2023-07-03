Class formation.operation.ep Extends Ens.BusinessOperation
{

Property Adapter As Ens.OutboundAdapter;

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method SampleCall(pRequest As Ens.Request, Output pResponse As Ens.Response) As %Status
{
    
    Return $$$ERROR($$$NotImplemented)
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="Ens.Request">
        <Method>SampleCall</Method>
    </MapItem>
</MapItems>
}

}
