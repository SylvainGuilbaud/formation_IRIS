/// page that displays national flags for each currency
Class FCE.Pages.CurrencyImage Extends %ZEN.Component.page
{

/// Class name of application this page belongs to.
Parameter APPLICATION;

/// Displayed name of this page.
Parameter PAGENAME = "CurrencyImage";

/// Domain used for localization.
Parameter DOMAIN;

/// Name of currently visible image
Property Current As %String;

/// This Style block contains page-specific CSS style definitions.
XData Style
{
<style type="text/css">
/* style for title bar */
#title {
	background: #C5D6D6;
	color: black;
	font-family: Verdana;
	font-size: 1.5em;
	font-weight: bold;
	padding: 5px;
	border-bottom: 1px solid black;
	text-align: center;
}
</style>
}

/// This XML block defines the contents of this page.
XData Contents [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<page id="page" xmlns="http://www.intersystems.com/zen" title="FCE Currency Images">
<label id="title" value="FCE Currency Images"/>
<dataCombo id="cmbCurrencies" label="Choose a currency" sql="select ID, currency from fce.currency order by currency"
           onchange="zenPage.showImage();"/>
<spacer height="40px"/>

</page>
}

ClientMethod showImage() [ Language = javascript ]
{
	imagelist = ["USD", "EUR", "INR", "GBP", "JPY",
	             "MXN", "ZAR", "BRL", "CAD", "CHF"];

	if (zenPage.Current != "") {
		zenSetProp(zenPage.Current,"hidden",true);
	}
	
	index = zenThis.getValue() - 1;
	component = "img".concat(imagelist[index]);
	zenSetProp(component,"hidden",false);
	zenPage.Current = component;
}

/// Load ALL images ahead of time; add hidden component for each image
Method %OnAfterCreatePage() As %Status
{
	#dim %page as %ZEN.Component.page
	set abbreviations = ##class(FCE.CurrencyName).#VALUELIST
	set currencies = ##class(FCE.Currency).ConvertCurrenciestoListString(abbreviations)
	for i=1:1:$listlength(currencies) {
		set componentID = "img" _ $list(currencies, i)
		#dim img as %ZEN.Component.image
		set img = ##class(%ZEN.Component.image).%New()
		set img.id = componentID, img.hidden = 1
		do %page.%AddChild(img)
		#dim currencyImage as %Stream.GlobalBinary
		set currencyImage = ##class(FCE.Currency).%OpenId(i).Image
		set oid = currencyImage.%Oid()
		set img.streamId = oid
	}	
	return $$$OK
}

}
