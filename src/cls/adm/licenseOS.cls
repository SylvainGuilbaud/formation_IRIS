Class adm.licenseOS [ Language = objectscript ]
{

/// Description
ClassMethod check() As %Status
{
    Set sc = $$$OK
    do ..diagnoseKey()
    do ..cores()
    Return sc
}

ClassMethod diagnoseKey()
{
    do DiagnoseKey^%SYS.LICENSE(##class(%SYSTEM.Util).ManagerDirectory()_"iris.key")
}

ClassMethod cores()
{
    #; do ##class(%SYSTEM.CPU).Dump()

    write !!,"checking cores:",!
    set cores=##class(%SYSTEM.License).KeyCoresLicensed()
    write cores," cores licensed",!
    set cpu=##class(%SYSTEM.CPU).%New()
    write cpu.nCores," cores on the server",!
}

}
