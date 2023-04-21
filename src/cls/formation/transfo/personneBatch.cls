Class formation.transfo.personneBatch Extends Ens.DataTransformDTL [ DependsOn = (formation.RM.personne.Batch, formation.msg.mysql.batch) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='formation.RM.personne.Batch' targetClass='formation.msg.mysql.batch' create='new' language='objectscript' >
<foreach property='source.Records()' key='k1' >
<subtransform class='formation.transfo.personne' targetObj='target.list.(k1)' sourceObj='source.Records.(k1)' />
</foreach>
</transform>
}

}
