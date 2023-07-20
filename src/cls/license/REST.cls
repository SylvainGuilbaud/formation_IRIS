Class license.REST Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>

<Route Url="/features" Method="GET" Call="GetFeatures" Cors="true"/>

</Routes>
}

/// Description
ClassMethod GetFeatures() As %Status
{
    Set sc = $$$OK
    set %response.ContentType = ..#CONTENTTYPEJSON
    
    set json={}
    set json."Web Add-on" = ($SYSTEM.License.GetFeature(0)) 
    set json."Interoperability" = ($SYSTEM.License.GetFeature(1)) 
    set json."Shadowing"= ($SYSTEM.License.GetFeature(2))
    set json."BI User (runtime)"= ($SYSTEM.License.GetFeature(3))
    set json."BI Development"= ($SYSTEM.License.GetFeature(4))
    set json."HealthShare"= ($SYSTEM.License.GetFeature(5))
    set json."TrakCare"= ($SYSTEM.License.GetFeature(6))
    set json."IP Address Neutral"= ($SYSTEM.License.GetFeature(7))
    set json."Analytics Run"= ($SYSTEM.License.GetFeature(8))
    set json."Analytics Analyzer"= ($SYSTEM.License.GetFeature(9))
    set json."Analytics Architect"= ($SYSTEM.License.GetFeature(10))
    set json."NLP"= ($SYSTEM.License.GetFeature(11))
    set json."HealthShare Foundation"= ($SYSTEM.License.GetFeature(12))
    set json."C-Type License"= ($SYSTEM.License.GetFeature(13))
    set json."Analytics VR Execute"= ($SYSTEM.License.GetFeature(14))
    set json."ExtremeNoUserLimit"= ($SYSTEM.License.GetFeature(15))
    set json."Analytics VR Format"= ($SYSTEM.License.GetFeature(16))
    set json."Analytics VR Data Define"= ($SYSTEM.License.GetFeature(17))
    set json."Sharding"= ($SYSTEM.License.GetFeature(18))
    set json."IntegratedML"= ($SYSTEM.License.GetFeature(19))
    set json."InterSystems IRIS"= ($SYSTEM.License.GetFeature(20))
    set json."API Management"= ($SYSTEM.License.GetFeature(21))
    set json."Compatibility"= ($SYSTEM.License.GetFeature(22))
    set json."Security Waiver"= ($SYSTEM.License.GetFeature(23))
    set json."FHIR Repository"= ($SYSTEM.License.GetFeature(24))
    set json."Columnar Storage"= ($SYSTEM.License.GetFeature(25))
    set json."FHIR SQL Builder"= ($SYSTEM.License.GetFeature(26))
    set json."Foreign Tables"= ($SYSTEM.License.GetFeature(27))

    set json."KeyAuthorizationKey" = ($SYSTEM.License.KeyAuthorizationKey())

    set json."KeyCPUsEnforced" = ($SYSTEM.License.KeyCPUsEnforced())
    set json."KeyCPUsLicensed" = ($SYSTEM.License.KeyCPUsLicensed())
    set json."KeyCoresEnforced" = ($SYSTEM.License.KeyCoresEnforced())
    set json."KeyCoresLicensed" = ($SYSTEM.License.KeyCoresLicensed())

    set json."KeyCustomerName" = ($SYSTEM.License.KeyCustomerName())

    set json."KeyEnforcedUnits" = ($SYSTEM.License.KeyEnforcedUnits())

    set json."KeyExpirationDate" = $zd($SYSTEM.License.KeyExpirationDate(),3)

    set json."KeyFileType" = ($SYSTEM.License.KeyFileType(0))

    do json.%ToJSON()
    Return sc
}

}
