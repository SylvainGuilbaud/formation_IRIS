/// 
Class opendata.RM Extends EnsLib.RecordMap.RecordMap
{

XData RecordMap [ XMLNamespace = "http://www.intersystems.com/Ensemble/RecordMap" ]
{
<Record xmlns="http://www.intersystems.com/Ensemble/RecordMap" name="opendata.RM" type="delimited" char_encoding="UTF-8" targetClassname="opendata.RM.Record" recordTerminator="\x0a" escaping="quote" escapeSequence="&quot;" allowEmbeddedRecordTerminator="0">
  <Separators>
    <Separator>;</Separator>
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
  <Field name="datepublication" datatype="%String" sqlColumn="10">
  </Field>
  <Field name="datedepot" datatype="%String" sqlColumn="11">
  </Field>
  <Field name="nomfichier" datatype="%String" sqlColumn="12">
  </Field>
  <Field name="urldossier" datatype="%String" sqlColumn="13">
  </Field>
  <Field name="opendata" datatype="%String" sqlColumn="14">
  </Field>
  <Field name="statutpublication" datatype="%String" sqlColumn="15">
  </Field>
  <Field name="idorigine" datatype="%String" sqlColumn="16">
  </Field>
  <Field name="urlphoto" datatype="%String" sqlColumn="17">
  </Field>
</Record>
}

}
