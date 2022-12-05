/// 
Class EDICOM.out.facture Extends EnsLib.RecordMap.ComplexMap
{

Parameter BATCHCLASS = "EDICOM.out.facture.Batch";

ClassMethod PutBatch(pIOStream As %IO.DeviceStream, pBatch As EnsLib.RecordMap.ComplexBatch) As %Status
{
	Set tStatus = $$$OK
	Try {
		If '$IsObject($get(pBatch)) Set tStatus = $$$ERROR($$$ObjectInstanceRequired) Quit
		If '$IsObject(pIOStream) {
			Set tFilename = pIOStream
			Set pIOStream = ##class(%IO.FileStream).%New()
			Do pIOStream.Open(tFilename,"WAE",,"UTF-8",.tStatus)
			If $$$ISERR(tStatus) Quit
		}
		If $IsObject(pBatch.ORG) {
			Set tStatus = ##class(EDICOM.out.ORG).PutObject(pIOStream,pBatch.ORG,0)
			If $$$ISERR(tStatus) Quit
		}
		If $IsObject(pBatch.ORG2) {
			Set tStatus = ##class(EDICOM.out.ORG2).PutObject(pIOStream,pBatch.ORG2,0)
			If $$$ISERR(tStatus) Quit
		}
		If $IsObject(pBatch.DEST) {
			Set tStatus = ##class(EDICOM.out.DEST).PutObject(pIOStream,pBatch.DEST,0)
			If $$$ISERR(tStatus) Quit
		}
		If $IsObject(pBatch.CLI) {
			Set tStatus = ##class(EDICOM.out.CLI).PutObject(pIOStream,pBatch.CLI,0)
			If $$$ISERR(tStatus) Quit
		}
		If $IsObject(pBatch.INFDOC) {
			Set tStatus = ##class(EDICOM.out.INFDOC).PutObject(pIOStream,pBatch.INFDOC,0)
			If $$$ISERR(tStatus) Quit
		}
		If $IsObject(pBatch.INFPAY) {
			Set tStatus = ##class(EDICOM.out.INFPAY).PutObject(pIOStream,pBatch.INFPAY,0)
			If $$$ISERR(tStatus) Quit
		}
		If $IsObject(pBatch.PED) {
			Set tStatus = ##class(EDICOM.out.PED).PutObject(pIOStream,pBatch.PED,0)
			If $$$ISERR(tStatus) Quit
		}
		If $IsObject(pBatch.CANT) {
			Set tStatus = ##class(EDICOM.out.CANT).PutObject(pIOStream,pBatch.CANT,0)
			If $$$ISERR(tStatus) Quit
		}
		If $IsObject(pBatch.BANQ) {
			Set tStatus = ##class(EDICOM.out.BANQ).PutObject(pIOStream,pBatch.BANQ,0)
			If $$$ISERR(tStatus) Quit
		}
		If $IsObject(pBatch.NUMLIN) {
			Set tStatus = ##class(EDICOM.out.NUMLIN).PutObject(pIOStream,pBatch.NUMLIN,0)
			If $$$ISERR(tStatus) Quit
		}
		Set seqKey = ""
		For {
			Set tElement = pBatch.LIN.GetNext(.seqKey)
			If (seqKey = "") Quit
			If $IsObject(tElement) {
				Set tStatus = ##class(EDICOM.out.LIN).PutObject(pIOStream,tElement,0)
				If $$$ISERR(tStatus) Quit
			}
			Set tStatus = pBatch.LIN.%UnSwizzleAt(seqKey)
			If $$$ISERR(tStatus) Quit
		}
		If $$$ISERR(tStatus) Quit
		Do pIOStream.Flush(.tStatus)
		If $$$ISERR(tStatus) Quit
	} Catch ex {
		Set tStatus = $$$SystemError
	}
	Quit tStatus
}

ClassMethod GetBatch(pIOStream As %IO.DeviceStream, pTimeout As %Numeric = -1, Output pBatch As EnsLib.RecordMap.ComplexBatch, ByRef pLookAhead As %String = "") As %Status
{
	Set tStatus = $$$OK
	Try {
		If '$IsObject(pIOStream) {
			Set tFilename = pIOStream
			Set pIOStream = ##class(%IO.FileStream).%New()
			Do pIOStream.Open(tFilename,,pTimeout,"UTF-8",.tStatus)
			If $$$ISERR(tStatus) Quit
		}
		Set pIOStream.CharEncoding = "UTF-8"
		Set pBatch = ##class(EDICOM.out.facture.Batch).%New()
		Set pBatch.%Source = pIOStream.Name
		Set pLookAhead = $get(pLookAhead)
		Set tStatus = ##class(EDICOM.out.ORG).GetObject(pIOStream,.tObject,pTimeout,.pLookAhead)
		If $$$ISERR(tStatus) Set tStatus = $system.Status.AppendStatus($$$ERROR($$$EnsRecordMapErrComplexBasic,"ORG","EDICOM.out.ORG",$classname()),tStatus) Quit
		Set pBatch.ORG = tObject
		If (5 > $length(pLookAhead)) {
			Set pLookAhead = pLookAhead _ pIOStream.Read(5-$length(pLookAhead),pTimeout,.tStatus)
			If $$$ISERR(tStatus) Quit
		}
		If ($extract(pLookAhead,1,5) = "ORG2;") {
			Set tStatus = ##class(EDICOM.out.ORG2).GetObject(pIOStream,.tObject,pTimeout,.pLookAhead)
			If $$$ISERR(tStatus) Set tStatus = $system.Status.AppendStatus($$$ERROR($$$EnsRecordMapErrComplexBasic,"ORG2","EDICOM.out.ORG2",$classname()),tStatus) Quit
			Set pBatch.ORG2 = tObject
		}
		If (5 > $length(pLookAhead)) {
			Set pLookAhead = pLookAhead _ pIOStream.Read(5-$length(pLookAhead),pTimeout,.tStatus)
			If $$$ISERR(tStatus) Quit
		}
		If ($extract(pLookAhead,1,5) = "DEST;") {
			Set tStatus = ##class(EDICOM.out.DEST).GetObject(pIOStream,.tObject,pTimeout,.pLookAhead)
			If $$$ISERR(tStatus) Set tStatus = $system.Status.AppendStatus($$$ERROR($$$EnsRecordMapErrComplexBasic,"DEST","EDICOM.out.DEST",$classname()),tStatus) Quit
			Set pBatch.DEST = tObject
		}
		If (4 > $length(pLookAhead)) {
			Set pLookAhead = pLookAhead _ pIOStream.Read(4-$length(pLookAhead),pTimeout,.tStatus)
			If $$$ISERR(tStatus) Quit
		}
		If ($extract(pLookAhead,1,4) = "CLI;") {
			Set tStatus = ##class(EDICOM.out.CLI).GetObject(pIOStream,.tObject,pTimeout,.pLookAhead)
			If $$$ISERR(tStatus) Set tStatus = $system.Status.AppendStatus($$$ERROR($$$EnsRecordMapErrComplexBasic,"CLI","EDICOM.out.CLI",$classname()),tStatus) Quit
			Set pBatch.CLI = tObject
		}
		If (7 > $length(pLookAhead)) {
			Set pLookAhead = pLookAhead _ pIOStream.Read(7-$length(pLookAhead),pTimeout,.tStatus)
			If $$$ISERR(tStatus) Quit
		}
		If ($extract(pLookAhead,1,7) = "INFDOC;") {
			Set tStatus = ##class(EDICOM.out.INFDOC).GetObject(pIOStream,.tObject,pTimeout,.pLookAhead)
			If $$$ISERR(tStatus) Set tStatus = $system.Status.AppendStatus($$$ERROR($$$EnsRecordMapErrComplexBasic,"INFDOC","EDICOM.out.INFDOC",$classname()),tStatus) Quit
			Set pBatch.INFDOC = tObject
		}
		If (7 > $length(pLookAhead)) {
			Set pLookAhead = pLookAhead _ pIOStream.Read(7-$length(pLookAhead),pTimeout,.tStatus)
			If $$$ISERR(tStatus) Quit
		}
		If ($extract(pLookAhead,1,7) = "INFPAY;") {
			Set tStatus = ##class(EDICOM.out.INFPAY).GetObject(pIOStream,.tObject,pTimeout,.pLookAhead)
			If $$$ISERR(tStatus) Set tStatus = $system.Status.AppendStatus($$$ERROR($$$EnsRecordMapErrComplexBasic,"INFPAY","EDICOM.out.INFPAY",$classname()),tStatus) Quit
			Set pBatch.INFPAY = tObject
		}
		If (4 > $length(pLookAhead)) {
			Set pLookAhead = pLookAhead _ pIOStream.Read(4-$length(pLookAhead),pTimeout,.tStatus)
			If $$$ISERR(tStatus) Quit
		}
		If ($extract(pLookAhead,1,4) = "PED;") {
			Set tStatus = ##class(EDICOM.out.PED).GetObject(pIOStream,.tObject,pTimeout,.pLookAhead)
			If $$$ISERR(tStatus) Set tStatus = $system.Status.AppendStatus($$$ERROR($$$EnsRecordMapErrComplexBasic,"PED","EDICOM.out.PED",$classname()),tStatus) Quit
			Set pBatch.PED = tObject
		}
		If (5 > $length(pLookAhead)) {
			Set pLookAhead = pLookAhead _ pIOStream.Read(5-$length(pLookAhead),pTimeout,.tStatus)
			If $$$ISERR(tStatus) Quit
		}
		If ($extract(pLookAhead,1,5) = "CANT;") {
			Set tStatus = ##class(EDICOM.out.CANT).GetObject(pIOStream,.tObject,pTimeout,.pLookAhead)
			If $$$ISERR(tStatus) Set tStatus = $system.Status.AppendStatus($$$ERROR($$$EnsRecordMapErrComplexBasic,"CANT","EDICOM.out.CANT",$classname()),tStatus) Quit
			Set pBatch.CANT = tObject
		}
		If (5 > $length(pLookAhead)) {
			Set pLookAhead = pLookAhead _ pIOStream.Read(5-$length(pLookAhead),pTimeout,.tStatus)
			If $$$ISERR(tStatus) Quit
		}
		If ($extract(pLookAhead,1,5) = "BANQ;") {
			Set tStatus = ##class(EDICOM.out.BANQ).GetObject(pIOStream,.tObject,pTimeout,.pLookAhead)
			If $$$ISERR(tStatus) Set tStatus = $system.Status.AppendStatus($$$ERROR($$$EnsRecordMapErrComplexBasic,"BANQ","EDICOM.out.BANQ",$classname()),tStatus) Quit
			Set pBatch.BANQ = tObject
		}
		If (7 > $length(pLookAhead)) {
			Set pLookAhead = pLookAhead _ pIOStream.Read(7-$length(pLookAhead),pTimeout,.tStatus)
			If $$$ISERR(tStatus) Quit
		}
		If ($extract(pLookAhead,1,7) = "NUMLIN;") {
			Set tStatus = ##class(EDICOM.out.NUMLIN).GetObject(pIOStream,.tObject,pTimeout,.pLookAhead)
			If $$$ISERR(tStatus) Set tStatus = $system.Status.AppendStatus($$$ERROR($$$EnsRecordMapErrComplexBasic,"NUMLIN","EDICOM.out.NUMLIN",$classname()),tStatus) Quit
			Set pBatch.NUMLIN = tObject
		}
		If (4 > $length(pLookAhead)) {
			Set pLookAhead = pLookAhead _ pIOStream.Read(4-$length(pLookAhead),pTimeout,.tStatus)
			If $$$ISERR(tStatus) Quit
		}
		Set tCount = 0
		While ($extract(pLookAhead,1,4) = "LIN;") {
			Set tStatus = ##class(EDICOM.out.LIN).GetObject(pIOStream,.tObject,pTimeout,.pLookAhead)
			Set tCount = tCount + 1
			If $$$ISERR(tStatus) Quit
			Set tStatus = tObject.%Save()
			If $$$ISERR(tStatus) Quit
			Set tStatus = pBatch.LIN.SetAt(tObject,tCount)
			If $$$ISERR(tStatus) Quit
			Set tStatus = pBatch.LIN.%UnSwizzleAt(tCount)
			If $$$ISERR(tStatus) Quit
			If (4 > $length(pLookAhead)) {
				Set pLookAhead = pLookAhead _ pIOStream.Read(4-$length(pLookAhead),pTimeout,.tStatus)
				If $$$ISERR(tStatus) Quit
			}
		}
		If $$$ISERR(tStatus) Set tStatus = $system.Status.AppendStatus($$$ERROR($$$EnsRecordMapErrComplexRepeating,"LIN","EDICOM.out.LIN",$classname(),tCount),tStatus) Quit
	} Catch {
		Set tStatus = $$$SystemError
	}
	Quit tStatus
}

Parameter RECORDMAPGENERATED = 1;

XData ComplexBatch [ XMLNamespace = "http://www.intersystems.com/Ensemble/RecordMap" ]
{
<ComplexBatch xmlns="http://www.intersystems.com/Ensemble/RecordMap" name="EDICOM.out.facture" char_encoding="UTF-8" targetClassname="EDICOM.out.facture.Batch">
  <RecordReference name="ORG" required="1" repeating="0" recordMap="EDICOM.out.ORG">
  </RecordReference>
  <RecordReference name="ORG2" required="0" repeating="0" recordMap="EDICOM.out.ORG2">
  </RecordReference>
  <RecordReference name="DEST" required="0" repeating="0" recordMap="EDICOM.out.DEST">
  </RecordReference>
  <RecordReference name="CLI" required="0" repeating="0" recordMap="EDICOM.out.CLI">
  </RecordReference>
  <RecordReference name="INFDOC" required="0" repeating="0" recordMap="EDICOM.out.INFDOC">
  </RecordReference>
  <RecordReference name="INFPAY" required="0" repeating="0" recordMap="EDICOM.out.INFPAY">
  </RecordReference>
  <RecordReference name="PED" required="0" repeating="0" recordMap="EDICOM.out.PED">
  </RecordReference>
  <RecordReference name="CANT" required="0" repeating="0" recordMap="EDICOM.out.CANT">
  </RecordReference>
  <RecordReference name="BANQ" required="0" repeating="0" recordMap="EDICOM.out.BANQ">
  </RecordReference>
  <RecordReference name="NUMLIN" required="0" repeating="0" recordMap="EDICOM.out.NUMLIN">
  </RecordReference>
  <RecordReference name="LIN" required="0" repeating="1" recordMap="EDICOM.out.LIN">
  </RecordReference>
</ComplexBatch>
}

}
