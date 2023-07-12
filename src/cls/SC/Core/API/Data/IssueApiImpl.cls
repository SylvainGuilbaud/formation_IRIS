/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.IssueApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "Issue";

/// Default sorting attribute
Parameter DEFAULTSORTING = "-recordCreatedTime";

ClassMethod GetIssues() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetIssueById(issueId As %String) As %DynamicObject
{
    // return ..ObjectGetByUid(..#OBJECTNAME, issueId)
    try { 
        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(..#OBJECTNAME)
        set exists = $CLASSMETHOD(classname,"uidIndexExists", issueId)
        if exists = 0 {
		    do ..%SetStatusCode("404")
		    return {"Status": "Failed", 
                    "Message": ("No "_..#OBJECTNAME_" with uid ["_issueId_"] was found.")}            
        }
        set issue = $CLASSMETHOD(classname,"uidIndexOpen", issueId)
        do issue.%JSONExportToString(.jsonString)
        set rawIssue = ##class(%DynamicAbstractObject).%FromJSON(.jsonString)
        set retObj = {"ID": (issue.%Id())}
        set i = rawIssue.%GetIterator()
        while i.%GetNext(.key, .value) {
            do retObj.%Set(key, value)
        }
        set ana = issue.getLatestAnalysis()
        if ana '= "" {
            do ana.%JSONExportToString(.anaString)
            set anaObj =  ##class(%DynamicAbstractObject).%FromJSON(.anaString)
            do retObj.%Set("latestAnalysis", anaObj)
        }
        return retObj
	} catch (ex) {
		do ..%SetStatusCode("500")
		return {"Status": "Error", 
                "Message": ("Failed to retrieve issue with uid ["_issueId_"]. ")}
	}
}

ClassMethod CreateIssue(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteIssue(issueId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, issueId)
}

ClassMethod UpdateIssue(issueId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, issueId, body)
}

}
