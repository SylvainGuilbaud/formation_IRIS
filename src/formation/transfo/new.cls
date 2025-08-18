/// 
Class formation.transfo.new Extends Ens.DataTransformDTL [ DependsOn = (formation.msg.replication, common.msg.email) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

Parameter GENERATEEMPTYSEGMENTS = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='formation.msg.replication' targetClass='common.msg.email' create='new' language='objectscript' >
<assign value='source.idirisreplication' property='target.Source' action='set' />
</transform>
}

}
