Class utils.transfo.getNames Extends Ens.DataTransformDTL [ DependsOn = (formation.RM.personne.Batch, common.person) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='formation.RM.personne.Batch' targetClass='common.person' create='new' language='objectscript' >
<foreach property='source.Records()' key='k1' >
<assign value='source.Records.(k1).Nom' property='target.names.(k1)' action='set' />
</foreach>
</transform>
}

}
