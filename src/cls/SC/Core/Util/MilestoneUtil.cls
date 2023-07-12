/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Util.MilestoneUtil
{

/// construct JSON for all issues related to an object. Return "" if no issue associated with the object
ClassMethod constructJsonForObjectMilestone(objName As %String, uid As %String) As %DynamicArray
{
    Set ret = ""
    set milestones = ..getMilestonesForObject(objName, uid)
    if (milestones '= "") && (milestones.Count() > 0 ) {
        set ret = []
        set count = milestones.Count()
        w !,"milestone count = ",count
        for i=1:1:count {
            set ms = milestones.GetAt(i)
            set json = ..convertMilestoneToJson(ms)
            do ret.%Push(json)
        }
    }
    else {
        w !,"No milestone found for object ", objName, " with uid ", uid
    }
    Return ret
}

/// Returns issues associated with an object instance
ClassMethod getMilestonesForObject(objName As %String, uid As %String) As %ListOfObjects
{
    Set ret = ""
    if (objName '= "") && (uid'="") {
        set ret = ##class(%ListOfObjects).%New()
        set milestoneObj = "Milestone"
        set tableName = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName(milestoneObj)
        set sql="select uid from "_tableName_" where associatedObjectType = ? and associatedObjectId = ?  ORDER BY  milestoneNumber "
        w !, "sql: ", sql
        set rs = ##class(%SQL.Statement).%ExecDirect(,sql, objName, uid)
        if rs.%SQLCODE < 0 {
            $$$ThrowStatus($$$ERROR($$$SQLCode,SQLCODE,$g(%msg)))
        }
        if ( rs.%SQLCODE = 0 ) {
            while ( rs.%Next() '= 0 ) {
                set uid = rs.%Get("uid")
                set obj =  ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(milestoneObj, uid)
                w !,"adding milestone with uid ", obj.uid
                do ret.Insert(obj)
            }
        }
        w !, "ret count: ", ret.Count()
    }
    Return ret
}

/// render an issue object to JSON, without analysis data
ClassMethod convertMilestoneToJson(ms As SC.Core.Data.Milestone) As %DynamicObject
{
    Set ret = ""
    if ms '= "" {
        do ms.%JSONExportToString(.jsonString)
        set ret = ##class(%DynamicAbstractObject).%FromJSON(.jsonString)
    }
    Return ret
}

}
