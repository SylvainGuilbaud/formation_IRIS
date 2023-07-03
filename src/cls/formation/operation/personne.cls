/// Author:sylvain.guilbaud@intersystems.com
Class formation.operation.personne Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

/// Insert into NewCustomer table
Method maj(pRequest As formation.msg.mysql.personne, Output pResponse As formation.msg.mysql.response.personne) As %Status
{
	set sc = $$$OK
	Try {

		set pResponse = ##class(formation.msg.mysql.response.personne).%New()

		set query = "SELECT 1 FROM formation.personne " _
					"WHERE id = ? "
		$$$TRACE(query)
				
		$$$ThrowOnError(..Adapter.ExecuteQuery(.select,query,pRequest.id))
		
		do select.Next() 
		set exist = select.GetData(1)

		if exist {
			set update = ""
			set update = update _ "update formation.personne "
			set update = update _ "set"
			set update = update _ " LastName = ?"
			set update = update _ ", FirstName = ?"
			set update = update _ ", DOB = ?"
			set update = update _ ", Sex = ?"
			set update = update _ ", LastAction = ?"
			set update = update _ " where id = ?"
			set sc = ..Adapter.ExecuteUpdate(.nrows
											,update
											, pRequest.LastName
											, pRequest.FirstName
											, $zd(pRequest.DOB,3)
											, pRequest.Sex
											, "UPDATED on " _ $zdt($h,3)
											, pRequest.id
											)
			set pResponse.status = sc
			if sc {
				set pResponse.updated = pResponse.updated + 1
				$$$LOGINFO(nrows _ " row successfully updated")
			} else {
				#; set error=##class(common.msg.errors).%New()
				#; set error.status=sc
				#; do  pResponse.errors.SetAt(error,pResponse.errors.Count()+1)
				$$$LOGERROR("ERROR WHILE UPDATING : "_ pResponse.status.text)
			}

		} else {

			set insert = ""
			set insert = insert _ "insert into formation.personne "
			set insert = insert _ "("
			set insert = insert _ "  id"
			set insert = insert _ ", LastName"
			set insert = insert _ ", FirstName"
			set insert = insert _ ", DOB"
			set insert = insert _ ", Sex"
			set insert = insert _ ", FirstAction"
			set insert = insert _ ")"
			set insert = insert _ " values "
			set insert = insert _ "("
			set insert = insert _ "?,?,?,?,?,?"
			set insert = insert _ ")"
			set sc = ..Adapter.ExecuteUpdate(.nrows
											,insert
											, pRequest.id
											, pRequest.LastName
											, pRequest.FirstName
											, $zd(pRequest.DOB,3)
											, pRequest.Sex
											, "INSERTED on " _ $zdt($h,3)
											)
			set pResponse.status = sc
			if sc {
				set pResponse.inserted = pResponse.inserted + 1
				$$$LOGINFO(nrows _ " row successfully inserted")
			} else {
				#; set error=##class(common.msg.errors).%New()
				#; set error.status=sc
				#; do  pResponse.errors.SetAt(error,pResponse.errors.Count()+1)
				$$$LOGERROR("ERROR WHILE INSERTING : "_ pResponse.status.text)
			}
		}
	
	}
	Catch ex {
		Set sc=ex.AsStatus()
	}
    
	return sc
}

Method batch(pRequest As formation.msg.mysql.batch, Output pResponse As formation.msg.mysql.response.personne) As %Status
{
	set sc = $$$OK
	Try {

		set pResponse = ##class(formation.msg.mysql.response.personne).%New()

		for i = 1 : 1 : pRequest.list.Count() {
			set msg = pRequest.list.GetAt(i)
			do ..maj(msg)
		}
		
	}
	Catch ex {
		Set sc=ex.AsStatus()
	}
    
	return sc
}

Method test(pRequest As Ens.StringContainer, Output pResponse As Ens.StringContainer) As %Status
{
	set sc = $$$OK
	Try {

		set pResponse = ##class(Ens.StringContainer).%New()
		if pRequest.StringValue '= "" {
			set query = "SELECT concat(count(*), ' rows') FROM " _ pRequest.StringValue
			$$$ThrowOnError(..Adapter.ExecuteQuery(.select,query))
		} else {
			set query = "SELECT  concat(sysdate(),' (version ',version(),')') "
			$$$ThrowOnError(..Adapter.ExecuteQuery(.select,query))
		}
		
		$$$TRACE(query)
				
		$$$ThrowOnError(..Adapter.ExecuteQuery(.select,query))
		
		do select.Next() 
		set result = select.GetData(1)
		set pResponse.StringValue =  result _ $char(13,10)
		set pResponse.StringValue = pResponse.StringValue _" (query:" _ query _ ")"
	
	}
	Catch ex {
		Set sc=ex.AsStatus()
	}
    
	return sc
}

XData MessageMap
{
<MapItems>
   <MapItem MessageType="Ens.StringContainer">
    <Method>test</Method>
  </MapItem>
  <MapItem MessageType="formation.msg.mysql.personne">
    <Method>maj</Method>
  </MapItem>
  <MapItem MessageType="formation.msg.mysql.batch">
    <Method>batch</Method>
  </MapItem>
</MapItems>
}

}
