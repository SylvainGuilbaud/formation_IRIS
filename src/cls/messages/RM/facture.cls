/// RECORDMAP: Modified during compilation of RecordMap 'messages.RM.facture'
/// on 2024-07-25 at 09:42:21.751 [2024-07-25 08:42:21.751 UTC]
/// by user _SYSTEM
Class messages.RM.facture Extends EnsLib.RecordMap.RecordMap
{

Parameter OBJECTNAME = "messages.RM.facture.Record";

/// THIS IS GENERATED CODE. DO NOT EDIT.<br/>
/// Method to retrieve a record from a stream or device. This method will be generated based on the
/// structure of the RecordMap. For testing purposes, a file name may be passed in the pStream argument.
ClassMethod GetObject(pStream As %IO.DeviceStream, Output pObject As %RegisteredObject, pTimeout As %Numeric = -1, ByRef pLookAhead As %String = "", pLabelFound As %Boolean = 0) As %Status
{
	Try {
		Set tStatus = $$$OK
		Set pObject = $$$NULLOREF
		If '$IsObject(pStream) {
			Set tFilename = pStream
			Set pStream = ##class(%IO.FileStream).%New()
			Do pStream.Open(tFilename,,pTimeout,"UTF-8", .tStatus)
			If $$$ISERR(tStatus) Quit
		}
		Set tObjectName = $parameter($this,"OBJECTNAME")
		Set tObject = $classmethod(tObjectName,"%New")
		If '$IsObject(tObject) {
			Set tStatus = $$$ERROR($$$CannotCreateObject,tObjectName)
			Quit
		}
		Set tObject.%Source = pStream.Name
		Set tGetTopFields = $parameter(tObject,"INCLUDETOPFIELDS")
		If pStream.AtEnd && (""=pLookAhead) {
			Set tStatus = $$$ERROR($$$EnsRecordMapErrStreamAtEnd, pStream.Name)
			Quit
		}
		Set pStream.CharEncoding = "UTF-8"

		#; Parse incoming stream
		Set tStatus = ..GetRecord(pStream, tObject, tGetTopFields, pTimeout, .pLookAhead, pLabelFound)
		If $$$ISERR(tStatus) Quit
	}
	Catch ex {
		Set tStatus = ex.AsStatus()
	}
	If $$$ISERR(tStatus) { Set pObject = $$$NULLOREF }
	Else { Set pObject = tObject }
	Quit tStatus
}

/// THIS IS GENERATED CODE. DO NOT EDIT.<br/>
/// Method to write a record to a stream or device. This method will be generated based on the
/// structure of the RecordMap. For testing purposes, a file name may be passed in the pStream argument.
ClassMethod PutObject(pStream As %IO.DeviceStream, pObject As %RegisteredObject, pFlush As %Boolean = 1, ByRef pPadArray As %String) As %Status
{
	Try {
		Set tStatus = $$$OK
		If '$IsObject(pStream) {
			Set tFilename = pStream
			Set pStream = ##class(%IO.FileStream).%New()
			Do pStream.Open(tFilename,"WAE",,"UTF-8", .tStatus)
			If $$$ISERR(tStatus) Quit
		}
		Set tHasTopFields = $parameter(pObject,"INCLUDETOPFIELDS")
		Set pStream.CharEncoding = "UTF-8"

		Set tStatus = ..PutRecord(pStream, pObject, tHasTopFields, .pPadArray)
		If $$$ISERR(tStatus) Quit
		If pFlush Do pStream.Flush(.tStatus)
		If $$$ISERR(tStatus) Quit
	}
	Catch ex {
		Set tStatus = ex.AsStatus()
	}
	Quit tStatus
}

/// THIS IS GENERATED CODE. DO NOT EDIT.<br/>
/// Internal helper method to perform parse of incoming data
ClassMethod GetRecord(pStream As %IO.DeviceStream, pObject As %RegisteredObject, pGetTopFields As %Boolean, pTimeout As %Numeric, ByRef pLookAhead As %String = "", pLabelFound As %Boolean = 0) As %Status [ Internal, Private ]
{
	Set tStatus = $$$OK
	If pLabelFound { Set tRecLabel = "" } 
	Else { Set tRecLabel = "" } 
	Set tStatus = ..chunkRecord(pStream, .tRecordData, .tCharCount, "", pTimeout, $char(10), tRecLabel, .pLookAhead, $char(34), 0)
	If $$$ISERR(tStatus) Quit tStatus
	Set tMaxLocal = $$$MaxLocalLength
	Set tRecordData("charcount") = +$get(tCharCount)
	Set tCurrChunk = 1
	Set tTopPiece = 1
	Set tCurrSep = 1
	Set tStrings = 1
	Set tCurrString = ""
	Set tSeps = $listbuild($char(44))
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Else {
		Set tCurrString = tRecordData(tCurrChunk)
		Set tCurrPiece = 1
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.Numérofacture = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.Datefacture =  pObject.DatefactureDisplayToLogical(tCurrString)
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.Nomclient = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.Adresseclient = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.Codepostal = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.Ville = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.Pays = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.Articles = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.MontanttotalHT =  pObject.MontanttotalHTDisplayToLogical(tCurrString)
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.TVA =  pObject.TVADisplayToLogical(tCurrString)
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.MontanttotalTTC =  pObject.MontanttotalTTCDisplayToLogical(tCurrString)
	}
	Quit tStatus
}

/// THIS IS GENERATED CODE. DO NOT EDIT.<br/>
/// Internal helper method to output object to a stream
ClassMethod PutRecord(pStream As %IO.DeviceStream, pObject As %RegisteredObject, pHasTopFields As %Boolean, ByRef pPadArray As %String) As %Status [ Internal, Private ]
{
	Set tStatus = $$$OK
	Set tmpStream=##class(%Stream.TmpBinary).%New()
	Do tmpStream.Write($select(pHasTopFields: ..Escape(pObject.Numérofacture, $lb($char(44)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.DatefactureLogicalToDisplay(pObject.Datefacture), $lb($char(44)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Nomclient, $lb($char(44)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Adresseclient, $lb($char(44)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Codepostal, $lb($char(44)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Ville, $lb($char(44)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Pays, $lb($char(44)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Articles, $lb($char(44)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.MontanttotalHTLogicalToDisplay(pObject.MontanttotalHT), $lb($char(44)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.TVALogicalToDisplay(pObject.TVA), $lb($char(44)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.MontanttotalTTCLogicalToDisplay(pObject.MontanttotalTTC), $lb($char(44)),"quote",$char(34)),1: ""))
	Set tStatus = tmpStream.Write($char(10))
	If $$$ISERR(tStatus) Quit tStatus
	Do pStream.CopyFrom(tmpStream,,0,.tStatus)
	Quit tStatus
}

ClassMethod GetGeneratedClasses(Output pClasses As %String) As %Status
{
	Kill pClasses
	Set pClasses("messages.RM.facture.Record")=""
	Set pClasses($classname())=""
	Quit $$$OK
}

ClassMethod getIdentifier() As %String [ CodeMode = expression ]
{
""
}

ClassMethod getType() As EnsLib.RecordMap.Model.DataType.RecordType [ CodeMode = expression ]
{
"delimited"
}

XData RecordMap [ XMLNamespace = "http://www.intersystems.com/Ensemble/RecordMap" ]
{
<Record xmlns="http://www.intersystems.com/Ensemble/RecordMap" name="messages.RM.facture" type="delimited" char_encoding="UTF-8" targetClassname="messages.RM.facture.Record" recordTerminator="\x0a" escaping="quote" escapeSequence="&quot;" allowEmbeddedRecordTerminator="0">
  <Separators>
    <Separator>,</Separator>
  </Separators>
  <Field name="Numérofacture" required="1" ignored="0" datatype="%String" sqlColumn="2" repeating="0">
  </Field>
  <Field name="Datefacture" required="1" ignored="0" datatype="%Date" params="FORMAT=4" sqlColumn="3" repeating="0">
  </Field>
  <Field name="Nomclient" required="1" ignored="0" datatype="%String" params="MAXLEN=&quot;&quot;" sqlColumn="4" repeating="0">
  </Field>
  <Field name="Adresseclient" required="0" ignored="0" datatype="%String" params="MAXLEN=&quot;&quot;" sqlColumn="5" repeating="0">
  </Field>
  <Field name="Codepostal" required="0" ignored="0" datatype="%String" params="MAXLEN=9" sqlColumn="6" repeating="0">
  </Field>
  <Field name="Ville" required="0" ignored="0" datatype="%String" params="MAXLEN=&quot;&quot;" sqlColumn="7" repeating="0">
  </Field>
  <Field name="Pays" required="0" ignored="0" datatype="%String" params="MAXLEN=&quot;&quot;" sqlColumn="8" repeating="0">
  </Field>
  <Field name="Articles" required="0" ignored="0" datatype="%String" params="MAXLEN=&quot;&quot;" sqlColumn="9" repeating="0">
  </Field>
  <Field name="MontanttotalHT" required="0" ignored="0" datatype="%Double" sqlColumn="10" repeating="0">
  </Field>
  <Field name="TVA" required="0" ignored="0" datatype="%Decimal" sqlColumn="11" repeating="0">
  </Field>
  <Field name="MontanttotalTTC" required="0" ignored="0" datatype="%Double" sqlColumn="12" repeating="0">
  </Field>
</Record>
}

}
