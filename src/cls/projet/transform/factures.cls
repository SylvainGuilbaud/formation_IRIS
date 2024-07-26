Class projet.transform.factures Extends Ens.DataTransformDTL [ DependsOn = (projet.messages.RM.facture.Record, data.CSV.facture) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='projet.messages.RM.facture.Record' targetClass='data.CSV.facture' create='new' language='objectscript' >
<assign value='source.Numérofacture' property='target.Numérofacture' action='set' />
<assign value='source.Datefacture' property='target.Datefacture' action='set' />
<assign value='source.MontanttotalHT' property='target.MontanttotalHT' action='set' />
<assign value='source.TVA' property='target.TVA' action='set' />
<assign value='source.MontanttotalTTC' property='target.MontanttotalTTC' action='set' />
<assign value='0' property='clientID' action='set' />
<sql>
<![CDATA[SELECT 
id into :clientID
FROM data_CSV.client
where Nomclient = :source.Nomclient
]]></sql>
<if condition='clientID&gt;0 &amp;&amp; ##class(data.CSV.client).%ExistsId(clientID)' >
<true>
<code>
<![CDATA[ set target.client = ##class(data.CSV.client).%OpenId(clientID) ]]></code>
</true>
</if>
<assign value='source.Nomclient' property='target.client.Nomclient' action='set' />
<assign value='source.Adresseclient' property='target.client.Adresseclient' action='set' />
<assign value='source.Codepostal' property='target.client.Codepostal' action='set' />
<assign value='source.Ville' property='target.client.Ville' action='set' />
<assign value='source.Pays' property='target.client.Pays' action='set' />
<assign value='source.Article1.Code' property='target.Articles.(1).Code' action='set' />
<assign value='source.Article1.Description' property='target.Articles.(1).Description' action='set' />
<assign value='source.Article1.Quantite' property='target.Articles.(1).Quantite' action='set' />
<assign value='source.Article1.PrixUnitaire' property='target.Articles.(1).PrixUnitaire' action='set' />
<assign value='source.Article2.Code' property='target.Articles.(2).Code' action='set' />
<assign value='source.Article2.Description' property='target.Articles.(2).Description' action='set' />
<assign value='source.Article2.Quantite' property='target.Articles.(2).Quantite' action='set' />
<assign value='source.Article2.PrixUnitaire' property='target.Articles.(2).PrixUnitaire' action='set' />
<assign value='source.Article3.Code' property='target.Articles.(3).Code' action='set' />
<assign value='source.Article3.Description' property='target.Articles.(3).Description' action='set' />
<assign value='source.Article3.Quantite' property='target.Articles.(3).Quantite' action='set' />
<assign value='source.Article3.PrixUnitaire' property='target.Articles.(3).PrixUnitaire' action='set' />
<assign value='source.Article4.Code' property='target.Articles.(4).Code' action='set' />
<assign value='source.Article4.Description' property='target.Articles.(4).Description' action='set' />
<assign value='source.Article4.Quantite' property='target.Articles.(4).Quantite' action='set' />
<assign value='source.Article4.PrixUnitaire' property='target.Articles.(4).PrixUnitaire' action='set' />
<assign value='source.Article5.Code' property='target.Articles.(5).Code' action='set' />
<assign value='source.Article5.Description' property='target.Articles.(5).Description' action='set' />
<assign value='source.Article5.Quantite' property='target.Articles.(5).Quantite' action='set' />
<assign value='source.Article5.PrixUnitaire' property='target.Articles.(5).PrixUnitaire' action='set' />
</transform>
}

}
