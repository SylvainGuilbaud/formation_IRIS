Include %occErrors

Class FCE.Operations.REST Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/branches" Method="POST" Call="CreateBranch" />
<Route Url="/branches/:ID" Method="GET" Call="RetrieveBranch" />
<Route Url="/branches/:ID" Method="DELETE" Call="DeleteBranch" />
<Route Url="/branches/openinglist/:count" Method="GET" Call="ListBranchesByOpeningTime" />
</Routes>
}

Parameter HTTP422UNPROCESSABLEENTITY = "422 Unprocessable Entity";

ClassMethod RetrieveBranch(branchID As %String) As %Status
{
	#dim %response as %CSP.Response
	set %response.ContentType = "application/json"
	#dim branch as FCE.Branch
	set branch = ##class(FCE.Branch).%OpenId(branchID, , .st)
	if $$$ISOK(st) {
		set jsonBranch = {}
		set st = branch.CopyToObject(.jsonBranch)
		if $$$ISOK(st) {
			// send the JSON string response out
			write jsonBranch.%ToJSON()
		} 
	}
	return st
}

ClassMethod CreateBranch() As %Status
{
	#dim %response as %CSP.Response
	set %response.ContentType = "application/json"
	#dim %request as %CSP.Request
	set data = ##class(%DynamicObject).%FromJSON(%request.Content)
	#dim branch as FCE.Branch
	set branch = ##class(FCE.Branch).%New()
	set st = branch.CopyFromObject(data)
	if $$$ISOK(st) {
		set st = branch.%Save()
		if $$$ISOK(st) {
			set jsonBranch = {}
			set st = branch.CopyToObject(.jsonBranch)
			if $$$ISOK(st) {
				// send the JSON string response out
				write jsonBranch.%ToJSON()
			} 
		}
	}
	return st
}

ClassMethod DeleteBranch(branchID As %String) As %Status
{
	#dim %response as %CSP.Response
	set st = ##class(FCE.Branch).%DeleteId(branchID)
	set %response.Status = ..#HTTP204NOCONTENT
	return st
}

ClassMethod ListBranchesByOpeningTime(count As %Integer) As %Status
{
	#dim rs as %SQL.StatementResult
	#dim results as %DynamicArray
	#dim %response as %CSP.Response
	set %response.ContentType = "application/json"
	// limit request to top 100
	if (count > 100) {
		set st = $$$ERROR($$$GeneralError, "Limit = 100")
		set %response.Status = ..#HTTP204NOCONTENT
		return st
	}
	// use dynamic sql, using JSON_OBJECT to format result as JSON string
	set sql = "SELECT TOP ?"
	set sql = sql _ " JSON_OBJECT('Opens':%odbcout(opens),'Closes':%odbcout(closes),'Phone':phone)"
	set sql = sql _ " as branch"
	set sql = sql _ " FROM FCE.Branch"
	set sql = sql _ " WHERE opens is not null"
	set sql = sql _ " ORDER BY opens"
	set rs = ##class(%SQL.Statement).%ExecDirect(, sql, count)
	if (rs.%SQLCODE = 0) {
		// use %DynamicArray to hold results
		set results = []
		while rs.%Next() {
			// change JSON string into %DynamicObject and push into results
			do results.%Push(##class(%DynamicObject).%FromJSON(rs.branch))
		}
		if (rs.%SQLCODE = 100) {
			// create %DynamicObject to hold final count and results
			set finalResult = {}
			set finalResult.count = rs.%ROWCOUNT
			set finalResult.results = results
			write finalResult.%ToJSON()  // send the JSON string response out
		}
		else {
			// failure during %Next()
			set %response.Status = ..#HTTP204NOCONTENT
			set st = $$$ERROR($$$GeneralError, rs.%SQLCODE _ ": " _ rs.%Message)
		}
	}
	else {
		set %response.Status = ..#HTTP204NOCONTENT
	}
	return $$$OK
}

/// Issue a '500' error and give some indication as to what occurred
/// (Overridden to interpret some particular %Status values as different HTTP status codes.)
ClassMethod Http500(ex As %Exception.AbstractException) As %Status
{
	set st = ex.AsStatus()
	set code = +$System.Status.GetErrorCodes(st)
    return ..ReportHttpStatusCode($case(code,
    			$$$LoadObjectNotFound       :..#HTTP404NOTFOUND,
    			$$$DeleteObjectNotFound     :..#HTTP404NOTFOUND,
    			$$$KeyNotUnique             :..#HTTP422UNPROCESSABLEENTITY,
    			$$$PropertyRequired	        :..#HTTP422UNPROCESSABLEENTITY,
    			$$$DatatypeValidationFailed :..#HTTP422UNPROCESSABLEENTITY,
    			$$$AccessDenied             :..#HTTP403FORBIDDEN,
    			                            :..#HTTP500INTERNALSERVERERROR), st)
}

}
