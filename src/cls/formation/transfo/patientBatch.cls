Class formation.transfo.patientBatch Extends Ens.DataTransformDTL [ DependsOn = (formation.RM.patient.Batch, formation.msg.mysql.batch) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='formation.RM.patient.Batch' targetClass='formation.msg.mysql.batch' create='new' language='objectscript' >
<foreach property='source.Records()' key='k1' >
<subtransform class='formation.transfo.patient' targetObj='target.list.(k1)' sourceObj='source.Records.(k1)' />
</foreach>
</transform>
}

}
