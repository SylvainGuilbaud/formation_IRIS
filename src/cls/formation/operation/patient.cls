/// Author:sylvain.guilbaud@intersystems.com
Class formation.operation.patient Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

/// Insert into NewCustomer table
Method maj(pRequest As formation.msg.mysql.patient, Output pResponse As formation.msg.mysql.response.patient) As %Status
{
	set sc = $$$OK
	Try {
		set pResponse = ##class(formation.msg.mysql.response.patient).%New()
		set insert = ""
		set insert = insert _ "insert into formation.patient "
		set insert = insert _ "("
		set insert = insert _ "  id"
		set insert = insert _ "  LastName"
		set insert = insert _ ", FirstName"
		set insert = insert _ ", DOB"
		set insert = insert _ ", Sex"
		set insert = insert _ ")"
		set insert = insert _ " values "
		set insert = insert _ "("
		set insert = insert _ "?,?,?,?"
		set insert = insert _ ")"
		set sc = ..Adapter.ExecuteUpdate(.nrows
										,insert
										, pRequest.id
										, pRequest.LastName
										, pRequest.FirstName
										, $zd(pRequest.DOB,3)
										, pRequest.Sex
										)
		if sc {
			set pResponse.inserted = pResponse.inserted + 1
			$$$LOGINFO(nrows _ " row successfully inserted")
		} else {
			#; set error=##class(common.msg.errors).%New()
			#; set error.status=sc
			#; do  pResponse.errors.SetAt(error,pResponse.errors.Count()+1)
			set pResponse.status = sc
			$$$LOGERROR("ERROR WHILE INSERTING : "_ pResponse.status.text)
		}
	
	}
	Catch ex {
		Set sc=ex.AsStatus()
	}
    
	return sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="formation.msg.mysql.patient">
    <Method>maj</Method>
  </MapItem>
</MapItems>
}

}
