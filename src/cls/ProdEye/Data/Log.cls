Class ProdEye.Data.Log Extends (%RegisteredObject, %JSON.Adaptor)
{

Property Type As %String(MAXLEN = "");

Property SessionId As %Integer;

Property ErrorText As %String(MAXLEN = "");

Property LogTime As %String;

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
		set curObj.Type=$lg(curItm,1)
		set curObj.SessionId=$lg(curItm,2)
		set curObj.ErrorText=$lg(curItm,3)
		set curObj.LogTime=$lg(curItm,4)
		
		do retVal.Insert(curObj)
		
		}
	
	return retVal
}

}
