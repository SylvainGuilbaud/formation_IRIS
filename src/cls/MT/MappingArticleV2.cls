/// Descriptionplu
Class MT.MappingArticleV2 Extends (%Persistent, %Populate) [ StorageStrategy = SQL ]
{

/// Description
Property PLU As %Integer;

Property ClefArt As %String(MAXLEN = 30);

Property Devise As %String;

Property PAREEL As %String;

Property PABRUT As %Numeric;

Property PAFRAIS As %Numeric;

// Property UV as %String;

// Property PCB as %String;

// Property PCBPF as %String;

// Property DesArticle as %String;

// Property DesArticleCourt as %String;

// Property PV as %String;

Property Fournisseur As %String(MAXLEN = 8);

Property RefFour As %String(MAXLEN = 50);

Property PVInit As %Numeric;

Property PVDateDu As %String;

// Property PVDateAu as %String;

Property PVFutur As %Numeric;

Property TVA As %Numeric;

Property INCONT As %Boolean;

Property PlieR As %String(MAXLEN = 3);

Property QteMinACommander As %Numeric;

// Property gnTHEME as %String;

Property DureeVieDu As %String;

Property DureeVieAu As %String;

Property Secteur As %String(MAXLEN = 2);

Property FamilleCompta As %String(MAXLEN = 4);

Property SFamilleCompta As %String(MAXLEN = 6);

Property UniteOeuvre As %String(MAXLEN = 10);

Property Univers As %String(MAXLEN = 4);

Property Rayon As %String(MAXLEN = 8);

Property Rayon1 As %String [ Calculated, SqlComputeCode = { Set {Rayon1}=$Piece({Rayon},"-",1)}, SqlComputed ];

Property Rayon2 As %String [ Calculated, SqlComputeCode = { Set {Rayon2}=$Piece({Rayon},"-",2)}, SqlComputed ];

Property Famille As %String(MAXLEN = 12);

Property SFamille As %String(MAXLEN = 16);

Property Categorie As %String(MAXLEN = 20);

Property SCategorieCompta As %String(MAXLEN = 10);

Property SCategorie As %String(MAXLEN = 24);

Property Laize As %String(MAXLEN = 10);

Property Raccord As %String(MAXLEN = 3);

Property HauteurRac As %Numeric;

Property LargeurRac As %Numeric;

Property Couleur As %String [ Calculated, SqlComputeCode = { Set {Couleur}=$Get(^COULEUR,"NOIR")}, SqlComputed ];

Property Entretien As %String(MAXLEN = 25);

Property Poids As %Numeric;

Property QteImpl As %Numeric;

Property DateLanceMag As %String;

Property DatePremLiv As %String;

Property DatePremLivDate As %Date(FORMAT = 4) [ Calculated, SqlComputeCode = { Set {DatePremLivDate}=$zdh({DatePremLiv},8)}, SqlComputed ];

Property TypeLiv As %Numeric;

Property Importateur As %String(MAXLEN = 8);

Property Fabricant As %String(MAXLEN = 8);

Property radConf As %Boolean;

Property PRBRUT As %Numeric;

Property PRFRAIS As %Numeric;

Property PRREEL As %Numeric;

Property PRMP As %Numeric;

Property CodeDouanier As %String(MAXLEN = 32);

Property Origine As %String(MAXLEN = 32);

Property Collection As %String(MAXLEN = 4);

Property CouleurTechnique As %String(MAXLEN = 25);

Property Statut As %Numeric;

Property DateStatut As %String;

Property DateStatutDate As %Date(FORMAT = 5) [ Calculated, SqlComputeCode = { Set {DateStatutDate}=$zdh({DateStatut},8)}, SqlComputed ];

Property radEstCM As %Boolean;

Property Composition As %String(MAXLEN = 50);

Property GereCD As %Boolean;

// Property radPente as %String;

// Property GerePF as %String;

// Property radCONFSTKSBM as %String;

// Property radCONFSTKMAG as %String;

// Property CBSurEmballage as %String;

// Property Rupture as %String;

Property NonRemisable As %Boolean;

// Property radEstCM as %String;

// Property Composition as %String;

Property radPente As %Boolean;

Property GerePF As %Boolean;

Property radCONFSTKSBM As %Boolean;

Property radCONFSTKMAG As %Boolean;

Property CBSurEmballage As %String(MAXLEN = 13);

Property Rupture As %Boolean;

Property Genre As %Numeric;

Property Saison As %Numeric;

Property Style As %Numeric;

Property idTheme As %Numeric;

Property Theme As %Numeric;

Property NivGamme As %Numeric;

Property WEBUNIVERS As %String(MAXLEN = 10);

Property WEBRAYON As %String(MAXLEN = 10);

Property WEBFAMILLE As %String(MAXLEN = 10);

Property PoidsBobineVide As %Numeric;

Property PoidsBobinePleine As %Numeric;

Property Datecreation As %String;

Property DatecreationDate As %Date(FORMAT = 4) [ Calculated, SqlComputeCode = { Set {DatecreationDate}=$zdh({Datecreation},8)}, SqlComputed ];

Property GereEnStock As %Boolean;

Property NomMotif As %String(MAXLEN = 30);

Property Periodicite As %String(MAXLEN = 4);

// Property DateRuptDebut as %String;

// Property DateRuptFin as %String;

Property CompositionSecondaire As %String(MAXLEN = 50);

Property WebTaille As %Numeric;

Property WebCouleur As %Numeric;

Property PoidsMandrin As %Numeric;

Property PoidsPlaquette As %Numeric;

// Property LettreRefCorner as %String;

Property PrixRefCorner As %Numeric;

Property PADEVISE As %Numeric;

// Property Devise as %String;

Property EstCONS As %Boolean;

// Property EstDuplique as %String;

// Property ADL as %String;

// Property Verrou as %String;

Property CodeBarre As %String;

// Property PremLiv as %String;

// Property MinPres as %String;

// Property PrixException as %String;

// Property PrixConcurrent as %String;

// Property FraisPA as %String;

// Property FraisPR as %String;

// Property ChaineSource as %String;

// Property ChaineCible as %String;

// Property PrixCorner as %String;

// Property TVAMULTIPAYS as %String;

// Property LABEL as %String;

/// Description
Index PLU On PLU [ IdKey ];

/// Description
Storage SQL
{
<Description>
<![CDATA[Description]]></Description>
<Property name="PLU"/>
<SQLMap name="Map1">
<Data name="CBSurEmballage">
<Delimiter>"\"</Delimiter>
<Piece>69</Piece>
</Data>
<Data name="Categorie">
<Delimiter>"\"</Delimiter>
<Piece>35</Piece>
</Data>
<Data name="ClefArt">
<Delimiter>"\"</Delimiter>
<Piece>1</Piece>
</Data>
<Data name="CodeBarre">
<RetrievalCode>s {*}=$o(^["POSEIDON"]PLU({L1},"CODEBARRE",""))</RetrievalCode>
</Data>
<Data name="CodeDouanier">
<Delimiter>"\"</Delimiter>
<Piece>55</Piece>
</Data>
<Data name="Collection">
<Delimiter>"\"</Delimiter>
<Piece>57</Piece>
</Data>
<Data name="Composition">
<Delimiter>"\"</Delimiter>
<Piece>63</Piece>
</Data>
<Data name="CompositionSecondaire">
<Delimiter>"\"</Delimiter>
<Piece>87</Piece>
</Data>
<Data name="CouleurTechnique">
<Delimiter>"\"</Delimiter>
<Piece>58</Piece>
</Data>
<Data name="DateLanceMag">
<Delimiter>"\"</Delimiter>
<Piece>45</Piece>
</Data>
<Data name="DatePremLiv">
<Delimiter>"\"</Delimiter>
<Piece>46</Piece>
</Data>
<Data name="DateStatut">
<Delimiter>"\"</Delimiter>
<Piece>60</Piece>
</Data>
<Data name="Datecreation">
<Delimiter>"\"</Delimiter>
<Piece>81</Piece>
</Data>
<Data name="Devise">
<Delimiter>"\"</Delimiter>
<Piece>2</Piece>
</Data>
<Data name="DureeVieAu">
<Delimiter>"\"</Delimiter>
<Piece>24</Piece>
</Data>
<Data name="DureeVieDu">
<Delimiter>"\"</Delimiter>
<Piece>23</Piece>
</Data>
<Data name="Entretien">
<Delimiter>"\"</Delimiter>
<Piece>42</Piece>
</Data>
<Data name="EstCONS">
<Delimiter>"\"</Delimiter>
<Piece>96</Piece>
</Data>
<Data name="Fabricant">
<Delimiter>"\"</Delimiter>
<Piece>49</Piece>
</Data>
<Data name="Famille">
<Delimiter>"\"</Delimiter>
<Piece>33</Piece>
</Data>
<Data name="FamilleCompta">
<Delimiter>"\"</Delimiter>
<Piece>26</Piece>
</Data>
<Data name="Fournisseur">
<Delimiter>"\"</Delimiter>
<Piece>12</Piece>
</Data>
<Data name="Genre">
<Delimiter>"\"</Delimiter>
<Piece>71</Piece>
</Data>
<Data name="GereCD">
<Delimiter>"\"</Delimiter>
<Piece>64</Piece>
</Data>
<Data name="GereEnStock">
<Delimiter>"\"</Delimiter>
<Piece>82</Piece>
</Data>
<Data name="GerePF">
<Delimiter>"\"</Delimiter>
<Piece>66</Piece>
</Data>
<Data name="HauteurRac">
<Delimiter>"\"</Delimiter>
<Piece>39</Piece>
</Data>
<Data name="INCONT">
<Delimiter>"\"</Delimiter>
<Piece>19</Piece>
</Data>
<Data name="Importateur">
<Delimiter>"\"</Delimiter>
<Piece>48</Piece>
</Data>
<Data name="Laize">
<Delimiter>"\"</Delimiter>
<Piece>37</Piece>
</Data>
<Data name="LargeurRac">
<Delimiter>"\"</Delimiter>
<Piece>40</Piece>
</Data>
<Data name="NivGamme">
<Delimiter>"\"</Delimiter>
<Piece>75</Piece>
</Data>
<Data name="NomMotif">
<Delimiter>"\"</Delimiter>
<Piece>83</Piece>
</Data>
<Data name="NonRemisable">
<Delimiter>"\"</Delimiter>
<Piece>61</Piece>
</Data>
<Data name="Origine">
<Delimiter>"\"</Delimiter>
<Piece>56</Piece>
</Data>
<Data name="PABRUT">
<Delimiter>"\"</Delimiter>
<Piece>4</Piece>
</Data>
<Data name="PADEVISE">
<Delimiter>"\"</Delimiter>
<Piece>94</Piece>
</Data>
<Data name="PAFRAIS">
<Delimiter>"\"</Delimiter>
<Piece>5</Piece>
</Data>
<Data name="PAREEL">
<Delimiter>"\"</Delimiter>
<Piece>3</Piece>
</Data>
<Data name="PRBRUT">
<Delimiter>"\"</Delimiter>
<Piece>51</Piece>
</Data>
<Data name="PRFRAIS">
<Delimiter>"\"</Delimiter>
<Piece>52</Piece>
</Data>
<Data name="PRMP">
<Delimiter>"\"</Delimiter>
<Piece>54</Piece>
</Data>
<Data name="PRREEL">
<Delimiter>"\"</Delimiter>
<Piece>53</Piece>
</Data>
<Data name="PVDateDu">
<Delimiter>"\"</Delimiter>
<Piece>15</Piece>
</Data>
<Data name="PVFutur">
<Delimiter>"\"</Delimiter>
<Piece>17</Piece>
</Data>
<Data name="PVInit">
<Delimiter>"\"</Delimiter>
<Piece>14</Piece>
</Data>
<Data name="Periodicite">
<Delimiter>"\"</Delimiter>
<Piece>84</Piece>
</Data>
<Data name="PlieR">
<Delimiter>"\"</Delimiter>
<Piece>20</Piece>
</Data>
<Data name="Poids">
<Delimiter>"\"</Delimiter>
<Piece>43</Piece>
</Data>
<Data name="PoidsBobinePleine">
<Delimiter>"\"</Delimiter>
<Piece>80</Piece>
</Data>
<Data name="PoidsBobineVide">
<Delimiter>"\"</Delimiter>
<Piece>79</Piece>
</Data>
<Data name="PoidsMandrin">
<Delimiter>"\"</Delimiter>
<Piece>90</Piece>
</Data>
<Data name="PoidsPlaquette">
<Delimiter>"\"</Delimiter>
<Piece>91</Piece>
</Data>
<Data name="PrixRefCorner">
<Delimiter>"\"</Delimiter>
<Piece>93</Piece>
</Data>
<Data name="QteImpl">
<Delimiter>"\"</Delimiter>
<Piece>44</Piece>
</Data>
<Data name="QteMinACommander">
<Delimiter>"\"</Delimiter>
<Piece>21</Piece>
</Data>
<Data name="Raccord">
<Delimiter>"\"</Delimiter>
<Piece>38</Piece>
</Data>
<Data name="Rayon">
<Delimiter>"\"</Delimiter>
<Piece>32</Piece>
</Data>
<Data name="RefFour">
<Delimiter>"\"</Delimiter>
<Piece>13</Piece>
</Data>
<Data name="Rupture">
<Delimiter>"\"</Delimiter>
<Piece>70</Piece>
</Data>
<Data name="SCategorie">
<Delimiter>"\"</Delimiter>
<Piece>36</Piece>
</Data>
<Data name="SCategorieCompta">
<Delimiter>"\"</Delimiter>
<Piece>29</Piece>
</Data>
<Data name="SFamille">
<Delimiter>"\"</Delimiter>
<Piece>34</Piece>
</Data>
<Data name="SFamilleCompta">
<Delimiter>"\"</Delimiter>
<Piece>27</Piece>
</Data>
<Data name="Saison">
<Delimiter>"\"</Delimiter>
<Piece>72</Piece>
</Data>
<Data name="Secteur">
<Delimiter>"\"</Delimiter>
<Piece>25</Piece>
</Data>
<Data name="Statut">
<Delimiter>"\"</Delimiter>
<Piece>59</Piece>
</Data>
<Data name="Style">
<Delimiter>"\"</Delimiter>
<Piece>73</Piece>
</Data>
<Data name="TVA">
<Delimiter>"\"</Delimiter>
<Piece>18</Piece>
</Data>
<Data name="Theme">
<Delimiter>"\"</Delimiter>
<Piece>22</Piece>
</Data>
<Data name="TypeLiv">
<Delimiter>"\"</Delimiter>
<Piece>47</Piece>
</Data>
<Data name="UniteOeuvre">
<Delimiter>"\"</Delimiter>
<Piece>30</Piece>
</Data>
<Data name="Univers">
<Delimiter>"\"</Delimiter>
<Piece>31</Piece>
</Data>
<Data name="WEBFAMILLE">
<Delimiter>"\"</Delimiter>
<Piece>78</Piece>
</Data>
<Data name="WEBRAYON">
<Delimiter>"\"</Delimiter>
<Piece>77</Piece>
</Data>
<Data name="WEBUNIVERS">
<Delimiter>"\"</Delimiter>
<Piece>76</Piece>
</Data>
<Data name="WebCouleur">
<Delimiter>"\"</Delimiter>
<Piece>89</Piece>
</Data>
<Data name="WebTaille">
<Delimiter>"\"</Delimiter>
<Piece>88</Piece>
</Data>
<Data name="idTheme">
<Delimiter>"\"</Delimiter>
<Piece>74</Piece>
</Data>
<Data name="radCONFSTKMAG">
<Delimiter>"\"</Delimiter>
<Piece>68</Piece>
</Data>
<Data name="radCONFSTKSBM">
<Delimiter>"\"</Delimiter>
<Piece>67</Piece>
</Data>
<Data name="radConf">
<Delimiter>"\"</Delimiter>
<Piece>50</Piece>
</Data>
<Data name="radEstCM">
<Delimiter>"\"</Delimiter>
<Piece>62</Piece>
</Data>
<Data name="radPente">
<Delimiter>"\"</Delimiter>
<Piece>65</Piece>
</Data>
<Global>^["POSEIDON"]PLU</Global>
<Structure>delimited</Structure>
<Subscript name="1">
<Expression>{PLU}</Expression>
</Subscript>
<Type>data</Type>
</SQLMap>
<StreamLocation>^test.MappingArticleS</StreamLocation>
<Type>%Storage.SQL</Type>
}

/// DescriptionZ
/// Description

}
