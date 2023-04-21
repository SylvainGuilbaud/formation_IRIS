Class formation.transfo.gender Extends Ens.DataTransformDTL [ DependsOn = formation.RM.personne.Record ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='formation.RM.personne.Record' targetClass='formation.RM.personne.Record' create='existing' language='objectscript' >
<assign value='..Lookup("gender",source.Sexe,"M")' property='target.Sexe' action='set' />
</transform>
}

}
