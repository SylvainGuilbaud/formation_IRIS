Class EDIFACT.transfo.aaa Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.EDI.EDIFACT.Document, Ens.StringContainer) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.EDI.EDIFACT.Document' targetClass='Ens.StringContainer' sourceDocType='IFTDGN_D98B:IFTDGN' create='new' language='objectscript' >
<assign value='source.{UNH-1}' property='target.StringValue' action='set' />
</transform>
}

}
