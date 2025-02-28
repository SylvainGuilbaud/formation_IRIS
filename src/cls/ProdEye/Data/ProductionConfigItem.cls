Class ProdEye.Data.ProductionConfigItem Extends (%RegisteredObject, %JSON.Adaptor)
{

Property Name As %String(MAXLEN = "");

Property IsEnabled As %Boolean;

Property Type As %String(MAXLEN = "");

Property JobsStatus As %Library.ListOfObjects;

Property Errors As %Library.ListOfObjects;

Property Warnings As %Library.ListOfObjects;

Property Alerts As %Library.ListOfObjects;

Property QueueSize As %Integer;

Property MessageCount As %Integer;

Property MessageAVGProcessingMilliseconds As %Integer;

Method %OnNew(pName As %String, pIsEnabled As %String) As %Status
{
	set ..Name=$g(pName)
	set ..IsEnabled=$g(pIsEnabled)
	
	return $$$OK
}

}
