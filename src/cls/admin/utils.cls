Class admin.utils Extends %RegisteredObject
{

ClassMethod upgrade(verbose As %Boolean = 0) As %Status
{
    set ns=$Namespace
    // Stopping all productions
    do ..stopAllProductions(verbose)
    zn "%sys"
    kill ^[ns]upgradeLog
    // UpgradeAll
    set ^[ns]upgradeLog("UpgradeAll")=$zdt($now(),3,,6)
    set start=$zh
    do $system.OBJ.UpgradeAll(,.errorLogUpgrade)
    do ##class(%SYSTEM.OBJ).UpgradeAll()
    set ^[ns]upgradeLog("UpgradeAll","duration")=$zh-start
    merge ^[ns]upgradeLog("UpgradeAll","errors")=errorLogUpgrade
    // Compile Classes in All Namespaces
    set ^[ns]upgradeLog("classes")=$zdt($now(),3,,6)
    set start=$zh
    do $system.OBJ.CompileAllNamespaces("cbk",.errorLogClasses)
    set ^[ns]upgradeLog("classes","duration")=$zh-start
    merge ^[ns]upgradeLog("classes","errors")=errorLogClasses
    // Compile Routines in All Namespaces
    set ^[ns]upgradeLog("routines")=$zdt($now(),3,,6)
    set start=$zh
    do ##Class(%Library.Routine).CompileAllNamespaces(,,.count,.errorLogRoutines)
    set ^[ns]upgradeLog("routines","duration")=$zh-start
    merge ^[ns]upgradeLog("routines","errors")=errorLogRoutines
    merge ^[ns]upgradeLog("routines","count")=count
    // Starting all productions
    do ..startAllProductions(verbose)
    zn ns
    return $$$OK
}

ClassMethod startAllProductions(verbose As %Boolean = 0) As %Status
{
    set sc=$$$OK
    set ns=$Namespace
    set sc=##class(%SYS.Namespace).ListAll(.namespacesList)
    set namespace=$ORDER(namespacesList(""))
    while (namespace'="") {
    if (##class(%EnsembleMgr).IsEnsembleNamespace(namespace))&&(namespace'["^^") {
    write:verbose namespace
    zn namespace
    kill prodname,status
    set sc=##class(Ens.Director).GetProductionStatus(.prodname,.status)
    if status=2 {
    write:verbose " starting production "_prodname,!
    set sc=##class(Ens.Director).StartProduction()
    }
    write:verbose !
    zn ns
    }
    set namespace=$ORDER(namespacesList(namespace))
    }
    return sc
}

ClassMethod stopAllProductions(verbose As %Boolean = 0) As %Status
{
    set sc=$$$OK
    set ns=$Namespace
    set sc=##class(%SYS.Namespace).ListAll(.namespacesList)
    set namespace=$ORDER(namespacesList(""))
    while (namespace'="") {
    if (##class(%EnsembleMgr).IsEnsembleNamespace(namespace))&&(namespace'["^^") {
    write:verbose namespace
    zn namespace
    kill prodname,status
    set sc=##class(Ens.Director).GetProductionStatus(.prodname,.status)
    if status=1 {
    write:verbose " stopping production "_prodname,!
    set sc=##class(Ens.Director).StopProduction(0,1)
    }
    write:verbose !
    zn ns
    }
    set namespace=$ORDER(namespacesList(namespace))
    }
    return sc
}

ClassMethod restartAllProductions(verbose As %Boolean = 0) As %Status
{
    set sc=$$$OK
    set ns=$Namespace
    set sc=##class(%SYS.Namespace).ListAll(.namespacesList)
    set namespace=$ORDER(namespacesList(""))
    while (namespace'="") {
    if (##class(%EnsembleMgr).IsEnsembleNamespace(namespace))&&(namespace'["^^") {
        write:verbose namespace
        zn namespace
        kill prodname,status
        set sc=##class(Ens.Director).GetProductionStatus(.prodname,.status)
        if status=1 {
        write:verbose " restarting production "_prodname,!
        set sc=##class(Ens.Director).RestartProduction(0,1)
    }
    write:verbose !
    zn ns
    }
    set namespace=$ORDER(namespacesList(namespace))
    }
    return sc
}

ClassMethod cleanAllProductions(verbose As %Boolean = 0) As %Status
{
    set sc=$$$OK
    set ns=$Namespace
    set sc=##class(%SYS.Namespace).ListAll(.namespacesList)
    set namespace=$ORDER(namespacesList(""))
    while (namespace'="") {
    if (##class(%EnsembleMgr).IsEnsembleNamespace(namespace))&&(namespace'["^^") {
    write:verbose namespace
    zn namespace
    kill prodname,status
    set sc=##class(Ens.Director).GetProductionStatus(.prodname,.status)
    if status=3 {
    write:verbose " cleaning production "_prodname,!
    set sc=##class(Ens.Director).CleanProduction(1)
    }
    write:verbose !
    zn ns
    }
    set namespace=$ORDER(namespacesList(namespace))
    }
    return sc
}

}
