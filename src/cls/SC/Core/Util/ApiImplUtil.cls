/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Util.ApiImplUtil
{

/// Returns the API impl class name for a given SC data object
ClassMethod getApiImplClass(objName As %String) As %String
{
    set implName = ""
    if objName '= "" {
        set implName = "SC.Core.API.Data."_objName_"ApiImpl"
    }
    return implName
}

}
