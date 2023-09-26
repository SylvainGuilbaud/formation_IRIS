Class MT.transfo.EDIXMLtoSQLPersonne Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.EDI.XML.Document, formation.msg.mysql.personne) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.EDI.XML.Document' targetClass='formation.msg.mysql.personne' sourceDocType='file:File' create='new' language='objectscript' >
<assign value='source.{client.Nom}' property='target.LastName' action='set' />
<assign value='..ConvertDateTime(source.{dateconf})' property='target.DOB' action='set' disabled='1' />
<assign value='source.{client.Prenom}' property='target.FirstName' action='set' />
</transform>
}

}
