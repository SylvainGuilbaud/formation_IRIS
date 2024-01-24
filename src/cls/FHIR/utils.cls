Class FHIR.utils
{

ClassMethod install(NAMESPACE As %String = "FHIRDEMO") As %Status
{
    set sc = $$$OK

    zn "HSLIB"
    Set appKey = "/"_$zcvt(NAMESPACE,"l")_"/fhir/r4"
    Set strategyClass = "HS.FHIRServer.Storage.Json.InteractionsStrategy"
    Set metadataConfigKey = "HL7v40"

    //Install a Foundation namespace and change to it
    Do ##class(HS.Util.Installer.Foundation).Install(NAMESPACE)

    zn NAMESPACE

    // Install elements that are required for a FHIR-enabled namespace
    Do ##class(HS.FHIRServer.Installer).InstallNamespace()

    // Install an instance of a FHIR Service into the current namespace
    Do ##class(HS.FHIRServer.Installer).InstallInstance(appKey, strategyClass, metadataConfigKey)
    #; do ##class(Ens.Director).StopProduction()

    #; zw $classmethod("Ens.Director", "SetAutoStart", NAMESPACE_"PKG.FoundationProduction", 0)

    #; set cspConfig = ##class(HS.Util.RESTCSPConfig).URLIndexOpen(appKey)
    #; set cspConfig.ServiceConfigName = "HS.FHIRServer.Interop.Service"
    #; set cspConfig.AllowUnauthenticatedAccess = 1
    #; zw cspConfig.%Save()

    #; set strategy = ##class(HS.FHIRServer.API.InteractionsStrategy).GetStrategyForEndpoint(appKey)
    #; set config = strategy.GetServiceConfigData()
    #; set config.DebugMode = 4
    #; do strategy.SaveServiceConfigData(config)

    return sc
}

/// Delete all resources from the FHIR Server
ClassMethod purge(pServiceName As %String = "/fhirhl7v2demo/fhir/r4") As %Status
{
    Try {
        set sc = $$$OK
        set strategy = ##class(HS.FHIRServer.API.InteractionsStrategy).GetStrategyForEndpoint(pServiceName)
        set options("deleteDataOnly") = 1
        do strategy.Delete(.options)
    }
    Catch ex {
        set sc=ex.AsStatus()
    }
        
    return sc
}

/// Load resources in the FHIR Server
ClassMethod load(pInputDirectory As %String = "/data/fhir/", pServiceType As %String = "FHIRServer", pServiceName As %String = "/fhir/r4", pDisplayProgress As %Boolean = 1) As %Status
{
    Try {
        set sc = $$$OK
        set sc = ##class(HS.FHIRServer.Tools.DataLoader).SubmitResourceFiles(pInputDirectory, pServiceType, pServiceName, pDisplayProgress)
    }
    Catch ex {
        set tSC=ex.AsStatus()
    }
    return sc
}

}