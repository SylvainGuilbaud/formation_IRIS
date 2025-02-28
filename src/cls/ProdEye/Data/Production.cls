Class ProdEye.Data.Production Extends (%RegisteredObject, %JSON.Adaptor)
{

Property Name As %String(MAXLEN = "");

Property Status As %String(MAXLEN = "");

Property StatusAsOf As %String(MAXLEN = "");

Property Components As %Library.ListOfObjects;

Method %OnNew(pName As %String, pStatus As %String, pStatusAsOf As %String) As %Status
{
	set ..Name=$g(pName)
	set ..Status=$g(pStatus)
	set ..StatusAsOf=$g(pStatusAsOf)
	
	return $$$OK
}

Method Dynamize() As %DynamicObject
{
	set retVal={}
	
	set retVal.Name=..Name
	set retVal.Status=..Status
	set retVal.StatusasOf=..StatusAsOf
	
	
	return retVal
}

}
