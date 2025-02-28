Include Ensemble

Class ProdEye.Prod.ProdEyeRest Extends EnsLib.REST.Service
{

Property PageSize As %Integer [ InitialExpression = 10 ];

Property TokenValidationURL As %String;

Parameter SETTINGS = "PageSize,TokenValidationURL";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
	<Route Url="/getdata" Method="POST" Call="GetData"/>
	</Routes>
}

Method GetData(pInput As %Library.AbstractStream, Output poutput As %Stream) As %Status
{
	quit:'$IsObject(pInput) $$$OK
	quit:(pInput.SizeGet()=0) $$$OK
	
	set paramsObj={}.%FromJSON(pInput.Read())
	set cutoff=paramsObj.cutoff
	set authorisation=paramsObj.Authorisation
	set profilename=paramsObj.profilename
	
	$$$TRACE(..Adapter.IOAddr_" Profile "_profilename_" cutoff parameter: "_paramsObj.%ToJSON())
	
	if ('..Authorise(authorisation,..TokenValidationURL)){
		do poutput.Write("{""Error"":""Invalid Credentials""}")
		do ..ReportHttpStatusCode(403)
		 return $$$OK
	}
	
	if ('..ValidateCutoff(cutoff)){
		do poutput.Write("{""Error"":""Invalid Request Parameters""}")
		do ..ReportHttpStatusCode(400)
		 return $$$OK
	}
	
	
	try{
		set packageName=$P($classname(),".",1)
		SET db = ##class(%DocDB.Database).%GetDatabase(packageName_".DB.ProdEyeDocument")
		set restriction=[]
		do restriction.%Push("TimeOfQueryIdx")
		do restriction.%Push(cutoff)
		do restriction.%Push(">")
		
		do restriction.%Push("ProfileName")
		do restriction.%Push(profilename)
		do restriction.%Push("=")
		
		SET result = db.%FindDocuments(restriction)
		
		if (($IsObject(result))&&($Isobject(result.content))){
			set resultPage={}
			set resultPage.Next=0
			set resultList=[]
			
			set iter=result.content.%GetIterator()
			for dx=1:1:..PageSize{
				set resultItem=iter.%GetNext(.key,.resultItemvalue)
				if $IsObject(resultItemvalue){
					set resultItemvalue={}.%FromJSON(resultItemvalue.%Doc)
					do resultList.%Push(resultItemvalue)
					set:dx>1 resultPage.Next=resultItemvalue.TimeOfQueryIdx
				}
				}
		set resultPage.content=resultList
		
		
		do poutput.Write(resultPage.%ToJSON())
		}else {
			Throw $$$ERROR("5001","Error During Processing Data")
			}
	} catch error {
		do poutput.Write("{""Error"":""Error During Processing Data : """_error.AsSystemError()_""" ""}")
		do ..ReportHttpStatusCode(500)
		}
	
	return $$$OK
}

ClassMethod ValidateCutoff(val As %String) As %Boolean
{
	set sc=1
	
	quit:+val<=0 0
	quit:$l(+val)<5 0
	
	set valdt=$E(val,1,5)_","_$E(val,6,10)
	
	try {
		set date=$zdt(valdt)
		
	}catch err{
			
			set sc=0
		}
	
	return sc
}

ClassMethod Authorise(val As %String, TokenValidationURL As %String) As %Boolean
{
	quit:$g(val)="" 0
	if (TokenValidationURL=""){
		set type=$P(val," ",1)
		set type=$zstrip($zstrip(type,"*c"),"<=>w")
		quit:$ZCVT(type,"L")'="basic" 0
		
		set userpass=$P(val," ",2)
		set userpassDecoded=$system.Encryption.Base64Decode(userpass)
		
		set user=$P(userpassDecoded,":",1)
		set user=$zstrip($zstrip(user,"*c"),"<=>w")
		set pass=$P(userpassDecoded,":",2)
		set pass=$zstrip($zstrip(pass,"*c"),"<=>w")
		
		set prodeyeUser=##class(Ens.Config.Credentials).GetValue("ProdEyeUser","Username")
		set prodeyePass=##class(Ens.Config.Credentials).GetValue("ProdEyeUser","Password")
		
		return ((prodeyeUser=user)&&(prodeyePass=pass))
	}elseif(TokenValidationURL'=""){
		set prodeyeAuthUser=##class(Ens.Config.Credentials).GetValue("ProdEyeAuthUser","Username")
		set prodeyeAuthPass=##class(Ens.Config.Credentials).GetValue("ProdEyeAuthUser","Password")
		
		set tokenVerificationRequest=##class(%Net.HttpRequest).%New()
		do tokenVerificationRequest.SetHeader("content-type","application/json")
		do tokenVerificationRequest.SetHeader("Authorisation","BASIC "_$system.Encryption.Base64Encode(prodeyeAuthUser_":"_prodeyeAuthPass))
		set token=$P(val," ",2)
		set data={}
		set data.Token=token
		do tokenVerificationRequest.EntityBody.Write(data.%ToJSON())
		do tokenVerificationRequest.Post(TokenValidationURL)
		
		set response=tokenVerificationRequest.HttpResponse
		if ($IsObject(response) && $IsObject(response.Data) && response.StatusCode=200 ){
			set message="" while 'response.Data.AtEnd {set message=message_response.Data.Read(,.tSC) if 'tSC quit}
			set responseMessage={}.%FromJSON(message)
			if (responseMessage.%IsDefined("IsValid") && (responseMessage.IsValid="1")){
				return 1
			}else{
				return 0	
					}
		}else{
			return 0		
				}
		}
}

}
