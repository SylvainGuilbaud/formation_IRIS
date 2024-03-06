Class formation.transfo.PostgreSQLtoMySQL Extends Ens.DataTransformDTL [ DependsOn = (formation.postgres.app.personne, formation.msg.mysql.personne) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='formation.postgres.app.personne' targetClass='formation.msg.mysql.personne' create='new' language='objectscript' >
<assign value='source.id' property='target.id' action='set' />
<assign value='source.lastname' property='target.LastName' action='set' />
<assign value='source.firstname' property='target.FirstName' action='set' />
<assign value='source.dob' property='target.DOB' action='set' />
<assign value='source.sex' property='target.Sex' action='set' />
</transform>
}

}
