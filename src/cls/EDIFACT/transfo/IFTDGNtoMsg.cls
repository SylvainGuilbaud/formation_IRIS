Class EDIFACT.transfo.IFTDGNtoMsg Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.EDI.EDIFACT.Document, EDIFACT.msg.transformed) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.EDI.EDIFACT.Document' targetClass='EDIFACT.msg.transformed' sourceDocType='IFTDGN_D98B:IFTDGN' create='new' language='objectscript' >
<assign value='source.{UNH-1}' property='target.UNH' action='set' />
<assign value='source.{BGM-2}' property='target.BGM' action='set' />
<foreach property='source.{FTX-4()}' key='k1' >
<assign value='source.{FTX-4(k1)}' property='target.FTX.(k1)' action='set' />
</foreach>
<assign value='source.{SG2.TDT-10}' property='target.TDT' action='set' />
<foreach property='source.{SG2.RFF-11()}' key='k1' >
<assign value='source.{SG2.RFF-11(k1)}' property='target.RFF.(k1)' action='set' />
</foreach>
<foreach property='source.{SG2.LOC-12()}' key='k2' >
<assign value='source.{SG2.LOC-12(k2)}' property='target.LOC.(k2)' action='set' />
<assign value='source.{UNT-53}' property='target.UNT' action='set' />
</foreach>
</transform>
}

}
