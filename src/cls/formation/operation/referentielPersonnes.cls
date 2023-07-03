Class formation.operation.referentielPersonnes Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method maj(pRequest As NomProjet.RM.personne.Record, Output pResponse As NomProjet.response.SQL.personne) As %Status
{
    set sc = $$$OK

    /// logique 


    Return sc
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="NomProjet.RM.personne.Record">
        <Method>maj</Method>
    </MapItem>
</MapItems>
}

}
