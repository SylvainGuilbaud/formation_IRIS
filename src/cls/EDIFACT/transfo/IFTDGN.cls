Class EDIFACT.transfo.IFTDGN Extends Ens.DataTransformDTL [ DependsOn = EnsLib.EDI.EDIFACT.Document ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.EDI.EDIFACT.Document' targetClass='EnsLib.EDI.EDIFACT.Document' sourceDocType='IFTDGN_D98B:IFTDGN' targetDocType='IFTDGN_D98B:IFTDGN' create='copy' language='objectscript' >
<assign value='"GGGGG"' property='target.{UNH-1:0062}' action='set' />
</transform>
}

}
