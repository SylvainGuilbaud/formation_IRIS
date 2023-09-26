Class MT.transfo.XML Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.EDI.XML.Document, data.client) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.EDI.XML.Document' targetClass='data.client' sourceDocType='file:File' create='new' language='objectscript' >
<assign value='source.{conf.CodeArticle}' property='target.code' action='set' />
<assign value='source.{conf.PrixConf}' property='target.description' action='set' />
</transform>
}

}
