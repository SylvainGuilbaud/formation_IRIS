/// RECORDMAP: Modified during compilation of RecordMap 'opendata.RM.hatvp'
/// on 2022-12-08 at 11:16:27.757 [2022-12-08 11:16:27.757 UTC]
/// by user _SYSTEM
Class opendata.RM.hatvp Extends EnsLib.RecordMap.RecordMap
{

Parameter OBJECTNAME = "opendata.RM.hatvp.Record";

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
	Set tSeps = $listbuild($char(59),$char(47),$char(46))
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Else {
		Set tCurrString = tRecordData(tCurrChunk)
		Set tCurrPiece = 1
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.civilite = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.prenom = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.nom = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.classement = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.typemandat = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.qualite = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.typedocument = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.departement = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.datepublication =  pObject.datepublicationDisplayToLogical(tCurrString)
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.datedepot =  pObject.datedepotDisplayToLogical(tCurrString)
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.nomfichier = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.urldossier = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.opendata = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.statutpublication = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.idorigine = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	Set tStrings(tStrings) = tCurrString
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(47), 1)
	Set tStrings = tStrings + 1
	Set pObject.urlphoto.NewField1 = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(47), 2)
	Set tStrings = tStrings + 1
	Set pObject.urlphoto.NewField2 = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(47), 3)
	Set tStrings = tStrings + 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(46), 1)
	Set tStrings = tStrings + 1
	Set pObject.urlphoto.domaine.www = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(46), 2)
	Set tStrings = tStrings + 1
	Set pObject.urlphoto.domaine.chambre = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(46), 3)
	Set tStrings = tStrings + 1
	Set pObject.urlphoto.domaine.fr = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(47), 4)
	Set tStrings = tStrings + 1
	Set pObject.urlphoto.NewField4 = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Set tStrings(tStrings+1) = $piece(tStrings(tStrings), $char(47), 5)
	Set tStrings = tStrings + 1
	Set pObject.urlphoto.NewField5 = tStrings(tStrings)
	Kill tStrings(tStrings)
	Set tStrings = tStrings - 1
	Quit tStatus
}

/// Internal helper method to output object to a stream
ClassMethod PutRecord(pStream As %IO.DeviceStream, pObject As %RegisteredObject, pHasTopFields As %Boolean, ByRef pPadArray As %String) As %Status [ Internal, Private ]
{
	Set tStatus = $$$OK
	Set tmpStream=##class(%Stream.TmpBinary).%New()
	Do tmpStream.Write($select(pHasTopFields: ..Escape(pObject.civilite, $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.prenom, $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.nom, $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.classement, $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.typemandat, $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.qualite, $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.typedocument, $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.departement, $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.datepublicationLogicalToDisplay(pObject.datepublication), $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.datedepotLogicalToDisplay(pObject.datedepot), $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.nomfichier, $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.urldossier, $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.opendata, $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.statutpublication, $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.idorigine, $lb($char(59),$char(47),$char(46)),"quote",$char(34)),1: ""))
	Do tmpStream.Write($char(59))
	Do tmpStream.Write(..Escape(pObject.urlphoto.NewField1, $lb($char(59),$char(47),$char(46)),"quote",$char(34)))
	Do tmpStream.Write($char(47) _ ..Escape(pObject.urlphoto.NewField2, $lb($char(59),$char(47),$char(46)),"quote",$char(34)))
	Do tmpStream.Write($char(47))
	Do tmpStream.Write(..Escape(pObject.urlphoto.domaine.www, $lb($char(59),$char(47),$char(46)),"quote",$char(34)))
	Do tmpStream.Write($char(46) _ ..Escape(pObject.urlphoto.domaine.chambre, $lb($char(59),$char(47),$char(46)),"quote",$char(34)))
	Do tmpStream.Write($char(46) _ ..Escape(pObject.urlphoto.domaine.fr, $lb($char(59),$char(47),$char(46)),"quote",$char(34)))
	Do tmpStream.Write($char(47) _ ..Escape(pObject.urlphoto.NewField4, $lb($char(59),$char(47),$char(46)),"quote",$char(34)))
	Do tmpStream.Write($char(47) _ ..Escape(pObject.urlphoto.NewField5, $lb($char(59),$char(47),$char(46)),"quote",$char(34)))
	Set tStatus = tmpStream.Write($char(10))
	If $$$ISERR(tStatus) Quit tStatus
	Do pStream.CopyFrom(tmpStream,,0,.tStatus)
	Quit tStatus
}

ClassMethod GetGeneratedClasses(Output pClasses As %String) As %Status
{
	Kill pClasses
	Set pClasses("opendata.RM.hatvp.Record")=""
	Set pClasses("opendata.RM.hatvp.Record.urlphoto")=""
	Set pClasses("opendata.RM.hatvp.Record.urlphoto.domaine")=""
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
<Record xmlns="http://www.intersystems.com/Ensemble/RecordMap" name="opendata.RM.hatvp" type="delimited" char_encoding="UTF-8" targetClassname="opendata.RM.hatvp.Record" complexBatchManaged="0" padFromLeft="0" recordTerminator="\x0a" escaping="quote" escapeSequence="&quot;" allowEmbeddedRecordTerminator="0" allowEarlyTerminator="0">
  <Separators>
    <Separator>;</Separator>
    <Separator>/</Separator>
    <Separator>.</Separator>
  </Separators>
  <Field name="civilite" datatype="%String" sqlColumn="2">
  </Field>
  <Field name="prenom" datatype="%String" sqlColumn="3">
  </Field>
  <Field name="nom" datatype="%String" sqlColumn="4">
  </Field>
  <Field name="classement" datatype="%String" sqlColumn="5">
  </Field>
  <Field name="typemandat" datatype="%String" sqlColumn="6">
  </Field>
  <Field name="qualite" datatype="%String" sqlColumn="7">
  </Field>
  <Field name="typedocument" datatype="%String" sqlColumn="8">
  </Field>
  <Field name="departement" datatype="%String" sqlColumn="9">
  </Field>
  <Field name="datepublication" required="0" ignored="0" datatype="%Date" params="FORMAT=3" sqlColumn="10" repeating="0">
  </Field>
  <Field name="datedepot" required="0" ignored="0" datatype="%Date" params="FORMAT=3" sqlColumn="11" repeating="0">
  </Field>
  <Field name="nomfichier" required="0" ignored="0" datatype="%String" sqlColumn="12" repeating="0">
  </Field>
  <Field name="urldossier" datatype="%String" sqlColumn="13">
  </Field>
  <Field name="opendata" datatype="%String" sqlColumn="14">
  </Field>
  <Field name="statutpublication" datatype="%String" sqlColumn="15">
  </Field>
  <Field name="idorigine" datatype="%String" sqlColumn="16">
  </Field>
  <Composite name="urlphoto" required="0" ignored="0">
    <Field name="urlphoto.NewField1" required="0" ignored="0" datatype="%String" repeating="0">
    </Field>
    <Field name="urlphoto.NewField2" required="0" ignored="0" datatype="%String">
    </Field>
    <Composite name="urlphoto.domaine" required="0" ignored="0">
      <Field name="urlphoto.domaine.www" required="0" ignored="0" datatype="%String" repeating="0">
      </Field>
      <Field name="urlphoto.domaine.chambre" required="0" ignored="0" datatype="%String" repeating="0">
      </Field>
      <Field name="urlphoto.domaine.fr" required="0" ignored="0" datatype="%String" repeating="0">
      </Field>
    </Composite>
    <Field name="urlphoto.NewField4" required="0" ignored="0" datatype="%String">
    </Field>
    <Field name="urlphoto.NewField5" required="0" ignored="0" datatype="%String">
    </Field>
  </Composite>
</Record>
}

}
