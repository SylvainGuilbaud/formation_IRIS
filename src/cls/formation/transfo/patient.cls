Class formation.transfo.patient Extends Ens.DataTransformDTL [ DependsOn = (formation.RM.patient.Record, formation.msg.mysql.patient) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='formation.RM.patient.Record' targetClass='formation.msg.mysql.patient' create='new' language='objectscript' >
<assign value='source.ID' property='target.id' action='set' />
<assign value='source.DateNaissance' property='target.DOB' action='set' />
<assign value='source.Nom' property='target.LastName' action='set' />
<assign value='source.Prenom' property='target.FirstName' action='set' />
<assign value='source.Sexe' property='target.Sex' action='set' />
</transform>
}

}
