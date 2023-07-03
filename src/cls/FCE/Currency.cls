/// Currency exchange rates and images, and other utilities
Class FCE.Currency Extends %Persistent [ DependsOn = FCE.CurrencyName ]
{

/// currency abbreviations, computed at COMPILE time (therefore requires DependsOn above)
Parameter ABBREVIATIONS = {##class(FCE.CurrencyName).#VALUELIST};

/// access key for apilayer.net (can contain spaces for clarity), for InterSystems training use ONLY!
Parameter ACCESSKEY;

/// default rates in case call to apilayer.net fails
Parameter DEFAULTRATES = "{""USDEUR"":1,""USDINR"":65,""USDGBP"":1,""USDJPY"":110,""USDMXN"":20,""USDZAR"":15,""USDBRL"":3,""USDCAD"":1,""USDCHF"":1}";

/// Currency is an alternate key
Property Currency As FCE.CurrencyName [ Required ];

Index CurrencyIndex On Currency [ Unique ];

/// 1 USD in each currency
Property USDExchangeRate As %Decimal(MINVAL = .001, SCALE = 3);

Property Image As %Stream.GlobalBinary;

/// %List returntype is a $list string
ClassMethod ConvertCurrenciestoListString(valuelist As %String) As %List
{
	set delim = $extract(valuelist, 1)
	set currencies = $extract(valuelist, 2, *)
	set currencies = $listfromstring(currencies, delim)
	return currencies
}

/// fetch currency rates from currencylayer.com as JSON with a REST Get
ClassMethod FetchRates(verbose As %Boolean = 0) As %Status
{
	#dim currency as FCE.Currency
	// create USD object if it doesn't exist already
	if '(..CurrencyIndexExists("USD")) {
		set currency = ..%New()
		set currency.Currency = "USD"
		set currency.USDExchangeRate = 1
		do currency.%Save()
		write:verbose !, "created USD object"
	}
	
	// now create/update the rest of the exchange rates
	set abbreviations = ..#ABBREVIATIONS
	set delim = $extract(abbreviations, 1)
	// skip first currency (USD) and get the rest
	set currencies = $piece(abbreviations, delim, 3, *)
	// change current delimiter to ,
	set currencies = $translate(currencies, delim, ",")

	#dim formatter as %JSON.Formatter
	set formatter = ##class(%JSON.Formatter).%New()
	#dim request as %Net.HttpRequest
	#dim response, rates as %DynamicObject
	set request = ##class(%Net.HttpRequest).%New()
	set request.Server = "apilayer.net"
	set uri = "/api/live?access_key=" _ 
			  $translate(..#ACCESSKEY, " ") _
	          "&currencies=" _ currencies _
	          "&source=USD&format=1"
	set stGet = request.Get(uri)
	if ($$$ISERR(stGet) || (request.HttpResponse.StatusCode '= 200)) {
		do $system.Status.DisplayError(stGet)
		set rates = ""
	}
	else {
		// convert the response into a JSON object
		set response = ##class(%DynamicObject).%FromJSON(request.HttpResponse.Data) 
		if verbose {
			write !, "Entire response:", !
			do formatter.Format(response)  // or "write response.%ToJSON()"
			write !
		}
		// get the rates from the quotes property (also JSON)
		set rates = response.quotes
	}
	if '$isobject(rates) {	
		// create JSON from DEFAULTRATES
		set rates = ##class(%DynamicObject).%FromJSON(..#DEFAULTRATES)
	}
	
	if verbose {
		write !, "Rates:", !
		do formatter.Format(rates)  // or "write rates.%ToJSON()"
		write !
	}
	
	// iterate through the JSON object
	write:verbose !, "Loading rates..."
	#dim i as %Iterator.Object
	set i = rates.%GetIterator()
	while i.%GetNext(.key, .value) {
		write:verbose !, key _ ":" _ value
		// the keys look like USDEUR so get the last 3 characters 
		set currencyName = $extract(key, 4, 6)
		// create or update the currency
		if '(..CurrencyIndexExists(currencyName)) {
			set currency = ..%New()
			set currency.Currency = currencyName
		}
		else {
			set currency = ..CurrencyIndexOpen(currencyName)
		}
		set currency.USDExchangeRate = value
		set stSave = currency.%Save()
		if $$$ISERR(stSave) {
			do $system.Status.DisplayError(stSave)
		}
	}
	return $system.Status.AppendStatus(stGet, stSave)
}

/// compute exchange rate between two currencies based on the USD rate
ClassMethod ComputeRate(currencyIn As FCE.CurrencyName, currencyOut As FCE.CurrencyName) As %Decimal(SCALE=3) [ SqlProc ]
{
	// get the exchange rate between USD and currencyIn
	&sql(SELECT USDExchangeRate INTO :inRate
	     FROM FCE.Currency
	     WHERE Currency = :currencyIn)
	set sqlcode1 = SQLCODE

	// get the exchange rate between USD and currencyOut
	&sql(SELECT USDExchangeRate INTO :outRate
	     FROM FCE.Currency
	     WHERE Currency = :currencyOut)
	set sqlcode2 = SQLCODE

	if (sqlcode1 = 0) && (sqlcode2 = 0) {
		// compute the exchange rate between currencyIn and currencyOut
		return (outRate / inRate)
	}
	else {
		write !, "Error code(s): ", sqlcode1, " ", sqlcode2
		return 0
	}
}

/// Load images from a directory; should only need to run once
/// Note: filenames MUST correspond to VALUELIST from FCE.CurrencyName class</Description>
ClassMethod ImportImages(directory As %String)
{
	set currencies = ..ConvertCurrenciestoListString(..#ABBREVIATIONS)
	
	for image = 1: 1 : $listlength(currencies)
	{
		set currencyName = $list(currencies, image)
		#dim currency as FCE.Currency
		set currency = ##class(FCE.Currency).CurrencyIndexOpen(currencyName)
	
		#dim file as %Stream.FileBinary
		set file = ##class(%Stream.FileBinary).%New()
		set file.Filename = directory _ currencyName _ ".jpg"
		
		// does file exist?
		if (file.Size = 0) {
			write !, "Couldn't import ", file.Filename, !
			do $system.Status.DisplayError(%objlasterror)
			continue
		}
		
		do currency.Image.CopyFrom(file)
		set status = currency.%Save()
		do $system.Status.DisplayError(status)
		write !, currencyName, " imported"
		
		set file = ""
		set currency = ""
	}
}

Storage Default
{
<Data name="CurrencyDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Currency</Value>
</Value>
<Value name="3">
<Value>USDExchangeRate</Value>
</Value>
<Value name="4">
<Value>Image</Value>
</Value>
</Data>
<DataLocation>^FCE.CurrencyD</DataLocation>
<DefaultData>CurrencyDefaultData</DefaultData>
<IdLocation>^FCE.CurrencyD</IdLocation>
<IndexLocation>^FCE.CurrencyI</IndexLocation>
<StreamLocation>^FCE.CurrencyS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
