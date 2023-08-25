Class utils.exportJSON Extends Ens.BusinessOperation
{

Property Adapter As EnsLib.File.OutboundAdapter;

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCATION = "Queue";

Property Filename As %String(MAXLEN = 1000, MINLEN = 1) [ InitialExpression = "%f_%Q%!+(_a)", Required ];

Parameter SETTINGS As %String = "Filename:Basic";

Method export(pRequest As data.patient, Output pResponse As Ens.Response) As %Status
{
    set sc=$$$OK
    Try {
        set tFilename=..Filename
        set sc = pRequest.%JSONExportToStream(.stream)
        set sc=..Adapter.PutStream(tFilename, stream)
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    return sc
}

XData MessageMap
{
<MapItems>
        <MapItem MessageType="data.patient">
            <Method>export</Method>
        </MapItem>
    </MapItems>
}

}
