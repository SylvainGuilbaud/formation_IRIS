Class Exparf.BRIEFS Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor) [ ClassType = persistent, SqlTableName = BRIEFS ]
{

Parameter IDPROPERTY = "IDBRIEFS";

Property IDBRIEFS As %BigInt [ SqlColumnNumber = 2, SqlFieldName = IDBRIEFS ];

Property Numero As %Integer [ InitialExpression = 0, SqlColumnNumber = 3, SqlFieldName = Numero ];

Property DateCreation As %Date [ SqlColumnNumber = 4, SqlFieldName = DateCreation ];

Property DateLimiteEval As %Date [ SqlColumnNumber = 5, SqlFieldName = DateLimiteEval ];

Property DateLimiteClient As %Date [ SqlColumnNumber = 6, SqlFieldName = DateLimiteClient ];

Property CLISId As %BigInt [ InitialExpression = 0, SqlColumnNumber = 7, SqlFieldName = CLIS_Id ];

Property RefClient As %String(MAXLEN = "") [ SqlColumnNumber = 8, SqlFieldName = RefClient ];

Property Concept As %Stream.GlobalCharacter [ SqlColumnNumber = 9, SqlFieldName = Concept ];

Property DateReponse As %Date [ SqlColumnNumber = 10, SqlFieldName = DateReponse ];

Property PrixMax As %Float(SCALE = 2) [ InitialExpression = 0, SqlColumnNumber = 11, SqlFieldName = PrixMax ];

Property RemisParClient As %Boolean [ SqlColumnNumber = 12, SqlFieldName = RemisParClient ];

Property Potentiel As %Integer [ InitialExpression = 0, SqlColumnNumber = 13, SqlFieldName = Potentiel ];

Property DEVSId As %BigInt [ InitialExpression = 0, SqlColumnNumber = 14, SqlFieldName = DEVS_Id ];

Property INCOId As %BigInt [ InitialExpression = 0, SqlColumnNumber = 15, SqlFieldName = INCO_Id ];

Property Numero2 As %Integer [ InitialExpression = 0, SqlColumnNumber = 16, SqlFieldName = Numero2 ];

Property PrixRvt As %Float(SCALE = 2) [ InitialExpression = 0, SqlColumnNumber = 17, SqlFieldName = PrixRvt ];

Property Coeff As %Float(SCALE = 2) [ InitialExpression = 0, SqlColumnNumber = 18, SqlFieldName = Coeff ];

Property ComAgent As %Float(SCALE = 2) [ InitialExpression = 0, SqlColumnNumber = 19, SqlFieldName = ComAgent ];

Property RemiseAgent As %Float(SCALE = 2) [ InitialExpression = 0, SqlColumnNumber = 20, SqlFieldName = RemiseAgent ];

Property PrixTransport As %Float(SCALE = 2) [ InitialExpression = 0, SqlColumnNumber = 21, SqlFieldName = PrixTransport ];

Property AGENId As %BigInt [ InitialExpression = 0, SqlColumnNumber = 22, SqlFieldName = AGEN_Id ];

Property ReponseClient As %Stream.GlobalCharacter [ SqlColumnNumber = 23, SqlFieldName = ReponseClient ];

Property ContactClient As %String(MAXLEN = "") [ SqlColumnNumber = 24, SqlFieldName = ContactClient ];

Property AdrsLivraison As %Stream.GlobalCharacter [ SqlColumnNumber = 25, SqlFieldName = AdrsLivraison ];

Property Statut As %Boolean [ SqlColumnNumber = 26, SqlFieldName = Statut ];

Property EmailEnvoi As %Boolean [ SqlColumnNumber = 27, SqlFieldName = EmailEnvoi ];

Property IDBRIEFSRETOURS As %BigInt [ InitialExpression = 0, SqlColumnNumber = 28, SqlFieldName = IDBRIEFS_RETOURS ];

Property DateRetour As %Date [ SqlColumnNumber = 29, SqlFieldName = DateRetour ];

Property CLISID2 As %BigInt [ InitialExpression = 0, SqlColumnNumber = 30, SqlFieldName = CLIS_ID2 ];

Property CoeffNet As %Float(SCALE = 2) [ InitialExpression = 0, SqlColumnNumber = 31, SqlFieldName = CoeffNet ];

Property bEchant As %Boolean [ SqlColumnNumber = 32, SqlFieldName = bEchant ];

Property EchanRemark As %String(MAXLEN = "") [ SqlColumnNumber = 33, SqlFieldName = EchanRemark ];

Property DateExped As %Date [ SqlColumnNumber = 34, SqlFieldName = DateExped ];

Property AdrsLivraison2 As %Stream.GlobalCharacter [ SqlColumnNumber = 35, SqlFieldName = AdrsLivraison2 ];

Property AdrsLivraison3 As %Stream.GlobalCharacter [ SqlColumnNumber = 36, SqlFieldName = AdrsLivraison3 ];

Property ContactClient2 As %String(MAXLEN = "") [ SqlColumnNumber = 37, SqlFieldName = ContactClient2 ];

Property contactClient3 As %String(MAXLEN = "") [ SqlColumnNumber = 38, SqlFieldName = contactClient3 ];

Property bSpecEnvoi As %Boolean [ SqlColumnNumber = 39, SqlFieldName = bSpecEnvoi ];

Property EnvoiRemark As %String(MAXLEN = "") [ SqlColumnNumber = 40, SqlFieldName = EnvoiRemark ];

Property bOuvertEval As %Boolean [ SqlColumnNumber = 41, SqlFieldName = bOuvertEval ];

Property NumEtNum2 As %String(MAXLEN = "") [ SqlColumnNumber = 42, SqlFieldName = NumEtNum2 ];

Property BalLegis As %Stream.GlobalCharacter [ SqlColumnNumber = 43, SqlFieldName = BalLegis ];

Property BalLabApp As %Stream.GlobalCharacter [ SqlColumnNumber = 44, SqlFieldName = BalLabApp ];

Property bToutesBases As %Boolean [ SqlColumnNumber = 45, SqlFieldName = bToutesBases ];

Property DateEnvoieEmailCialRelance As %Date [ SqlColumnNumber = 46, SqlFieldName = DateEnvoieEmailCialRelance ];

Property ResultatSenso As %Boolean [ SqlColumnNumber = 47, SqlFieldName = ResultatSenso ];

Property Marketing As %Integer [ InitialExpression = 0, SqlColumnNumber = 48, SqlFieldName = Marketing ];

Property bXPZP As %Boolean [ SqlColumnNumber = 49, SqlFieldName = bXPZP ];

Property TypeXPZP As %Integer [ InitialExpression = 0, SqlColumnNumber = 50, SqlFieldName = TypeXPZP ];

Property ADCLIDLivr1 As %BigInt [ InitialExpression = 0, SqlColumnNumber = 51, SqlFieldName = ADCL_IDLivr1 ];

Property ADCLIDLivr2 As %BigInt [ InitialExpression = 0, SqlColumnNumber = 52, SqlFieldName = ADCL_IDLivr2 ];

Property ADCLIDLivr3 As %BigInt [ InitialExpression = 0, SqlColumnNumber = 53, SqlFieldName = ADCL_IDLivr3 ];

Property nType As %Integer [ InitialExpression = 0, SqlColumnNumber = 54, SqlFieldName = nType ];

Property nStatut As %Integer [ InitialExpression = 0, SqlColumnNumber = 55, SqlFieldName = nStatut ];

Property dDateModif As %Date [ SqlColumnNumber = 56, SqlFieldName = dDateModif ];

Property dDelaiSouhaiteClis As %Date [ SqlColumnNumber = 57, SqlFieldName = dDelaiSouhaiteClis ];

Property IDRCLIENTSCDC As %BigInt [ InitialExpression = 0, SqlColumnNumber = 58, SqlFieldName = IDR_CLIENTS_CDC ];

Property bPasdeCDC As %Boolean [ SqlColumnNumber = 59, SqlFieldName = bPasdeCDC ];

Property nstatutRglmtaire As %Integer [ InitialExpression = 0, SqlColumnNumber = 60, SqlFieldName = nstatutRglmtaire ];

Property nStatutApplication As %Integer [ InitialExpression = 0, SqlColumnNumber = 61, SqlFieldName = nStatutApplication ];

Property nStatutValidationNiveau1 As %Integer [ InitialExpression = 0, SqlColumnNumber = 62, SqlFieldName = nStatutValidationNiveau1 ];

Property nStatutCC As %Integer [ InitialExpression = 0, SqlColumnNumber = 63, SqlFieldName = nStatutCC ];

Property nStatutEval As %Integer [ InitialExpression = 0, SqlColumnNumber = 64, SqlFieldName = nStatutEval ];

Property nStatutParf As %Integer [ InitialExpression = 0, SqlColumnNumber = 65, SqlFieldName = nStatutParf ];

Property nStatutValidationNiveau2 As %Integer [ InitialExpression = 0, SqlColumnNumber = 66, SqlFieldName = nStatutValidationNiveau2 ];

Property bCreationCDC As %Boolean [ SqlColumnNumber = 67, SqlFieldName = bCreationCDC ];

Property bPasContrainteRglm As %Boolean [ SqlColumnNumber = 68, SqlFieldName = bPasContrainteRglm ];

Property NumeroB As %Library.String [ Calculated, SqlComputeCode = {set {*}=##class(Exparf.BRIEFS).CalculCleNumeroB({Numero},{Numero2})}, SqlComputed, SqlFieldName = NumeroB ];

Property CLISDateCreation As %Library.String [ Calculated, SqlComputeCode = {set {*}=##class(Exparf.BRIEFS).CalculCleCLISDateCreation({CLIS_Id},{DateCreation})}, SqlComputed, SqlFieldName = CLIS_DateCreation ];

// Index IDBRIEFSind1 On IDBRIEFS [ IdKey ];

Index IDBRIEFSind1 On IDBRIEFS;

Index Numeroind2 On Numero;

Index DateCreationind3 On DateCreation;

Index DateLimiteEvalind4 On DateLimiteEval;

Index DateLimiteClientind5 On DateLimiteClient;

Index CLISIdind6 On CLISId;

Index RefClientind7 On RefClient;

Index DateReponseind8 On DateReponse;

Index DEVSIdind9 On DEVSId;

Index INCOIdind10 On INCOId;

Index AGENIdind11 On AGENId;

Index IDBRIEFSRETOURSind12 On IDBRIEFSRETOURS;

Index CLISID2ind13 On CLISID2;

Index DateExpedind14 On DateExped;

Index NumEtNum2ind15 On NumEtNum2;

Index nTypeind16 On nType;

Index nStatutind17 On nStatut;

Index dDateModifind18 On dDateModif;

Index IDRCLIENTSCDCind19 On IDRCLIENTSCDC;

Index nstatutRglmtaireind20 On nstatutRglmtaire;

Index nStatutApplicationind21 On nStatutApplication;

Index nStatutValidationNiveau1ind22 On nStatutValidationNiveau1;

Index nStatutCCind23 On nStatutCC;

Index nStatutEvalind24 On nStatutEval;

Index nStatutParfind25 On nStatutParf;

Index nStatutValidationNiveau2ind26 On nStatutValidationNiveau2;

Index bPasContrainteRglmind27 On bPasContrainteRglm;

Method NumeroBGet() As %String
{
	q ..CalculCleNumeroB(..Numero,..Numero2)
}

ClassMethod CalculCleNumeroB(Numero As %BigInt, Numero2 As %Integer) As %String
{

 s sRetour=""
 s sRetour=sRetour_Numero
 s sRetour=sRetour_Numero2
 q sRetour
}

Method CLISDateCreationGet() As %String
{
	q ..CalculCleCLISDateCreation(..CLISId,..DateCreation)
}

ClassMethod CalculCleCLISDateCreation(CLISId As %BigInt, DateCreation As %Date) As %String
{

 s sRetour=""
 s sRetour=sRetour_CLISId
 s sRetour=sRetour_$ZD(DateCreation,8)
 q sRetour
}

Storage Default
{
<Data name="BRIEFSDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IDBRIEFS</Value>
</Value>
<Value name="3">
<Value>Numero</Value>
</Value>
<Value name="4">
<Value>DateCreation</Value>
</Value>
<Value name="5">
<Value>DateLimiteEval</Value>
</Value>
<Value name="6">
<Value>DateLimiteClient</Value>
</Value>
<Value name="7">
<Value>CLISId</Value>
</Value>
<Value name="8">
<Value>RefClient</Value>
</Value>
<Value name="9">
<Value>Concept</Value>
</Value>
<Value name="10">
<Value>DateReponse</Value>
</Value>
<Value name="11">
<Value>PrixMax</Value>
</Value>
<Value name="12">
<Value>RemisParClient</Value>
</Value>
<Value name="13">
<Value>Potentiel</Value>
</Value>
<Value name="14">
<Value>DEVSId</Value>
</Value>
<Value name="15">
<Value>INCOId</Value>
</Value>
<Value name="16">
<Value>Numero2</Value>
</Value>
<Value name="17">
<Value>PrixRvt</Value>
</Value>
<Value name="18">
<Value>Coeff</Value>
</Value>
<Value name="19">
<Value>ComAgent</Value>
</Value>
<Value name="20">
<Value>RemiseAgent</Value>
</Value>
<Value name="21">
<Value>PrixTransport</Value>
</Value>
<Value name="22">
<Value>AGENId</Value>
</Value>
<Value name="23">
<Value>ReponseClient</Value>
</Value>
<Value name="24">
<Value>ContactClient</Value>
</Value>
<Value name="25">
<Value>AdrsLivraison</Value>
</Value>
<Value name="26">
<Value>Statut</Value>
</Value>
<Value name="27">
<Value>EmailEnvoi</Value>
</Value>
<Value name="28">
<Value>IDBRIEFSRETOURS</Value>
</Value>
<Value name="29">
<Value>DateRetour</Value>
</Value>
<Value name="30">
<Value>CLISID2</Value>
</Value>
<Value name="31">
<Value>CoeffNet</Value>
</Value>
<Value name="32">
<Value>bEchant</Value>
</Value>
<Value name="33">
<Value>EchanRemark</Value>
</Value>
<Value name="34">
<Value>DateExped</Value>
</Value>
<Value name="35">
<Value>AdrsLivraison2</Value>
</Value>
<Value name="36">
<Value>AdrsLivraison3</Value>
</Value>
<Value name="37">
<Value>ContactClient2</Value>
</Value>
<Value name="38">
<Value>contactClient3</Value>
</Value>
<Value name="39">
<Value>bSpecEnvoi</Value>
</Value>
<Value name="40">
<Value>EnvoiRemark</Value>
</Value>
<Value name="41">
<Value>bOuvertEval</Value>
</Value>
<Value name="42">
<Value>NumEtNum2</Value>
</Value>
<Value name="43">
<Value>BalLegis</Value>
</Value>
<Value name="44">
<Value>BalLabApp</Value>
</Value>
<Value name="45">
<Value>bToutesBases</Value>
</Value>
<Value name="46">
<Value>DateEnvoieEmailCialRelance</Value>
</Value>
<Value name="47">
<Value>ResultatSenso</Value>
</Value>
<Value name="48">
<Value>Marketing</Value>
</Value>
<Value name="49">
<Value>bXPZP</Value>
</Value>
<Value name="50">
<Value>TypeXPZP</Value>
</Value>
<Value name="51">
<Value>ADCLIDLivr1</Value>
</Value>
<Value name="52">
<Value>ADCLIDLivr2</Value>
</Value>
<Value name="53">
<Value>ADCLIDLivr3</Value>
</Value>
<Value name="54">
<Value>nType</Value>
</Value>
<Value name="55">
<Value>nStatut</Value>
</Value>
<Value name="56">
<Value>dDateModif</Value>
</Value>
<Value name="57">
<Value>dDelaiSouhaiteClis</Value>
</Value>
<Value name="58">
<Value>IDRCLIENTSCDC</Value>
</Value>
<Value name="59">
<Value>bPasdeCDC</Value>
</Value>
<Value name="60">
<Value>nstatutRglmtaire</Value>
</Value>
<Value name="61">
<Value>nStatutApplication</Value>
</Value>
<Value name="62">
<Value>nStatutValidationNiveau1</Value>
</Value>
<Value name="63">
<Value>nStatutCC</Value>
</Value>
<Value name="64">
<Value>nStatutEval</Value>
</Value>
<Value name="65">
<Value>nStatutParf</Value>
</Value>
<Value name="66">
<Value>nStatutValidationNiveau2</Value>
</Value>
<Value name="67">
<Value>bCreationCDC</Value>
</Value>
<Value name="68">
<Value>bPasContrainteRglm</Value>
</Value>
</Data>
<DataLocation>^Exparf.BRIEFSD</DataLocation>
<DefaultData>BRIEFSDefaultData</DefaultData>
<IdLocation>^Exparf.BRIEFSD</IdLocation>
<IndexLocation>^Exparf.BRIEFSI</IndexLocation>
<StreamLocation>^Exparf.BRIEFSS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
