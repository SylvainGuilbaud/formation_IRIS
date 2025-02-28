Class ProdEye.Data.JobStatus Extends (%RegisteredObject, %JSON.Adaptor)
{

Property JobId As %Integer;

Property Status As %String(MAXLEN = "");

ClassMethod BuildPropertyFromList(objectList As %List) As %Library.ListOfObjects
{
	set retVal=##class(%Library.ListOfObjects).%New()
	quit:$g(objectList)="" retVal 
	quit:'$lv(objectList) retVal
	
	for ix=1:1:$ll(objectList){
		set curItm=$lg(objectList,ix)
		
		continue:$g(curItm)=""
		continue:'$lv(curItm)
		
		set curObj=$classmethod($classname(),"%New")
		set curObj.JobId=$lg(curItm,1)
		set curObj.Status=$lg(curItm,2)
		
		do retVal.Insert(curObj)
		
		}
	
	return retVal
}

}
