/// RECORDMAP: Modified during compilation of RecordMap 'projet.messages.RM.facture'
/// on 2024-07-25 at 12:17:17.643 [2024-07-25 11:17:17.643 UTC]
/// by user _SYSTEM
Class projet.messages.RM.facture Extends EnsLib.RecordMap.RecordMap
{

Parameter OBJECTNAME = "projet.messages.RM.facture.Record";

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
	Set tSeps = $listbuild($char(44),$char(58))
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
	Set tStrings(tStrings) = tCurrString
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 1)
	Set tStrings = tStrings + 1
	Set pObject.Article1.Code = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 2)
	Set tStrings = tStrings + 1
	Set pObject.Article1.Description = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 3)
	Set tStrings = tStrings + 1
	Set pObject.Article1.Quantite = pObject.Article1.QuantiteDisplayToLogical(tStrings(tStrings))
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 4)
	Set tStrings = tStrings + 1
	Set pObject.Article1.PrixUnitaire = pObject.Article1.PrixUnitaireDisplayToLogical(tStrings(tStrings))
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	Set tStrings(tStrings) = tCurrString
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 1)
	Set tStrings = tStrings + 1
	Set pObject.Article2.Code = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 2)
	Set tStrings = tStrings + 1
	Set pObject.Article2.Description = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 3)
	Set tStrings = tStrings + 1
	Set pObject.Article2.Quantite = pObject.Article2.QuantiteDisplayToLogical(tStrings(tStrings))
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 4)
	Set tStrings = tStrings + 1
	Set pObject.Article2.PrixUnitaire = pObject.Article2.PrixUnitaireDisplayToLogical(tStrings(tStrings))
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	Set tStrings(tStrings) = tCurrString
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 1)
	Set tStrings = tStrings + 1
	Set pObject.Article3.Code = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 2)
	Set tStrings = tStrings + 1
	Set pObject.Article3.Description = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 3)
	Set tStrings = tStrings + 1
	Set pObject.Article3.Quantite = pObject.Article3.QuantiteDisplayToLogical(tStrings(tStrings))
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 4)
	Set tStrings = tStrings + 1
	Set pObject.Article3.PrixUnitaire = pObject.Article3.PrixUnitaireDisplayToLogical(tStrings(tStrings))
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	Set tStrings(tStrings) = tCurrString
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 1)
	Set tStrings = tStrings + 1
	Set pObject.Article4.Code = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 2)
	Set tStrings = tStrings + 1
	Set pObject.Article4.Description = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 3)
	Set tStrings = tStrings + 1
	Set pObject.Article4.Quantite = pObject.Article4.QuantiteDisplayToLogical(tStrings(tStrings))
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 4)
	Set tStrings = tStrings + 1
	Set pObject.Article4.PrixUnitaire = pObject.Article4.PrixUnitaireDisplayToLogical(tStrings(tStrings))
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	Set tStrings(tStrings) = tCurrString
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 1)
	Set tStrings = tStrings + 1
	Set pObject.Article5.Code = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 2)
	Set tStrings = tStrings + 1
	Set pObject.Article5.Description = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 3)
	Set tStrings = tStrings + 1
	Set pObject.Article5.Quantite = pObject.Article5.QuantiteDisplayToLogical(tStrings(tStrings))
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(58), 4)
	Set tStrings = tStrings + 1
	Set pObject.Article5.PrixUnitaire = pObject.Article5.PrixUnitaireDisplayToLogical(tStrings(tStrings))
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
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
	Do tmpStream.Write($select(pHasTopFields: ..Escape(pObject.Numérofacture, $lb($char(44),$char(58)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.DatefactureLogicalToDisplay(pObject.Datefacture), $lb($char(44),$char(58)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Nomclient, $lb($char(44),$char(58)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Adresseclient, $lb($char(44),$char(58)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Codepostal, $lb($char(44),$char(58)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Ville, $lb($char(44),$char(58)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Pays, $lb($char(44),$char(58)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44))
	Do tmpStream.Write(..Escape(pObject.Article1.Code, $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article1.Description, $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article1.QuantiteLogicalToDisplay(pObject.Article1.Quantite), $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article1.PrixUnitaireLogicalToDisplay(pObject.Article1.PrixUnitaire), $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(44))
	Do tmpStream.Write(..Escape(pObject.Article2.Code, $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article2.Description, $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article2.QuantiteLogicalToDisplay(pObject.Article2.Quantite), $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article2.PrixUnitaireLogicalToDisplay(pObject.Article2.PrixUnitaire), $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(44))
	Do tmpStream.Write(..Escape(pObject.Article3.Code, $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article3.Description, $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article3.QuantiteLogicalToDisplay(pObject.Article3.Quantite), $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article3.PrixUnitaireLogicalToDisplay(pObject.Article3.PrixUnitaire), $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(44))
	Do tmpStream.Write(..Escape(pObject.Article4.Code, $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article4.Description, $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article4.QuantiteLogicalToDisplay(pObject.Article4.Quantite), $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article4.PrixUnitaireLogicalToDisplay(pObject.Article4.PrixUnitaire), $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(44))
	Do tmpStream.Write(..Escape(pObject.Article5.Code, $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article5.Description, $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article5.QuantiteLogicalToDisplay(pObject.Article5.Quantite), $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(58) _ ..Escape(pObject.Article5.PrixUnitaireLogicalToDisplay(pObject.Article5.PrixUnitaire), $lb($char(44),$char(58)),"quote",$char(34)))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.MontanttotalHTLogicalToDisplay(pObject.MontanttotalHT), $lb($char(44),$char(58)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.TVALogicalToDisplay(pObject.TVA), $lb($char(44),$char(58)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.MontanttotalTTCLogicalToDisplay(pObject.MontanttotalTTC), $lb($char(44),$char(58)),"quote",$char(34)),1: ""))
	Set tStatus = tmpStream.Write($char(10))
	If $$$ISERR(tStatus) Quit tStatus
	Do pStream.CopyFrom(tmpStream,,0,.tStatus)
	Quit tStatus
}

ClassMethod GetGeneratedClasses(Output pClasses As %String) As %Status
{
	Kill pClasses
	Set pClasses("projet.messages.RM.facture.Record")=""
	Set pClasses("projet.messages.RM.facture.Record.Article1")=""
	Set pClasses("projet.messages.RM.facture.Record.Article2")=""
	Set pClasses("projet.messages.RM.facture.Record.Article3")=""
	Set pClasses("projet.messages.RM.facture.Record.Article4")=""
	Set pClasses("projet.messages.RM.facture.Record.Article5")=""
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
<Record xmlns="http://www.intersystems.com/Ensemble/RecordMap" name="projet.messages.RM.facture" type="delimited" char_encoding="UTF-8" targetClassname="projet.messages.RM.facture.Record" complexBatchManaged="0" padFromLeft="0" recordTerminator="\x0a" escaping="quote" escapeSequence="&quot;" allowEmbeddedRecordTerminator="0" allowEarlyTerminator="0">
  <Separators>
    <Separator>,</Separator>
    <Separator>:</Separator>
  </Separators>
  <Field name="Numérofacture" required="1" ignored="0" datatype="%String" sqlColumn="2" repeating="0">
  </Field>
  <Field name="Datefacture" required="1" ignored="0" datatype="%Date" params="FORMAT=3" sqlColumn="3" repeating="0">
  </Field>
  <Field name="Nomclient" required="0" ignored="0" datatype="%String" params="MAXLEN=&quot;&quot;" sqlColumn="4" repeating="0">
  </Field>
  <Field name="Adresseclient" required="0" ignored="0" datatype="%String" params="MAXLEN=&quot;&quot;" sqlColumn="5" repeating="0">
  </Field>
  <Field name="Codepostal" required="0" ignored="0" datatype="%String" params="MAXLEN=9" sqlColumn="6" repeating="0">
  </Field>
  <Field name="Ville" required="0" ignored="0" datatype="%String" params="MAXLEN=&quot;&quot;" sqlColumn="7" repeating="0">
  </Field>
  <Field name="Pays" required="0" ignored="0" datatype="%String" params="MAXLEN=&quot;&quot;" sqlColumn="8" repeating="0">
  </Field>
  <Composite name="Article1" required="0" ignored="0">
    <Field name="Article1.Code" required="0" ignored="0" datatype="%String" params="MAXLEN=6" repeating="0">
    </Field>
    <Field name="Article1.Description" required="0" ignored="0" datatype="%String" params="MAXLEN=&quot;&quot;" repeating="0">
    </Field>
    <Field name="Article1.Quantite" required="0" ignored="0" datatype="%Integer" repeating="0">
    </Field>
    <Field name="Article1.PrixUnitaire" required="0" ignored="0" datatype="%Double" params="SCALE=2" repeating="0">
    </Field>
  </Composite>
  <Composite name="Article2" required="0" ignored="0">
    <Field name="Article2.Code" required="0" ignored="0" datatype="%String" params="MAXLEN=6" repeating="0">
    </Field>
    <Field name="Article2.Description" required="0" ignored="0" datatype="%String" params="MAXLEN=&quot;&quot;" repeating="0">
    </Field>
    <Field name="Article2.Quantite" required="0" ignored="0" datatype="%Integer" repeating="0">
    </Field>
    <Field name="Article2.PrixUnitaire" required="0" ignored="0" datatype="%Double" params="SCALE=2" repeating="0">
    </Field>
  </Composite>
  <Composite name="Article3" required="0" ignored="0">
    <Field name="Article3.Code" required="0" ignored="0" datatype="%String" params="MAXLEN=6" repeating="0">
    </Field>
    <Field name="Article3.Description" required="0" ignored="0" datatype="%String" params="MAXLEN=&quot;&quot;" repeating="0">
    </Field>
    <Field name="Article3.Quantite" required="0" ignored="0" datatype="%Integer" repeating="0">
    </Field>
    <Field name="Article3.PrixUnitaire" required="0" ignored="0" datatype="%Double" params="SCALE=2" repeating="0">
    </Field>
  </Composite>
  <Composite name="Article4" required="0" ignored="0">
    <Field name="Article4.Code" required="0" ignored="0" datatype="%String" params="MAXLEN=6" repeating="0">
    </Field>
    <Field name="Article4.Description" required="0" ignored="0" datatype="%String" params="MAXLEN=&quot;&quot;" repeating="0">
    </Field>
    <Field name="Article4.Quantite" required="0" ignored="0" datatype="%Integer" repeating="0">
    </Field>
    <Field name="Article4.PrixUnitaire" required="0" ignored="0" datatype="%Double" params="SCALE=2" repeating="0">
    </Field>
  </Composite>
  <Composite name="Article5" required="0" ignored="0">
    <Field name="Article5.Code" required="0" ignored="0" datatype="%String" params="MAXLEN=6" repeating="0">
    </Field>
    <Field name="Article5.Description" required="0" ignored="0" datatype="%String" params="MAXLEN=&quot;&quot;" repeating="0">
    </Field>
    <Field name="Article5.Quantite" required="0" ignored="0" datatype="%Integer" repeating="0">
    </Field>
    <Field name="Article5.PrixUnitaire" required="0" ignored="0" datatype="%Double" params="SCALE=2" repeating="0">
    </Field>
  </Composite>
  <Field name="MontanttotalHT" required="0" ignored="0" datatype="%Double" params="SCALE=2" sqlColumn="14" repeating="0">
  </Field>
  <Field name="TVA" required="0" ignored="0" datatype="%Decimal" params="SCALE=2" sqlColumn="15" repeating="0">
  </Field>
  <Field name="MontanttotalTTC" required="0" ignored="0" datatype="%Double" params="SCALE=2" sqlColumn="16" repeating="0">
  </Field>
</Record>
}

}
