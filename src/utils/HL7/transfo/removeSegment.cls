Class utils.HL7.transfo.removeSegment Extends Ens.DataTransformDTL [ DependsOn = EnsLib.HL7.Message ]
{

Parameter IGNOREMISSINGSOURCE = 0;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='EnsLib.HL7.Message' sourceDocType='2.6:ADT_A01' targetDocType='2.6:ADT_A01' create='copy' language='objectscript' >
<assign value='' property='target.{EVN}' action='remove' />
<assign value='' property='target.{DG1()}' action='remove' />
</transform>
}

}
