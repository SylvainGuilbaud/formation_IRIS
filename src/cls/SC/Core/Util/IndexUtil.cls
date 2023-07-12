/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Util.IndexUtil
{

/// Rebuild all data indecies
ClassMethod rebuildAllDataIndices() As %Status
{
    Set sc = $$$OK
    set sc = ..rebuildObjectIndex("Location")
    set sc = ..rebuildObjectIndex("Supplier")
    set sc = ..rebuildObjectIndex("Customer")
    set sc = ##class(SC.Core.Data.Internal.ActionScenario).%BuildIndices()
    set sc = ##class(SC.Core.Data.Internal.IssueAnalysis).%BuildIndices()
    set sc = ##class(SC.Core.Data.Internal.Issue).%BuildIndices()
    Return sc
}

ClassMethod rebuildObjectIndex(objectName As %String) As %Status
{
    Set sc = $$$OK
    set className = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectName)
    set sc = $CLASSMETHOD(className,"%BuildIndices")
    if $$$ISOK(sc) {
        // Continue
        write !,"Successfully rebuilt indices for object ",objectName,". "
    }
    else {
        write !,"Failed to rebuild indices for object ",objectName,". "
    }
    return sc
}

}
