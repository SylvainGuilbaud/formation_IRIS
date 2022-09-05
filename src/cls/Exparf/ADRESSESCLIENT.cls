Class Exparf.ADRESSESCLIENT Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor) [ ClassType = persistent, SqlTableName = ADRESSES_CLIENT ]
{

Parameter IDPROPERTY = "ADCLID";

Property ADCLID As %BigInt [ SqlColumnNumber = 2, SqlFieldName = ADCL_ID ];

Property CLISId As %BigInt [ InitialExpression = 0, SqlColumnNumber = 3, SqlFieldName = CLIS_Id ];

Property ADRESSE As %Stream.GlobalCharacter [ SqlColumnNumber = 4, SqlFieldName = ADRESSE ];

Property ADCLCodePostal As %String(MAXLEN = "") [ SqlColumnNumber = 5, SqlFieldName = ADCL_CodePostal ];

Property ADCLVille As %String(MAXLEN = "") [ SqlColumnNumber = 6, SqlFieldName = ADCL_Ville ];

Property ADCLPays As %String(MAXLEN = "") [ SqlColumnNumber = 7, SqlFieldName = ADCL_Pays ];

Property ADCLTelephone As %String(MAXLEN = "") [ SqlColumnNumber = 8, SqlFieldName = ADCL_Telephone ];

Property ADCLZACZI As %String(MAXLEN = "") [ SqlColumnNumber = 9, SqlFieldName = ADCL_ZAC_ZI ];

Property ADCLLOT As %String(MAXLEN = "") [ SqlColumnNumber = 10, SqlFieldName = ADCL_LOT ];

Property ADCLGsm As %String(MAXLEN = "") [ SqlColumnNumber = 11, SqlFieldName = ADCL_Gsm ];

Property ADCLEmail As %String(MAXLEN = "") [ SqlColumnNumber = 12, SqlFieldName = ADCL_Email ];

Property ADCLContact As %String(MAXLEN = "") [ SqlColumnNumber = 13, SqlFieldName = ADCL_Contact ];

Property ADCLAdresse As %String(MAXLEN = "") [ SqlColumnNumber = 14, SqlFieldName = ADCL_Adresse ];

Property ADCLFacturation As %Boolean [ SqlColumnNumber = 15, SqlFieldName = ADCL_Facturation ];

Property ADCLLivraison As %Boolean [ SqlColumnNumber = 16, SqlFieldName = ADCL_Livraison ];

Property ADCLNOrdreaff As %Integer [ InitialExpression = 0, SqlColumnNumber = 17, SqlFieldName = ADCL_NOrdre_aff ];

Property PAYSId As %BigInt [ InitialExpression = 0, SqlColumnNumber = 18, SqlFieldName = PAYS_Id ];

Property IDVILLES As %BigInt [ InitialExpression = 0, SqlColumnNumber = 19, SqlFieldName = IDVILLES ];

Property sAdr1 As %String(MAXLEN = "") [ SqlColumnNumber = 20, SqlFieldName = sAdr1 ];

Property sAdr2 As %String(MAXLEN = "") [ SqlColumnNumber = 21, SqlFieldName = sAdr2 ];

Property sAdr3 As %String(MAXLEN = "") [ SqlColumnNumber = 22, SqlFieldName = sAdr3 ];

Property sNomSociete As %String(MAXLEN = "") [ SqlColumnNumber = 23, SqlFieldName = sNomSociete ];

Property sTVAIntraCom As %String(MAXLEN = "") [ SqlColumnNumber = 24, SqlFieldName = sTVAIntraCom ];

Property bDefaut As %Boolean [ SqlColumnNumber = 25, SqlFieldName = bDefaut ];

Property sConditions As %String(MAXLEN = "") [ SqlColumnNumber = 26, SqlFieldName = sConditions ];

Property sRemarques As %String(MAXLEN = "") [ SqlColumnNumber = 27, SqlFieldName = sRemarques ];

Property ProvinceEtat As %String(MAXLEN = "") [ SqlColumnNumber = 28, SqlFieldName = ProvinceEtat ];

Property nStatutTVA As %Integer [ InitialExpression = 0, SqlColumnNumber = 29, SqlFieldName = nStatutTVA ];

Property dDateDerniereVerifTVA As %Date [ SqlColumnNumber = 30, SqlFieldName = dDateDerniereVerifTVA ];

Property sAdresseLangue As %String(MAXLEN = "") [ SqlColumnNumber = 31, SqlFieldName = sAdresseLangue ];

Property sCodeAdresse As %String(MAXLEN = "") [ SqlColumnNumber = 32, SqlFieldName = sCodeAdresse ];

Property sCompteComptable As %String(MAXLEN = "") [ SqlColumnNumber = 33, SqlFieldName = sCompteComptable ];

Property bDefautFacture As %Boolean [ SqlColumnNumber = 34, SqlFieldName = bDefautFacture ];

Property bDefautLivraison As %Boolean [ SqlColumnNumber = 35, SqlFieldName = bDefautLivraison ];

Property bSiegeSocial As %Boolean [ SqlColumnNumber = 36, SqlFieldName = bSiegeSocial ];

Property bInactive As %Boolean [ SqlColumnNumber = 37, SqlFieldName = bInactive ];

Index ADCLIDind1 On ADCLID [ IdKey ];

Index CLISIdind2 On CLISId;

Index ADCLFacturationind3 On ADCLFacturation;

Index ADCLLivraisonind4 On ADCLLivraison;

Index ADCLNOrdreaffind5 On ADCLNOrdreaff;

Index PAYSIdind6 On PAYSId;

Index IDVILLESind7 On IDVILLES;

Index sTVAIntraComind8 On sTVAIntraCom;

Index nStatutTVAind9 On nStatutTVA;

Index dDateDerniereVerifTVAind10 On dDateDerniereVerifTVA;

Index sCodeAdresseind11 On sCodeAdresse;

Index bDefautFactureind12 On bDefautFacture;

Index bDefautLivraisonind13 On bDefautLivraison;

Index bSiegeSocialind14 On bSiegeSocial;

Index bInactiveind15 On bInactive;

Storage Default
{
<Data name="ADRESSESCLIENTDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CLISId</Value>
</Value>
<Value name="3">
<Value>ADRESSE</Value>
</Value>
<Value name="4">
<Value>ADCLCodePostal</Value>
</Value>
<Value name="5">
<Value>ADCLVille</Value>
</Value>
<Value name="6">
<Value>ADCLPays</Value>
</Value>
<Value name="7">
<Value>ADCLTelephone</Value>
</Value>
<Value name="8">
<Value>ADCLZACZI</Value>
</Value>
<Value name="9">
<Value>ADCLLOT</Value>
</Value>
<Value name="10">
<Value>ADCLGsm</Value>
</Value>
<Value name="11">
<Value>ADCLEmail</Value>
</Value>
<Value name="12">
<Value>ADCLContact</Value>
</Value>
<Value name="13">
<Value>ADCLAdresse</Value>
</Value>
<Value name="14">
<Value>ADCLFacturation</Value>
</Value>
<Value name="15">
<Value>ADCLLivraison</Value>
</Value>
<Value name="16">
<Value>ADCLNOrdreaff</Value>
</Value>
<Value name="17">
<Value>PAYSId</Value>
</Value>
<Value name="18">
<Value>IDVILLES</Value>
</Value>
<Value name="19">
<Value>sAdr1</Value>
</Value>
<Value name="20">
<Value>sAdr2</Value>
</Value>
<Value name="21">
<Value>sAdr3</Value>
</Value>
<Value name="22">
<Value>sNomSociete</Value>
</Value>
<Value name="23">
<Value>sTVAIntraCom</Value>
</Value>
<Value name="24">
<Value>bDefaut</Value>
</Value>
<Value name="25">
<Value>sConditions</Value>
</Value>
<Value name="26">
<Value>sRemarques</Value>
</Value>
<Value name="27">
<Value>ProvinceEtat</Value>
</Value>
<Value name="28">
<Value>nStatutTVA</Value>
</Value>
<Value name="29">
<Value>dDateDerniereVerifTVA</Value>
</Value>
<Value name="30">
<Value>sAdresseLangue</Value>
</Value>
<Value name="31">
<Value>sCodeAdresse</Value>
</Value>
<Value name="32">
<Value>sCompteComptable</Value>
</Value>
<Value name="33">
<Value>bDefautFacture</Value>
</Value>
<Value name="34">
<Value>bDefautLivraison</Value>
</Value>
<Value name="35">
<Value>bSiegeSocial</Value>
</Value>
<Value name="36">
<Value>bInactive</Value>
</Value>
</Data>
<DataLocation>^Exparf.ADRESSESCLIENTD</DataLocation>
<DefaultData>ADRESSESCLIENTDefaultData</DefaultData>
<IdLocation>^Exparf.ADRESSESCLIENTD</IdLocation>
<IndexLocation>^Exparf.ADRESSESCLIENTI</IndexLocation>
<StreamLocation>^Exparf.ADRESSESCLIENTS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
