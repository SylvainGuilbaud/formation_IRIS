Class formation.transfo.personne Extends Ens.DataTransformDTL [ DependsOn = (formation.RM.personne.Record, formation.msg.mysql.personne) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='formation.RM.personne.Record' targetClass='formation.msg.mysql.personne' create='new' language='objectscript' >
<assign value='source.ID' property='target.id' action='set' />
<assign value='source.DateNaissance' property='target.DOB' action='set' />
<assign value='source.Nom' property='target.LastName' action='set' />
<assign value='source.Prenom' property='target.FirstName' action='set' />
<assign value='source.Sexe' property='target.Sex' action='set' />
</transform>
}

}
