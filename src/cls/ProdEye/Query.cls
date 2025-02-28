Class ProdEye.Query Extends %RegisteredObject
{

ClassMethod GetNameSpaceList() As %Status [ ProcedureBlock = 0, PublicList = nsArray ]
{
	k nsArray
	set namespaces=##class(%SYS.Namespace).ListAll(.nsArray)
	return $$$OK
}

/// each record in pinfo is as (production name")=$lb("current status","last start time)","last stop time","auto start config")
ClassMethod GetProductionsList(ByRef prodArray) As %Status [ ProcedureBlock = 0, PublicList = nsArray ]
{
	set currentNameSpace=""
	for  {
		set currentNameSpace=$O(nsArray(currentNameSpace))
		quit:currentNameSpace=""
		continue:currentNameSpace="%SYS"
		k pinfo
		set runForCurrentProducttion=##class(Ens.Director).GetProductionSummary(.pinfo,currentNameSpace)
		m prodArray(currentNameSpace)=pinfo
		
		//date stamp back to utc
		set ixData=$g(prodArray(currentNameSpace))
		set ixDataDateString=$lg(ixData,2)
		if ixDataDateString'="" {
			set $li(ixData,2)=##class(Ens.DataType.UTC).timeLocaltoUTC(##class(%TimeStamp).OdbcToLogical(ixDataDateString))
			set prodArray(currentNameSpace,ix)=ixData
			}
		}
	
	
	return $$$OK
}

ClassMethod GetComponentListByProd(ByRef compArray, currentProduction As %String, NameSpace As %String) As %Status
{
	
	quit:(($g(currentProduction)="")||($g(NameSpace)="")) $$$OK
	set NowNameSpace=$namespace
	zn NameSpace
	set currentProductionObj=##class(Ens.Config.Production).%OpenId(currentProduction)
		set configItemQuery=##class(%ResultSet).%New("Ens.Config.Production:EnumerateConfigItemNames")
		if configItemQuery {
			set sc= configItemQuery.Execute(currentProduction)
			if $$$ISOK(sc){
				while configItemQuery.%Next(.scx) {
					if scx{
						
						set compArray(currentProduction,configItemQuery.Get("ConfigName"))=configItemQuery.Get("Enabled")
					}
				}
			}
		}
	zn NowNameSpace
	return $$$OK
}

ClassMethod GetComponentId(componentName As %String, ProductionName As %String, NameSpace As %String) As %String
{
	quit:(($g(componentName)="")||($g(ProductionName)="")||($g(NameSpace)="")) ""
	set NowNameSpace=$namespace
	zn NameSpace
	
	set configItmId=""
	&sql(select id into :configItmId from Ens_Config.item where production=:ProductionName and name=:componentName)
	set:SQLCODE configItmId=""
	
	zn NowNameSpace
	return configItmId
}

ClassMethod GetComponentType(componentId, NameSpace As %String) As %String
{
	quit:(($g(componentId)="")||($g(NameSpace)="")) ""
	set NowNameSpace=$namespace
	zn NameSpace
	
	set componentObj=##class(Ens.Config.Item).%OpenId(componentId)
	quit:'$IsObject(componentObj) ""
	set componentType=##class(Ens.Config.Item).GetBusinessType(componentObj.ClassName,componentObj)
	
	zn NowNameSpace
	return $Select(componentType=1:"Service",componentType=2:"Process",componentType=3:"Operation",1:"")
}

ClassMethod QueryEnsembleLog(componentName As %String, ZeroTimeStamp As %TimeStamp, Type As %Integer, NameSpace As %String) As %List
{
	quit:(($g(componentName)="")||($g(ZeroTimeStamp)="")||($g(Type)="")||($g(NameSpace)="")) ""
	set NowNameSpace=$namespace
	zn NameSpace
	
	set ZeroTimeStamp=$zdt(ZeroTimeStamp,3)
	set retVal=""
	set query="SELECT  SessionId,Text, TimeLogged FROM Ens_Util.Log where ConfigName=? and type=? and timelogged >=to_timestamp(?,'YYYY-MM-DD HH:MI:SS')"
	
	set statement=##class(%SQL.Statement).%New()
	set statement.%SelectMode=0
	set qStatus = statement.%Prepare(.query)
	
	if qStatus {
		set rset = statement.%Execute(componentName,Type,ZeroTimeStamp)
		
		while rset.%Next(){
			set logText=$zstrip($zstrip(rset.%Get("Text"),"*c"),"<=>w")
			set timeLogged=rset.%Get("TimeLogged")
			set retVal=retVal_$lb($lb($s($g(Type)=2:"Error",$g(Type)=3:"Warning",$g(Type)=6:"Alert",1:""),rset.%Get("SessionId"),logText,timeLogged))
			}
		}
	
	zn NowNameSpace
	return retVal
}

ClassMethod GetComponentErrors(componentName As %String, ZeroTimeStamp As %TimeStamp, NameSpace As %String) As %List
{
	
	quit:(($g(componentName)="")||($g(ZeroTimeStamp)="")||($g(NameSpace)="")) ""	
	return ..QueryEnsembleLog(componentName,ZeroTimeStamp,2,NameSpace)
}

ClassMethod GetComponentWarnings(componentName As %String, ZeroTimeStamp As %TimeStamp, NameSpace As %String) As %List
{
	quit:(($g(componentName)="")||($g(ZeroTimeStamp)="")||($g(NameSpace)="")) ""
	return ..QueryEnsembleLog(componentName,ZeroTimeStamp,3,NameSpace)
}

ClassMethod GetComponentAlerts(componentName As %String, ZeroTimeStamp As %TimeStamp, NameSpace As %String) As %List
{
	quit:(($g(componentName)="")||($g(ZeroTimeStamp)="")||($g(NameSpace)="")) ""
	return ..QueryEnsembleLog(componentName,ZeroTimeStamp,6,NameSpace)
}

ClassMethod GetComponentQueueData(componentName As %String, NameSpace As %String) As %String
{
	quit:(($g(componentName)="")||($g(NameSpace)="")) ""
	set NowNameSpace=$namespace
	zn NameSpace
	
	set (queueName,queueCount)=""
	set:$d(^Ens.Runtime("ConfigItem",componentName)) queueName=$g(^Ens.Runtime("ConfigItem",componentName,"QueueName"))
	set:(($g(queueName)'="")&&($d(^Ens.Queue(queueName)))&&($d(^Ens.Queue(queueName,0)))&&($d(^Ens.Queue(queueName,0,"count")))) queueCount=$g(^Ens.Queue(queueName,0,"count"))
	zn NowNameSpace
	return queueCount
}

ClassMethod GetComponentMessageCountAndAvg(componentName As %String, ZeroTimeStamp As %TimeStamp, NameSpace As %String) As %List
{
	quit:(($g(componentName)="")||($g(ZeroTimeStamp)="")||($g(NameSpace)="")) ""
	set NowNameSpace=$namespace
	zn NameSpace
	set (messageCount, avgProcessing)=""
	set ZeroTimeStamp=$zdt(ZeroTimeStamp,3)
	set query="select count(id) cnt,avg(DATEDIFF('ms',timecreated,TimeProcessed)) aveg FROM Ens.MessageHeader where (SourceConfigName=? or TargetConfigName=?) and TimeCreated>=to_timestamp(?,'YYYY-MM-DD HH:MI:SS')"
	set statement=##class(%SQL.Statement).%New()
	set statement.%SelectMode=0
	set qStatus = statement.%Prepare(query)
	
	if qStatus {
		set rset = statement.%Execute(componentName,componentName,ZeroTimeStamp)
		while rset.%Next(){
			set messageCount=rset.%Get("cnt")
			set avgProcessing=rset.%Get("aveg")
			}
		}
	
	zn NowNameSpace
	return $lb(messageCount, avgProcessing)
}

ClassMethod GetComponentJobs(componentName As %String, NameSpace As %String) As %List
{
	quit:(($g(componentName)="")||($g(NameSpace)="")) ""
	set NowNameSpace=$namespace
	zn NameSpace
	set retVal=""
	set query= "SELECT job,status FROM Ens.Job_Enumerate() where state='Alive' and ConfigName=?"
	set statement=##class(%SQL.Statement).%New()
	set statement.%SelectMode=0
	set qStatus = statement.%Prepare(query)
	
	if qStatus {
		set rset = statement.%Execute(componentName)
		while rset.%Next(){
			set retVal=retVal_$lb($lb(rset.%Get("job"),rset.%Get("status")))
			}
		}
	
	zn NowNameSpace
	return retVal
}

ClassMethod getDateTimeUTCIdx() As %String
{
	//padding datetime string to 10 digits
	set date=$P(##class(Ens.DataType.UTC).timeUTCH(),".",1)
	if $l(date)<11{
		set datePart=+date
		set timePart=$P(date,",",2)
		for ix=1:1:(5-$l(timePart)){
			set timePart="0"_timePart
			}
		set date=datePart_timePart
		}
	return $Tr(date,",","")
}

}
