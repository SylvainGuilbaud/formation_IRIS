Class EP.operation.replication Extends Ens.BusinessOperation
{

Property Adapter As Ens.OutboundAdapter;

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method sync(pRequest As Ens.StreamContainer, Output pResponse As Ens.StringContainer) As %Status
{
    set pResponse = ##class(Ens.StringContainer).%New()
    set json = [].%FromJSON(pRequest.Stream)
    set array = json.%GetIterator()
    while array.%GetNext(.key,.value) {
        $$$TRACE("Data:"_value.%ToJSON())
        set a = ##class(data.client2).%New()
        set sc = a.%JSONImport(value)
        if 'sc {
            $$$LOGERROR("ERROR while importing:"_$system.Status.GetErrorText(sc))
        } else {
            set sc = a.%Save()
        }
    }
    set pResponse.StringValue = key _" records inserted"
    return sc
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="Ens.StreamContainer">
        <Method>sync</Method>
    </MapItem>
</MapItems>
}

}
