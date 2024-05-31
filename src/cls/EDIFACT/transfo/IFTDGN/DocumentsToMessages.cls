Class EDIFACT.transfo.IFTDGN.DocumentsToMessages Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.EDI.EDIFACT.Document, EDIFACT.msg.array) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.EDI.EDIFACT.Document' targetClass='EDIFACT.msg.array' sourceDocType='IFTDGN_D98B:Interchange' targetDocType='IFTDGN_D98B:IFTDGN' create='new' language='objectscript' >
<assign value='"UNB"' property='InterChangeStart' action='set' />
<assign value='"UNZ"' property='InterChangeStop' action='set' />
<assign value='"UNH+"' property='DocumentHeader' action='set' />
<assign value='$piece($piece(source.RawContent,source.FindSegment(InterChangeStart).OutputToString(),2),InterChangeStop)' property='RawContent' action='set' />
<code>
<![CDATA[ for i=2:1:$length(RawContent,DocumentHeader) {
	 set content=DocumentHeader_$piece(RawContent,DocumentHeader,i)_" "
	 set document=##class(EnsLib.EDI.EDIFACT.Document).ImportFromString(content)
	 do target.documents.SetAt(document,$i(key))
	}]]></code>
</transform>
}

}
