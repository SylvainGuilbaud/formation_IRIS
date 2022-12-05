/// RECORDMAP: Modified during compilation of Complex RecordMap 'EDICOM.out.facture'
/// on 2021-12-08 at 11:27:42.164 [2021-12-08 11:27:42.164 UTC]
/// by user _SYSTEM
Class EDICOM.out.facture.Batch Extends (EnsLib.RecordMap.ComplexBatch, Ens.Request) [ Inheritance = right, ProcedureBlock ]
{

Parameter RECORDMAPGENERATED = 1;

Property ORG As EDICOM.out.ORG.Record [ Required ];

Property ORG2 As EDICOM.out.ORG2.Record;

Property DEST As EDICOM.out.DEST.Record;

Property CLI As EDICOM.out.CLI.Record;

Property INFDOC As EDICOM.out.INFDOC.Record;

Property INFPAY As EDICOM.out.INFPAY.Record;

Property PED As EDICOM.out.PED.Record;

Property CANT As EDICOM.out.CANT.Record;

Property BANQ As EDICOM.out.BANQ.Record;

Property NUMLIN As EDICOM.out.NUMLIN.Record;

Property LIN As array Of EDICOM.out.LIN.Record;

Method %OnClose() As %Status [ Private, ServerOnly = 1 ]
{
	Set tStatus = $$$OK
	Try {
		Set tId = ..%Id()
		If ""=tId {
			Set seqKey = ""
			For {
				Set tElement = ..LIN.GetNext(.seqKey)
				If (seqKey = "") Quit
				If $IsObject(tElement) && (""'=tElement.%Id()) {
					Set tElementId = tElement.%Id()
					Set tStatus = ##class(EDICOM.out.LIN.Record).%DeleteId(tElementId)
				}
				If $$$ISERR(tStatus) Quit
			}
		}
	} Catch ex {
		Set tStatus = $$$SystemError
	}
	Quit tStatus
}

Storage Default
{
<Data name="BatchDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ORG</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>DEST</Value>
</Value>
<Value name="5">
<Value>CLI</Value>
</Value>
<Value name="6">
<Value>INFDOC</Value>
</Value>
<Value name="7">
<Value>INFPAY</Value>
</Value>
<Value name="8">
<Value>PED</Value>
</Value>
<Value name="9">
<Value>CANT</Value>
</Value>
<Value name="10">
<Value>BANQ</Value>
</Value>
<Value name="11">
<Value>NUMLIN</Value>
</Value>
<Value name="12">
<Value>ORG2</Value>
</Value>
</Data>
<Data name="LIN">
<Attribute>LIN</Attribute>
<Structure>subnode</Structure>
<Subscript>"LIN"</Subscript>
</Data>
<DataLocation>^EDICOM.out.facture.BatchD</DataLocation>
<DefaultData>BatchDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^EDICOM.out.facture.BatchD</IdLocation>
<IndexLocation>^EDICOM.out.facture.BatchI</IndexLocation>
<StreamLocation>^EDICOM.out.facture.BatchS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
