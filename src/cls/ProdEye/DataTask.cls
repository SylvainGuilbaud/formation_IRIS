Class ProdEye.DataTask Extends %SYS.Task.Definition
{

Property IntervalMinutes As %Integer [ InitialExpression = 5 ];

Method OnTask() As %Status
{
	try {
		set packageName=$P($classname(),".",1)
		
		set targetDocument={}
		
		set ZeroTimeStamp= $$HorologAddSecs^EnsUtil($ztimestamp,-(..IntervalMinutes*60))
		
		set targetDocument.TimeOfQuery=##class(Ens.DataType.UTC).timeUTC()
		set targetDocument.TimeOfQueryIdx=$classmethod(packageName_".Query","getDateTimeUTCIdx")
		do $classmethod(packageName_".Query","GetNameSpaceList")
		k prodArray
		
		do $classmethod(packageName_".Query","GetProductionsList",.prodArray)
		
		
		set productionObjectList=[]
		
		set currNameSpace=""
		for  {
			set currNameSpace=$O(prodArray(currNameSpace))
			quit:currNameSpace=""
			
			set currProd=""
			for  {
				set currProd=$O(prodArray(currNameSpace,currProd))
				quit:currProd=""
				
				set newProdData=$g(prodArray(currNameSpace,currProd))
				set newProd=$classmethod(packageName_".Data.Production","%New",currProd,$lg(newProdData,1),$lg(newProdData,2))
				
				k compArray
				do $classmethod(packageName_".Query","GetComponentListByProd",.compArray,currProd,currNameSpace)
				
				set components=""
				set currComp=""
				for  {
					set currComp=$O(compArray(currProd,currComp))
					quit:currComp=""
					
					set newComp=$classmethod(packageName_".Data.ProductionConfigItem","%New",currComp,$g(compArray(currProd,currComp)))
					set compId=$classmethod(packageName_".Query","GetComponentId",currComp,currProd,currNameSpace)
					set newComp.Type= $classmethod(packageName_".Query","GetComponentType",compId,currNameSpace)
					set newComp.QueueSize=$classmethod(packageName_".Query","GetComponentQueueData",currComp,currNameSpace)
					
					set MessageStats=$classmethod(packageName_".Query","GetComponentMessageCountAndAvg",currComp,ZeroTimeStamp,currNameSpace)
					set:$lv(MessageStats) newComp.MessageCount=$lg(MessageStats,1)
					set:$lv(MessageStats) newComp.MessageAVGProcessingMilliseconds=$lg(MessageStats,2)
					
					set newComp.JobsStatus=$classmethod(packageName_".Data.JobStatus","BuildPropertyFromList",$classmethod(packageName_".Query","GetComponentJobs",currComp,currNameSpace))
					set newComp.Errors=$classmethod(packageName_".Data.Log","BuildPropertyFromList",$classmethod(packageName_".Query","GetComponentErrors",currComp,ZeroTimeStamp,currNameSpace))
					set newComp.Warnings=$classmethod(packageName_".Data.Log","BuildPropertyFromList",$classmethod(packageName_".Query","GetComponentWarnings",currComp,ZeroTimeStamp,currNameSpace))
					set newComp.Alerts=$classmethod(packageName_".Data.Log","BuildPropertyFromList",$classmethod(packageName_".Query","GetComponentAlerts",currComp,ZeroTimeStamp,currNameSpace))
					
					do newProd.Components.Insert(newComp)
				}
				
				
				set newProdJSONStr=""
				do newProd.%JSONExportToString(.newProdJSONStr)
				set newProdJSON={}.%FromJSON(newProdJSONStr)
				do:newProdJSON'="" productionObjectList.%Push(newProdJSON)
				}
			}
		
		do targetDocument.%Set("ProductionList",productionObjectList)
		if (##class(%DocDB.Database).xNExists(packageName_".DB.ProdEyeDocument")){
			set db=##class(%DocDB.Database).%GetDatabase(packageName_".DB.ProdEyeDocument")
		} else {
			set db= ##class(%DocDB.Database).%CreateDatabase("ProdEye.DB.ProdEyeDocument")
			do db.%CreateProperty("TimeOfQueryIdx","%Integer","$.TimeOFQueryIdx",0)
			}
		set nwRecord=db.%SaveDocument(targetDocument)
		
		if $$$ISERR(nwRecord){$$$ThrowStatus(nwRecord)}
		
		set nwRecord.ProfileName=$get(^ProdEyeProfileName(0))
		set nwRecord.TimeOfQueryIdx=targetDocument.TimeOfQueryIdx
		do nwRecord.%Save()
		
		return $$$OK
	} catch error {
		do BACK^%ETN
		return $$$ERROR("5001",error.AsStatus())
		}
}

}
