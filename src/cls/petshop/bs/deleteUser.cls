Class petshop.bs.deleteUser Extends Ens.BusinessService [ ProcedureBlock ]
{

/// Auto generated : Change by your Adapter type.
Parameter ADAPTER = "Ens.Adapter";

/// Auto generated : Change by your Adapter type.
Property Adapter As Ens.Adapter;

/// Auto generated method
Method OnProcessInput(pInput As %RegisteredObject, pOutput As %RegisteredObject) As %Status
{
	Set sc = $$$OK
	Set msg = ##class(petshop.requests.deleteUser).%New()
	; Auto generated, put your own code...
	Return ..SendRequestAsync("petshop.bp.Process", msg)
}

}
