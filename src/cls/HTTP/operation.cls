Class HTTP.operation Extends EnsLib.REST.Operation
{

Parameter INVOCATION = "Queue";

/// Code département (sur 3 caractères)
Property Code As %String(DISPLAYLIST = ",AIN,AISNE,ALLIER,ALPES-DE-HAUTE-PROVENCE,HAUTES-ALPES,ALPES-MARITIMES,ARDÈCHE,ARDENNES,ARIÈGE,AUBE,AUDE,AVEYRON,BOUCHES-DU-RHÔNE,CALVADOS,CANTAL,CHARENTE,CHARENTE-MARITIME,CHER,CORRÈZE,CÔTE-D'OR,CÔTES-D'ARMOR,CREUSE,DORDOGNE,DOUBS,DRÔME,EURE,EURE-ET-LOIR,FINISTÈRE,GARD,HAUTE-GARONNE,GERS,GIRONDE,HÉRAULT,ILE-ET-VILAINE,INDRE,INDRE-ET-LOIRE,ISÈRE,JURA,LANDES,LOIR-ET-CHER,LOIRE,HAUTE-LOIRE,LOIRE-ATLANTIQUE,LOIRET,LOT,LOT-ET-GARONNE,LOZÈRE,MAINE-ET-LOIRE,MANCHE,MARNE,HAUTE-MARNE,MAYENNE,MEURTHE-ET-MOSELLE,MEUSE,MORBIHAN,MOSELLE,NIÈVRE,NORD,OISE,ORNE,PAS-DE-CALAIS,PUY-DE-DÔME,PYRÉNÉES-ATLANTIQUES,HAUTES-PYRÉNÉES,PYRÉNÉES-ORIENTALES,BAS-RHIN,HAUT-RHIN,RHÔNE,HAUTE-SAÔNE,SAÔNE-ET-LOIRE,SARTHE,SAVOIE,HAUTE-SAVOIE,PARIS,SEINE-MARITIME,SEINE-ET-MARNE,YVELINES,DEUX-SÈVRES,SOMME,TARN,TARN-ET-GARONNE,VAR,VAUCLUSE,VENDÉE,VIENNE,HAUTE-VIENNE,VOSGES,YONNE,TERRITOIRE DE BELFORT,ESSONNE,HAUTS-DE-SEINE,SEINE-SAINT-DENIS,VAL-DE-MARNE,VAL-D'OISE,GUADELOUPE,MARTINIQUE,GUYANE,RÉUNION,MAYOTTE,CORSE-DU-SUD,HAUTE-CORSE", VALUELIST = ",001,002,003,004,005,006,007,008,009,010,011,012,013,014,015,016,017,018,019,021,022,023,024,025,026,027,028,029,030,031,032,033,034,035,036,037,038,039,040,041,042,043,044,045,046,047,048,049,050,051,052,053,054,055,056,057,058,059,060,061,062,063,064,065,066,067,068,069,070,071,072,073,074,075,076,077,078,079,080,081,082,083,084,085,086,087,088,089,090,091,092,093,094,095,971,972,973,974,976,02a,02b") [ InitialExpression = "059", Required ];

/// Content-Type = "application/json"
Property ContentType As %String [ InitialExpression = "application/json", Required ];

Parameter SETTINGS = "Code:app,ContentType:app";

Method gender(pRequest As HTTP.msg.genderRequest, Output pResponse As HTTP.msg.genderResponse) As %Library.Status
{
    try{
	
		set sc = $$$OK
								
		set pResponse = ##class(HTTP.msg.genderResponse).%New()
        set httpRequest = ##class(%Net.HttpRequest).%New()
        set httpResponse = ##class(%Net.HttpRequest).%New()
        set url = ..Adapter.URL _ "?name=" _ pRequest.firstName
        
        #; $$$ThrowOnError(..Adapter.GetURL(..Adapter.HTTPServer,.pHttpResponse))
        $$$ThrowOnError(..Adapter.SendFormDataArray(.httpResponse,"GET",httpRequest,,,url))

        #; set sc = ..JSONStreamToObject(httpResponse.Data, .json) ; retourne un %ZEN.proxyObject (deprecated)
        #; set sc = json.SaveDocument("^aTRACE",$INCREMENT(^aTRACE))
        set json={}.%FromJSON(httpResponse.Data)
        $$$TRACE(json.%ClassName(1))

        $$$TRACE(json.%ToJSON())
        set pResponse.name=json.name
        set pResponse.gender=json.gender
        set pResponse.probability=json.probability
        set pResponse.count=json.count
      
        $$$TRACE("gender of :" _ pRequest.firstName _ " is " _ pResponse.gender)

	} catch exp{
		set sc = exp.AsStatus()
	}
	
 return sc
}

Method genderPy(pRequest As HTTP.msg.genderRequest, Output pResponse As HTTP.msg.genderResponse) As %Library.Status [ Language = python ]
{
import requests
import iris

pResponse= iris.cls('HTTP.msg.genderResponse')

# api-endpoint
URL = "http://api.genderize.io"

# location given here
firstname = pRequest.firstName
g = iris.gref("^SGTRACE")
g["request name"]=firstname

# defining a params dict for the parameters to be sent to the API
PARAMS = {'name':firstname}

# sending get request and saving the response as response object
r = requests.get(url = URL, params = PARAMS)

# extracting data in json format
data = r.json()

pResponse.name=data['name']
g["data name"]=data['name']
pResponse.gender=data['gender']
g["data gender"]=data['gender']
pResponse.probability=data['probability']
g["data probability"]=data['probability']
pResponse.count=data['count']
g["data count"]=data['count']
msg='gender of ' + pRequest.firstName + ' is ' + pResponse.gender
trace = iris.cls('Ens.Util.Trace').WriteTrace(msg,'HTTP','genderPy','gender')
g["trace"]=msg

return 1

#; # printing the output
#; print(" name:%s\n gender:%s\n probability:%s\ncount:%s"
#;     %(name, gender,probability, count))
}

Method test(pRequest As Ens.StringContainer, Output pResponse As Ens.StringContainer) As %Library.Status
{
    try{
	
		set sc = $$$OK
								
		set pResponse = ##class(Ens.StringContainer).%New()
        
        $$$ThrowOnError(..Adapter.GetURL(..Adapter.URL,.pHttpResponse))
        
        set data = ""
        while ('httpResponse.Data.AtEnd) {
            set data = data _ httpResponse.Data.Read()
        }

        set pResponse.StringValue=data
        
        $$$TRACE("data:"_pResponse.StringValue)

	} catch exp{
		set sc = exp.AsStatus()
	}
	
 return sc
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="Ens.StringContainer">
        <Method>test</Method>
    </MapItem>
    <MapItem MessageType="HTTP.msg.genderRequest">
        <Method>gender</Method>
    </MapItem>
</MapItems>
}

}
