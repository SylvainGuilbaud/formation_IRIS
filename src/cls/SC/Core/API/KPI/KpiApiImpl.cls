/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// API impl class for KPIs
Class SC.Core.API.KPI.KpiApiImpl Extends SC.Core.API.ApiBaseImpl
{

/// API parameter for the expension dimension
Parameter EXPENSIONDIMENSION = "expandDimension";

/// API parameter name for KPI filter
Parameter KPIFILTER = "kpiFilter";

/// KPI definition table name
Parameter KPIDEFINITIONTABLE = "SC_Core_Analytics_KPI.KpiDefinition";

Parameter KPIDEFINISIONCLASS = "SC.Core.Analytics.KPI.KpiDefinition";

/// Get all KPI definitions
ClassMethod GetKpiDefinitions() As %DynamicAbstractObject
{
    Set sql = "select ID from "_..#KPIDEFINITIONTABLE
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
    if rs.%SQLCODE < 0 {
        do ..%SetStatusCode("500")
        return {
            "status": "Error",
            "errorCode": ("SQL["_rs.%SQLCODE_"]"),
            "errorMessage": (rs.%Message)
            } 
    }
    Set count = 0
    set defs = []
    while rs.%Next() {
        set count = count+1
        set id = rs.%Get("ID")
        set kpi = $CLASSMETHOD(..#KPIDEFINISIONCLASS,"%OpenId", id)
        //set kpi = ##Class(SC.Core.Analytics.KPI.KpiDefinition).%OpenId(id)
        do kpi.%JSONExportToString(.jsonString)
        set dkpi = ##class(%DynamicAbstractObject).%FromJSON(jsonString)
        do defs.%Push(dkpi)
    }
    if count = 0 {
        return { "status": "Success", "info": "No KPI definition found" }
    }
    else {
        return defs.%ToJSON()
    }
}

/// Create a new KPI
ClassMethod CreateKpiDefinition(body As %DynamicObject) As %DynamicAbstractObject
{
    try {
        set obj = $CLASSMETHOD(..#KPIDEFINISIONCLASS,"%New")
        //set obj = ##class(SC.Core.Analytics.KPI.KpiDefinition).%New()
        set sc = obj.%JSONImport(body)
        if $$$ISERR(sc) {
            do $system.Status.DisplayError(sc)
            return {"Status": "error", "Message": "Invalid JSON input"}
        }
        set sc = obj.%Save()
        if $$$ISERR(sc) {
            do $system.Status.DisplayError(sc)
            return {"Status": "error", "Message": "Invalid KPI definition found"}
        }
        do obj.%JSONExportToString(.resp)
        return resp
    } catch (ex) {
        do ..%SetStatusCode("500")
        return {"errormessage": "Server error"}		
	}
}

/// Get a KPI definition by its name
ClassMethod GetKpiDefinition(kpiName As %String) As %DynamicObject
{
    try{
        set id = ..GetKpiIdByName(kpiName)
        if id <=0 {
            do ..%SetStatusCode("404")
            return {"errormessage": "No Kpi with given name"}
        }

        set kpi = $CLASSMETHOD(..#KPIDEFINISIONCLASS,"%OpenId", id)
        //set kpi =  ##class(SC.Core.Analytics.KPI.KpiDefinition).%OpenId(id)   
        do kpi.%JSONExportToString(.resp)
        //set resp = ##class(%DynamicAbstractObject).%FromJSON(jsonString)
        return resp
    } catch (ex) {
        do ..%SetStatusCode("500")
        return {"errormessage": "Server error"}		
	}
}

/// Delete a KPI definition
ClassMethod DeleteKpiDefinition(kpiName As %String) As %DynamicObject
{
    try{
        set id = ..GetKpiIdByName(kpiName)
        if id <=0 {
            do ..%SetStatusCode("404")
            return {"errormessage": "No Kpi with given name"}
        }
        set kpi = $CLASSMETHOD(..#KPIDEFINISIONCLASS,"%DeleteId", id)
        //set kpi =  ##class(SC.Core.Analytics.KPI.KpiDefinition).%DeleteId(id)    
		do ..%SetStatusCode("200")
		return {"Status": "Success", "id": (id), "name": (kpiName)}

    } catch (ex) {
        do ..%SetStatusCode("500")
        return {"errormessage": "Server error"}		
	}
}

/// Update a KPI definition
ClassMethod UpdateKpiDefinition(kpiName As %String, body As %DynamicObject) As %DynamicObject
{
    try{
        set id = ..GetKpiIdByName(kpiName)
        if id <=0 {
                do ..%SetStatusCode("404")
                return {"errormessage": "No Kpi with given name"}
        }

        set kpi = $CLASSMETHOD(..#KPIDEFINISIONCLASS,"%OpenId", id)
        //set kpi =  ##class(SC.Core.Analytics.KPI.KpiDefinition).%OpenId(id)   
		set sc = kpi.%JSONImport(body)
        if $$$ISERR(sc) {
            do $system.Status.DisplayError(sc)
            return {"Status": "error", "Message": "Invalid JSON input"}
        }
        set sc = kpi.%Save()
        if $$$ISERR(sc) {
            do $system.Status.DisplayError(sc)
            return {"Status": "error", "Message": "Invalid KPI definition found"}
        }
        do kpi.%JSONExportToString(.resp)
        return resp
    } catch (ex) {
        do ..%SetStatusCode("500")
        return {"errormessage": "Server error"}		
	}
}

/// Get the KPI value for a specified KPI
ClassMethod GetKpiValue(kpiName As %String) As %DynamicAbstractObject
{
    set resp = ""
    set kpiDef = ..GetKpiDefinitionByName(kpiName)
    if kpiDef '= "" {
        set dimList=""
        set valueList=""
        set numDimFilter = ..GetDimensionFilter(kpiDef, .dimList, .valueList)
        set baseValueArray = ""
        if kpiDef.deepseeKpiSpec.isPercentageType() = 1 {
            // Handle percentage KPI here
            set baseMdx = ..constructKpiValueBaseMdx(kpiDef, numDimFilter, dimList, valueList)
            set baseRset = ..ExecuteMdxQuery(baseMdx)
            set count = ..ExtractKpiValueToArray(baseRset, .baseValueArray)
            //quit {"baseMdx": (baseMdx)}
        }
        set mdx = ..ConstructKpiValueMdx(kpiDef, numDimFilter, dimList, valueList)
        //quit {"status": (mdx)}
        set rset = ..ExecuteMdxQuery(mdx)
        set values = ..ConstructKpiValueResponse(rset, baseValueArray)

        set resp = { "kpiName": (kpiName) }
        set expDim = ..GetExpansionDimensionName(kpiDef)
        if expDim '= "" {
            do resp.%Set(..#EXPENSIONDIMENSION, expDim)
        }
        if numDimFilter > 0 {
            set filters = []
            for i=1:1:numDimFilter {
                do filters.%Push({"dimension":(dimList.GetAt(i)), 
                                  "value":(valueList.GetAt(i))})
            }
            do resp.%Set(..#KPIFILTER, filters)
        }
        set resp.values = values
    }
    else {
        do ..%SetStatusCode("400")
        set resp = { "Status": "Error", "Message": ("KPI not defined ("_kpiName_").") }
    }
    return resp
}

/// Get the source listing of a KPI request
ClassMethod GetKpiListing(kpiName As %String) As %DynamicAbstractObject
{
    set kpiDef = ..GetKpiDefinitionByName(kpiName)
    if kpiDef '= "" {
        set dimList=""
        set valueList=""
        set numDimFilter = ..GetDimensionFilter(kpiDef, .dimList, .valueList)
        set mdx = ..ConstructDrillThroughMdx(kpiDef, numDimFilter, dimList, valueList)
        
        set rset = ..ExecuteMdxQuery(mdx)
        set idSelect = ..ExtractDrillThroughSelect(rset)
        //set resp = {"select": (idSelect)}
        set cName = ##class(SC.Core.Util.ApiImplUtil).getApiImplClass(kpiDef.baseObject)
        //return {"ApiClass": (cName)}
        set resp = $CLASSMETHOD(cName,"GetRecordsWithIdSelect", idSelect)
        //set resp = ##Class(SC.Core.API.Data.SalesOrderApiImpl).GetSalesOrdersWithIdSelect(idSelect)
    }
    else {
        set resp = { "status": "Error", "info": ("KPI not defined ("_kpiName_").") }
    }
    return resp
}

/// Execute a MDX query. 
ClassMethod ExecuteMdxQuery(mdx As %String) As %DeepSee.ResultSet
{
    Set rset=##class(%DeepSee.ResultSet).%New()
    Set status=rset.%PrepareMDX(mdx)
    If $$$ISERR(status) {Do $System.Status.DisplayError(status) Quit status}

    Set status=rset.%Execute()
    If $$$ISERR(status) {Do $System.Status.DisplayError(status) Quit status}
    Return rset
}

/// Extract drill through select statement from a drill through result set
ClassMethod ExtractDrillThroughSelect(rset As %DeepSee.ResultSet) As %String
{
    Set ret = ""
    if (rset '= "") && (rset.%IsDrillThrough()) {
        set listingsql = rset.%GetListingSQL()
        set targetString = "SELECT _DSsourceId"
        set startIndex = $FIND(listingsql, targetString)-$LENGTH(targetString)
        set selectString = $EXTRACT(listingsql,startIndex, *)
        set endIndex = $FIND(selectString, ")")-2
        set ret =  $EXTRACT(selectString,1,endIndex)
    } 
    Return ret
}

/// Extract MDX query response for KPI value, and return the value response object
ClassMethod ConstructKpiValueResponse(rset As %DeepSee.ResultSet, baseValueArray As %ArrayOfDataTypes) As %DynamicAbstractObject
{
    Set sc = $$$OK
    set rowCount=rset.%GetRowCount()
    set resp = [], label="kpi"
    For j=1:1:rowCount {
        Set labelcount=rset.%GetOrdinalLabel(.pLabel,2,j)
        For i=1:1:labelcount {
            set label = pLabel(i)
        }
        //TODO: change the label from Display value (such as "Aug-2021") to internal value (such as "202108")
        set value = rset.%GetOrdinalValue(1, j)
        if value = "" { set value = 0}
        set obj = ##class(%DynamicObject).%New()
        if baseValueArray = "" {
            // For raw data KPIs
            set obj.label = label
            set obj.value = value
        }
        else {
            set baseValue = baseValueArray.GetAt(label)
            set pecentage = $System.SQL.Functions.CEILING(value/baseValue*100)
            set obj.label = label
            set obj.value = pecentage  
            set obj.details = {"rawValue": (value), "baseValue": (baseValue)}         
        }
        do resp.%Push(obj)
    }
    Return resp
}

/// Extract MDX query response for KPI value, and save the values in an array. The method returns 
/// the total number of values saved. 
ClassMethod ExtractKpiValueToArray(rset As %DeepSee.ResultSet, Output valueArray As %ArrayOfDataTypes) As %Integer
{
    Set count = 0
    set valueArray = ##class(%ArrayOfDataTypes).%New()
    set rowCount=rset.%GetRowCount()
    set label="kpi"
    For j=1:1:rowCount {
        Set labelcount=rset.%GetOrdinalLabel(.pLabel,2,j)
        For i=1:1:labelcount {
            set label = pLabel(i)
        }
        //TODO: change the label from Display value (such as "Aug-2021") to internal value (such as "202108")
        set value = rset.%GetOrdinalValue(1, j)
        do valueArray.SetAt(value, label)
        set count = count + 1
    }
    Return count
}

/// Retrieve KPI definition by name
ClassMethod GetKpiDefinitionByName(kpiName As %String) As SC.Core.Analytics.KPI.KpiDefinition
{
    Set def = ""
    Set sql = "select ID from "_..#KPIDEFINITIONTABLE_" where name='"_kpiName_"'"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
    if rs.%SQLCODE < 0 {
        do ..%SetStatusCode("500")
        return {
            "status": "Error",
            "errorCode": ("SQL["_rs.%SQLCODE_"]"),
            "errorMessage": (rs.%Message)
            } 
    }
    if rs.%Next() {
        set kpiId = rs.%Get("ID")
        set def = $CLASSMETHOD(..#KPIDEFINISIONCLASS,"%OpenId", kpiId)
        //set def = ##Class(SC.Core.Analytics.KPI.KpiDefinition).%OpenId(kpiId)
    }
    Return def
}

/// Construct drill through MD query string
ClassMethod ConstructDrillThroughMdx(kpiDef As SC.Core.Analytics.KPI.KpiDefinition, numDimFilter As %Integer, dimList As %ListOfDataTypes, valueList As %ListOfDataTypes) As %String
{
    return ..ConstructMdxForKpi(kpiDef, 1, 0, numDimFilter, dimList, valueList)
}

/// Construct MDX query for a KPI value request
ClassMethod ConstructKpiValueMdx(kpiDef As SC.Core.Analytics.KPI.KpiDefinition, numDimFilter As %Integer, dimList As %ListOfDataTypes, valueList As %ListOfDataTypes) As %String
{
    return ..ConstructMdxForKpi(kpiDef, 0, 0, numDimFilter, dimList, valueList)
}

ClassMethod constructKpiValueBaseMdx(kpiDef As SC.Core.Analytics.KPI.KpiDefinition, numDimFilter As %Integer, dimList As %ListOfDataTypes, valueList As %ListOfDataTypes) As %String
{
    return ..ConstructMdxForKpi(kpiDef, 0, 1, numDimFilter, dimList, valueList)
}

/// Construct MDX query for a KPI
ClassMethod ConstructMdxForKpi(kpiDef As SC.Core.Analytics.KPI.KpiDefinition, isDrillThrough As %Integer, isPercentageBase As %Integer, numDimFilter As %Integer, dimList As %ListOfDataTypes, valueList As %ListOfDataTypes) As %String
{
  
    Set mdx="SELECT "
    if isDrillThrough {
        Set mdx="DRILLTHROUGH SELECT "
    }
    else {
        // For drill through, no expansion will be done, even if it is specified in REST by mistake.
        set expString = ..getMdxRowColString(kpiDef)

        // Completes the select portion of the query by checking measure and expand dimension info
        set measure = kpiDef.deepseeKpiSpecGet().kpiMeasure
        if measure '= "" {
            set mdx = mdx_" [Measures].["_measure_"] ON 0"
            if $LENGTH(expString) > 2 {
                set mdx = mdx_", "_expString
            }
        }
        else {
            set mdx = mdx_expString
        }
    }

    set mdx = mdx_" FROM ["_kpiDef.deepseeKpiSpec.cube_"] " 
    set ptr=0, count=0
    if isPercentageBase = 0 {
        set list = kpiDef.deepseeKpiSpec.kpiConditions
        for i=1:1:list.Count() {
            set mdx = mdx_" %FILTER "_list.GetAt(i)
        }
    }
    set list = kpiDef.deepseeKpiSpec.baseConditions
    if list '= "" {
        for i=1:1:list.Count() {
            set mdx = mdx_" %FILTER "_list.GetAt(i)
        }
    }
    if numDimFilter > 0 {
        set additionalFilter = ..AddDimensionFilters(kpiDef, numDimFilter, dimList, valueList)
        set mdx = mdx_" "_additionalFilter
    }
    Return mdx
}

/// Get the dimension filter details for a request. First get all the filter values from the 
/// request, then check against the KPI dimension definition, and return those matches
/// the KPI dimensions.
ClassMethod GetDimensionFilter(kpiDef As SC.Core.Analytics.KPI.KpiDefinition, Output dimList As %ListOfDataTypes, Output valueList As %ListOfDataTypes) As %Integer
{
    set spec = kpiDef.deepseeKpiSpecGet()
    set numFilter = ..ExtractKpiFilter(.names, .values)
    set count = 0
    if numFilter>0 {
        set dimList = ##class(%ListOfDataTypes).%New()
        set valueList = ##class(%ListOfDataTypes).%New()
        for i=1:1:names.Size {
            set dimName = names.GetAt(i)
            if spec.HasDimension(dimName) {
                do dimList.Insert(names.GetAt(i))
                do valueList.Insert(values.GetAt(i))
                set count = count+1
            }
        }
    }
    return count
}

/// Extract KPI filter details from the request
ClassMethod ExtractKpiFilter(Output nameList As %ListOfDataTypes, Output valueList As %ListOfDataTypes) As %Integer
{
    set count = 0
    zw %request
    Set kpiFilter = $Get(%request.Data(..#KPIFILTER,1))
    //set kpiFilter = "(productFamily, Apple Watch),(bnn, asdf),(region2, EMEA)"
    if kpiFilter '= "" {
        set nameList = ##class(%ListOfDataTypes).%New()
        set valueList = ##class(%ListOfDataTypes).%New()
        set cleanFilter = $ZSTRIP(kpiFilter, "<>W")
        set size = $LENGTH(cleanFilter, "),(")
        for i=1:1:size {
            set s = $PIECE(cleanFilter,"),(",i)
            set s = $ZSTRIP(s, "*C", "()")
            do nameList.Insert($ZSTRIP($piece(s,",",1), "<>W"))
            do valueList.Insert($ZSTRIP($piece(s,",",2), "<>W"))
            set count = count+1
        }
    }
    return count
}

/// Construct filter string for additional dimensions provided in REST parameters
ClassMethod AddDimensionFilters(kpiDef As SC.Core.Analytics.KPI.KpiDefinition, numDimFilter As %Integer, dimList As %ListOfDataTypes, valueList As %ListOfDataTypes) As %String
{
    set ret = " "
    set spec = kpiDef.deepseeKpiSpecGet()
    for i=1:1:numDimFilter {
        set filter = "%FILTER "_spec.GetMdxDimensionByName(dimList.GetAt(i))_".&["_valueList.GetAt(i)_"]"
        set ret = ret_filter
    }
    return ret
}

/// Contruct the ROW/Col string related to the expansion dimension for a MDX query
ClassMethod getMdxRowColString(kpiDef As SC.Core.Analytics.KPI.KpiDefinition) As %String
{
    Set ret = " "
    Set expDim = $Get(%request.Data(..#EXPENSIONDIMENSION,1))
    if expDim '= "" {
        set list = kpiDef.deepseeKpiSpec.kpiDimensions
        for i=1:1:list.Count() {
            set kpiDim = list.GetAt(i)
            if expDim = kpiDim.name {
                set ret = kpiDim.cubeDimension_".MEMBERS ON 1 "
                QUIT
            }
        }        
    }
    Return ret
}

/// Return the expansion dimension name
ClassMethod GetExpansionDimensionName(kpiDef As SC.Core.Analytics.KPI.KpiDefinition) As %String
{
    set ret = ""
    Set expDim = $Get(%request.Data(..#EXPENSIONDIMENSION,1))
    if expDim '= "" {
        set list = kpiDef.deepseeKpiSpec.kpiDimensions
        for i=1:1:list.Count() {
            set kpiDim = list.GetAt(i)
            if expDim = kpiDim.name {
                set ret = kpiDim.name
                QUIT
            }
        }        
    }
    return ret
}

/// Get the ID of a KPI definition by its name
ClassMethod GetKpiIdByName(kpiName As %String) As %Numeric
{
    set id = -1
    set sql = "SELECT ID FROM "_..#KPIDEFINITIONTABLE_" WHERE name = ?"
    set statement = ##class(%SQL.Statement).%New()
    set status = statement.%Prepare(sql) 
    if $$$ISOK(status) {
        set rs = statement.%Execute(kpiName)
        if (rs.%SQLCode >= 0)  {
            if (rs.%Next()) {
                set id = rs.%Get("ID")
            } else {
                set id = -1
            }
        } else {
            $$$ThrowStatus($$$ERROR($$$SQLCode,SQLCODE,$g(%msg)))
        }
    } else {
        $$$ThrowStatus(status)
    }
    Return id
}

}
