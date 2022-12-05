Class JDBC.demo.SELECT.operation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "JDBC.SQL.OutboundAdapter";

Property Adapter As JDBC.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Property batchSize As %Integer [ InitialExpression = 500 ];

Property SCHEMA As %String [ InitialExpression = "app" ];

Parameter SETTINGS = "batchSize:JDBC,SCHEMA:app";

Method OnInit() As %Status
{
	do ##super()
	set $ZSTORAGE=2147483647
	return $$$OK
}

Method SELECT(pRequest As Ens.StringRequest, Output pResponse As Ens.StringResponse) As %Status
{
	
	set sc = $$$OK
	
	try{
		set pResponse = ##class(Ens.StringResponse).%New()
		set query = ""
		set query = query_"SELECT "
		set query = query_" id"
		set query = query_",last_name"
		set query = query_",first_name"
		set query = query_",city"
		set query = query_",active"
    	set query = query_",category"
		set query = query_",created" 
		set query = query_",gender"
		set query = query_",hashtag" 
		set query = query_" FROM "_ ..SCHEMA _".customer"
		set query = query_" ORDER BY ID"
		
		Set start = $zh

		$$$TRACE(query)
			
		$$$ThrowOnError(..Adapter.ExecuteQueryBatch(.rs,query,..batchSize))
		
		while rs.%Next(){

			set id = rs.%Get("id")
			$$$TRACE(id)
			set customer = ##class(data.customer).getRecord(id)
			set customer.lastName = rs.%Get("last_name")
			set customer.firstName = rs.%Get("first_name")
			set customer.city = rs.%Get("city")
			set customer.category = rs.%Get("category")
			set customer.active = $SELECT(rs.%Get("active")="t":1,1:0)
			set customer.gender = rs.%Get("gender")
			set customer.hashtag = rs.%Get("hashtag")
			$$$ThrowOnError(customer.%Save())

			do $INCREMENT(records)
		}
		
		set elapse = $zh-start

		set pResponse.StringValue = records_" ("_elapse_" seconds)"
	}
	catch exp
	{
		set sc = exp.AsStatus()
	}
	return sc
}

Method test(pRequest As JDBC.demo.msg.test, Output pResponse As Ens.StringResponse) As %Status
{
	
	set sc = $$$OK
	
	try{
		set pResponse = ##class(Ens.StringResponse).%New()
		set query = "",hasNext=""
		set query = query_"SELECT count(*) as nb FROM "_ ..SCHEMA_"."_pRequest.tablename

		$$$TRACE(query)

		$$$ThrowOnError(..Adapter.ExecuteQuery(.rs,query))

		if rs.%Next() {
			set nb = rs.%Get("nb")
			$$$LOGINFO("nb:" _ nb)
		} else {
			$$$LOGINFO("NO DATA FOUND")
		}
		
		set pResponse.StringValue = nb
	}
	catch exp
	{
		set sc = exp.AsStatus()
	}
	return sc
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Ens.StringRequest"> 
		<Method>SELECT</Method>
	</MapItem>
	<MapItem MessageType="JDBC.demo.msg.test"> 
		<Method>test</Method>
	</MapItem>
</MapItems>
}

}
