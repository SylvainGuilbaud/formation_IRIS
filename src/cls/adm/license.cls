Class adm.license [ Language = python ]
{

ClassMethod check() As %Status
{
    import iris    
    iris.cls(__name__).diagnoseKey()
    iris.cls(__name__).cores()
    return 1
}

/// Check the validity of the IRIS license
ClassMethod diagnoseKey()
{
    import iris
    iris.routine('DiagnoseKey^%SYS.LICENSE',iris.cls('%SYSTEM.Util').ManagerDirectory()+'iris.key')
}

/// Description
ClassMethod cores()
{
    import iris
    print("\ngetting cores details")
    print(iris.cls('%SYSTEM.License').KeyCoresLicensed(),"cores licensed")
    #; iris.cls('%SYSTEM.CPU').Dump()
    print(iris.cls('%SYSTEM.CPU')._New().nCores,'cores on the server')
}

}
