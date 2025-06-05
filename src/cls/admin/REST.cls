/// Include COMMONMACROS
Class admin.REST Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

Parameter CHARSET = "UTF-8";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/" Method="GET" Call="version"/>
<Route Url="/info" Method="GET" Call="GetInfo"/>
<Route Url="/version" Method="GET" Call="version"/>
<Route Url="/addwebapp" Method="POST" Call="addWebApp"/>
<Route Url="/import/:namespace" Method="POST" Call="import"/>
<Route Url="/namespaces" Method="GET" Call="GetNamespaces"/>
<Route Url="/namespace/exist/:namespace" Method="GET" Call="namespaceExists"/>
<Route Url="/namespace" Method="POST" Call="createNamespace" />
<Route Url="/namespace" Method="DELETE" Call="deleteNamespace" />
<Route Url="/namespace/enable/:namespace" Method="GET" Call="enableNamespace" />
<Route Url="/namespace/enable/:namespace" Method="PUT" Call="enableNamespace" />
<Route Url="/namespace/disable/:namespace" Method="GET" Call="disableNamespace" />
<Route Url="/service" Method="GET" Call="service" />
<Route Url="/production" Method="POST" Call="createProduction" />
<Route Url="/security/export" Method="GET" Call="SecurityExport" />
<Route Url="/security/import" Method="GET" Call="SecurityImport" />
<Route Url="/key" Method="POST" Call="newKey" />
<Route Url="/_spec" Method="GET" Call="SwaggerSpec" />
</Routes>
}

/// Description
ClassMethod addWebApp() As %Status
{
    Set sc = $$$OK
    set %response.ContentType=..#CONTENTTYPEJSON
    set response = {}
    Try {
        set payload={}.%FromJSON(%request.Content)
        ; raise an error if payload is not valid
        if '$isobject(payload) {
            set sc = ##class(%Exception.General).%New("Invalid Payload","4001",,
                             "Payload must be a valid JSON object")
            throw sc
        }
        set webName = payload.webAppName
        if webName = "" {
            ; raise on error telling that webAppName is required
            set response.error = "webAppName is required"
            do response.%ToJSON()
            return sc
        } else {
            set response.webAppName = webName
            if payload.DispatchClass '="" {
                set webProperties("DispatchClass") = payload.DispatchClass
            } else {
                set webProperties("AutoCompile") = payload.AutoCompile
                set webProperties("CSPZENEnabled") = payload.CSPZENEnabled
                set webProperties("CSRFToken") = payload.CSRFToken
                set webProperties("CookiePath") = payload.CookiePath
                set webProperties("IsNameSpaceDefault") = payload.IsNameSpaceDefault
                set webProperties("Recurse") = payload.Recurse
                set webProperties("Type") = payload.Type
            }
            set webProperties("NameSpace") = payload.NameSpace
            set webProperties("Enabled") =  payload.Enabled
            set webProperties("AutheEnabled") = payload.AutheEnabled
            set webProperties("MatchRoles")= payload.MatchRoles
            if payload.LoginPage '= "" {
                set webProperties("LoginPage") = payload.LoginPage
            }
            

            set ns = $NAMESPACE
            zn "%SYS"
            if ##class(Security.Applications).Exists(webName) {
                set sc = ##class(Security.Applications).Modify(webName, .webProperties)
                if sc {
                    set response.status = "Web application "_webName_" successfully updated"
                } 
            } else {
                set sc = ##class(Security.Applications).Create(webName, .webProperties)
                if sc {
                    set response.status = "Web application "_webName_" successfully created"
                }
            }
            if 'sc {
                set response.status = $system.Status.GetErrorText(sc)
            }
            zn ns
          }
    }
    Catch ex {
        set sc=ex.AsStatus()
        set response.error = "Error creating web application: "_$system.Status.GetErrorText(sc)
    }
    do response.%ToJSON()

    Return sc
}

ClassMethod GetInfo() As %Status
{
    Set sc = $$$OK
    #; set %response.ContentType = ..#CONTENTTYPEJSON

    write "{""status"":""ok""}"
    #; write ["Hello World!"]

    Return sc
}

ClassMethod import(namespace As %String) As %Status
{
    set %response.ContentType=..#CONTENTTYPEJSON
    set response = {}
	
    set ns = $NAMESPACE
    if namespace '= "" {
        set ns = namespace
    } else {
        ; raise on error telling that namespace is required
        set response.error = "Namespace is required"
        do response.%ToJSON()
        return
    }
    zn namespace

    set payload={}.%FromJSON(%request.Content)
    set response.filename=payload.filename
    set filename = payload.filename
    if filename = "" {
        ; raise on error telling that filename is required
        set response.error = "Filename is required"
        do response.%ToJSON()
        return
    }

    set sc = ##class(%SYSTEM.OBJ).Import(filename,"ck",,.errors,.exported)
    if sc {
        set response.status = sc
    } else {
        set response.status = $system.Status.GetErrorText(sc)
    }

    set response.errors = []
    set key = ""
    do {
        set key = $order(errors(key),1,nb)
        quit:key=""
        #; set data = {}
        #; set data.element = key
        #; set data.nb = nb 
        do response.errors.%Push(key_":"_nb)
    } while key '= ""
 
    set response.errors = [],key = ""
    #; For  {
    #;     Set key = $Order(errors(key))
    #;     Quit:key=""
    #;     // Ajout de chaque erreur dans la liste JSON
    #;     Do response.errors.%Push(errors(key))
    #; }

    set response.imported = [],key = ""
    do { 
        set key=$order(errors(key),1,msg) 
        do response.imported.%Push(key_":"_msg)
    } while key'=""
   
    set key = ""
    do { 
        set key=$order(imported(key),1) 
        do response.imported.%Push(key)
    } while key'=""
  
    
	do response.%ToJSON()	
    zn ns
	return $$$OK
}

ClassMethod SecurityExport() As %Status
{
    set %response.ContentType=..#CONTENTTYPEJSON
    set response = {}
	
    set ns = $NAMESPACE
    zn "%sys"
    set filename = "/data/SecurityExport.xml"
    set response.filename = filename
    set sc = ##class(Security.System).ExportAll(filename,.exported)
    if sc {
        set response.status = sc
    } else {
        set response.status = $system.Status.GetErrorText(sc)
    }
    set response.exported = []
    set key = ""
    do {
        set key = $order(exported(key),1,nb)
        quit:key=""
        #; set data = {}
        #; set data.element = key
        #; set data.nb = nb
        do response.exported.%Push(key_":"_nb)
    } while key '= ""
	do response.%ToJSON()	
	return $$$OK
}

ClassMethod SecurityImport() As %Status
{
    set %response.ContentType=..#CONTENTTYPEJSON
    set response = {}
	
    set ns = $NAMESPACE
    zn "%sys"
    set filename = "/data/SecurityExport.xml"
    set response.filename = filename
    set sc = ##class(Security.System).ImportAll(filename,.exported,-1,0)
    if sc {
        set response.status = sc
    } else {
        set response.status = $system.Status.GetErrorText(sc)
    }
    set response.imported = []
    set key = ""
    do {
        set key = $order(exported(key),1,nb)
        quit:key=""
        do response.imported.%Push(key _ ":" _ nb)
        
    } while key '= ""
	do response.%ToJSON()	
	return $$$OK
}

ClassMethod newKey() As %Status
{
    set sc=$$$OK,%response.ContentType= ..#CONTENTTYPEJSON
    set json={}
    set payload={}.%FromJSON(%request.Content)
    set json.key=payload.key

    set key = ##class(%File).%New($system.Util.ManagerDirectory()_"iris.key")
    set sc = key.Open("WS")
    if sc {
        set copy =  ##class(%File).CopyFile($system.Util.ManagerDirectory()_"iris.key",$system.Util.ManagerDirectory()_"iris.key.old")
        set json.copy = copy
        do key.Write(json.key)
        do key.Close()
    } else {
        set json.openFileError=$system.Status.GetErrorText(sc)
    }
    do json.%ToJSON()
    
    return sc
}

ClassMethod version() As %Status
{
    set sc=$$$OK
    set %response.ContentType= ..#CONTENTTYPEJSON
    set json={}
    set json.classname = (..%ClassName(1))
    set json.version=($zv)
    set json.date=($zdt($h,3))
    set json.system=($System)
    set json.username=($Username)
    set json.roles=($Roles)
    set json.namespace=($Namespace)
    set nls=##class(%SYS.NLS.Locale).GetLanguage()
    set json.country=($listget(nls,1))
    set json.lang=($listget(nls,2))
    set json.JavaHomeDirectory=$SYSTEM.Util.JavaHomeDirectory()
    set json.JavaExe=$SYSTEM.Util.JavaExe()
    do json.%ToJSON()
    #; write "Hello "_$USERNAME
    return sc
}

ClassMethod createNamespace() As %Status
{
    set sc=$$$OK
    set %response.ContentType= ..#CONTENTTYPEJSON
    set json={}
    set payload={}.%FromJSON(%request.Content)
    set json.namespace=payload.namespace
    set json.directory=##class(%Library.File).NormalizeDirectory(payload.directory)_payload.namespace
    set json.directory=##class(%Library.File).NormalizeDirectory(json.directory)
    set json.interop=payload.interop

    try {
        set ns=$namespace
        zn "%sys"
        if ..namespaceExists(json.namespace) {
            set alreadyExist = ##class(%Exception.General).%New("ALREADY EXIST","5001",,
                             json.namespace_" is already existing")
            throw alreadyExist
        }
        zn ns
        set vars("NAMESPACE")=json.namespace
        set vars("DATABASEDIR")=json.directory
        set vars("INTEROP")=json.interop
        set sc=##class(admin.installer.namespace).setup(.vars)
        set json.status=json.namespace_" successfully created"  
    } catch e {
        set sc=e.AsStatus()
        set msg="erreur durant la création de l'espace de noms "_json.namespace_"("_$system.Status.GetErrorText(sc)_")",severity=1
        do ##class(%SYS.System).WriteToConsoleLog(msg,0,severity)
    }
    do json.%ToJSON()
    return sc
}

ClassMethod deleteNamespace() As %Status
{
    set sc=$$$OK
    set ns=$namespace
    zn "%SYS"
    set %response.ContentType= ..#CONTENTTYPEJSON
    set json={}
    set payload={}.%FromJSON(%request.Content)
    set json.namespace=payload.namespace
    set json.directory=##class(%Library.File).NormalizeDirectory(payload.directory)_payload.namespace
    set json.directory=##class(%Library.File).NormalizeDirectory(json.directory)
    
    try {
       
        set:..namespaceExists(json.namespace) sc=##Class(Config.Namespaces).Delete(json.namespace)
        set:sc json.status=json.namespace_" successfully deleted"
        set json.databases=[]
        for dbType="_SRC","_DATA" {
            set dbName=json.directory_json.namespace_dbType
            set sc=##class(SYS.Database).DismountDatabase(dbName)
            set sc=##class(SYS.Database).DeleteDatabase(dbName)
            set sc=##class(Config.Databases).Delete(json.namespace_dbType)
            do:sc json.databases.%Push(dbName_" successfully deleted")
        }
        
        set json.deleted=##class(%Library.File).RemoveDirectoryTree(json.directory)

        set sc=##class(Security.Applications).Delete("/csp/"_json.namespace)
        set:sc json.CSPApplication="/csp/"_json.namespace_" successfully deleted"

        set json.resources = []
        for resourceName = "%DB_"_json.namespace_"_DATA","%DB_"_json.namespace_"_SRC" {
            set sc = ##class(Security.Resources).Delete(resourceName)
            do:sc json.resources.%Push(resourceName _ " successfully deleted")
        }
        

    } catch e {
        set sc=e.AsStatus()
        set msg="erreur durant la création de l'espace de noms "_json.namespace_"("_$system.Status.GetErrorText(sc)_")",severity=1
        do ##class(%SYS.System).WriteToConsoleLog(msg,0,severity)
    }
    do json.%ToJSON()
    zn ns
    return sc
}

ClassMethod enableNamespace(namespace As %String) As %Status
{
    set sc=$$$OK
    set %response.ContentType= ..#CONTENTTYPEJSON
    set json={}
    set json.namespace=namespace
    
    try {
        #; if '##class(%Library.EnsembleMgr).IsEnsembleNamespace(namespace){
            set sc=##class(%Library.EnsembleMgr).EnableNamespace(namespace,0)
            set json.status=namespace_" successfully enabled to function with interoperability"
        #; }        
    } catch e {
        set sc=e.AsStatus()
        set msg="erreur durant la création de l'espace de noms "_namespace_"("_$system.Status.GetErrorText(sc)_")",severity=1
        do ##class(%SYS.System).WriteToConsoleLog(msg,0,severity)
    }
    
    do json.%ToJSON()
    return sc
}

ClassMethod disableNamespace(namespace As %String) As %Status
{
    set sc=$$$OK
    set %response.ContentType= ..#CONTENTTYPEJSON
    set json={}
    set json.namespace=namespace
    
    try {
        if ##class(%Library.EnsembleMgr).IsEnsembleNamespace(namespace){
            set sc=##class(%Library.EnsembleMgr).DisableNamespace(namespace,0)
            set json.status=namespace_" successfully disabled to function with interoperability"
        }        
    } catch e {
        set sc=e.AsStatus()
        set msg="erreur durant la création de l'espace de noms "_namespace_"("_$system.Status.GetErrorText(sc)_")",severity=1
        do ##class(%SYS.System).WriteToConsoleLog(msg,0,severity)
    }
    
    do json.%ToJSON()
    return sc
}

// 1. Create %Dictionary.ClassDefinition object for your test production

// 2. Create Ens.Config.Production object

// 3. Create %Dictionary.XDataDefinition

// 4. Serialize (2) into (3)

// 5. Insert XData (3) into (1)

// 6. Save and compile (1)

ClassMethod createProduction() As %Status
{
    set sc=$$$OK
    set %response.ContentType= ..#CONTENTTYPEJSON
    set json={}
    set payload={}.%FromJSON(%request.Content)
    set json.namespace=payload.namespace
    set json.production=payload.production
    

    try {
        set ns=$Namespace
        zn json.namespace
        if ##Class(Ens.Config.Production).%ExistsId(json.production) {
            set alreadyExist = ##class(%Exception.General).%New("ALREADY EXIST","5001",,
                             json.production_" is already existing in "_json.namespace)
            throw alreadyExist
        }
        set a=##class(%Dictionary.ClassDefinition).%New()
        set a.Name=json.production
        set a.Super="Ens.Production"
        

        set prod=##class(Ens.Config.Production).%New()
        set prod.Name=json.production
        
        set service=##class(Ens.Config.Item).%New()
        set service.Name="from a file"
        set service.ClassName="EnsLib.File.PassthroughService"
        set target=##class(Ens.Config.Setting).%New()
        set target.Name="TargetConfigNames"
        set target.Value="router"
        do service.Settings.Insert(target)
        set FilePath=##class(Ens.Config.Setting).%New()
        set FilePath.Name="FilePath"
        set FilePath.Value="/file/in"
        do service.Settings.Insert(FilePath)
        set FileSpec=##class(Ens.Config.Setting).%New()
        set FileSpec.Name="FileSpec"
        set FileSpec.Value="*.txt"
        do service.Settings.Insert(FileSpec)

        do prod.Items.Insert(service)

        set process=##class(Ens.Config.Item).%New()
        set process.Name="router"
        set process.ClassName="EnsLib.MsgRouter.RoutingEngine"
        do prod.Items.Insert(process)

        set operation=##class(Ens.Config.Item).%New()
        set operation.Name="to a file"
        set operation.ClassName="EnsLib.File.PassthroughOperation"
        do prod.Items.Insert(operation)
        
        set sc=prod.%Save()
        
        set xdata=##class(%Dictionary.XDataDefinition).%New()
        set xdata.Name="ProductionDefinition"
        set sc=prod.XMLExportToStream(xdata.Data,,",indent")
        set sc=a.XDatas.Insert(xdata)

        set sc=a.%Save()
        set sc=$system.OBJ.Compile(json.production,"-d")

        set json.status=json.production_" successfully created in "_json.namespace_" ("_sc_")"
        zn ns
    } catch e {
        set sc=e.AsStatus()
        set msg="erreur durant la création de la production "_json.production_"("_$system.Status.GetErrorText(sc)_")",severity=1
        do ##class(%SYS.System).WriteToConsoleLog(msg,0,severity)
    }
    do json.%ToJSON()
    return sc
}

ClassMethod service() As %Status
{
 try {
	set sc=$$$OK
    set ns = $NAMESPACE
	set %response.ContentType= ..#CONTENTTYPEJSON

	set payload=%request.Content

	set tSC=##class(Ens.Director).CreateBusinessService("from analytics",.tService)

	set request=##class(Ens.StringRequest).%New()
	#; set request.StringValue=payload.Read()
    set request.StringValue="demande analyse compte cibles"

	set sc=tService.ProcessInput(request,.response)
	set retour={}
	#; set retour.data=response.StringValue
    set retour.message="votre demande a été prise en compte"
    set retour.action="vous recevrez un email dès qu'elle sera traitée, vous indiquant la démarche à suivre"
    set retour.date=($zdt($h,3))
	write retour.%ToJSON()
	} catch e {
		throw e
	}
	return sc
}

ClassMethod namespaceExists(namespace As %String) As %Boolean
{
    set ns=$Namespace
    zn "%sys"
    set exist =  ##Class(Config.Namespaces).Exists(namespace)
    zn ns
    return exist
}

/// This method returns a list of namespaces for this server
ClassMethod GetNamespaces() As %Status
{
    #dim tSC As %Status = $$$OK
    #dim tList,tNS,tFilteredList,tValue As %String
    
    #; Get the list of namespaces
    Do List^%SYS.NAMESPACE(.tList)
    Set tNS="" For  {
    
        Set tNS=$Order(tList(tNS),1,tValue) If tNS="" Quit
    
        #; Only want namespaces which are enabled and are not remote
        If $List(tValue,1)=1&&$List(tValue,2)=0 {
            Set tFilteredList(tNS)=""
        }
    }
    
    #; If we have been asked for json
    If $Get(%request.CgiEnvs("HTTP_ACCEPT"))= ..#CONTENTTYPEJSON {
        
        #; Set the response header to JSON
        Set %response.ContentType= ..#CONTENTTYPEJSON
        
        #; Create a JSON proxy
        Set tProxy = ##class(%ZEN.proxyObject).%New()
        
        #; And a list to hold the namespaces
        Set tList=##class(%Library.ListOfDataTypes).%New()
        
        #; Add the namespaces to the list
        Set tNS="" For  {
            Set tNS=$Order(tFilteredList(tNS)) If tNS="" Quit
            Do tList.Insert(tNS)
        }
        
        #; Set the namespace property
        Set tProxy.namespaces=tList
        
        #; Output the JSON
        Do tProxy.%ToJSON()
        
    } else {
        
        Set tNS="" For  {
            Set tNS=$Order(tFilteredList(tNS)) If tNS="" Quit
            Write tNS,!
        }
    }
    Quit tSC
}

ClassMethod SwaggerSpec() As %Status
{

  Set tSC = ##class(%REST.API).GetWebRESTApplication($NAMESPACE, %request.Application, .swagger)

  Do swagger.info.%Remove("x-ISC_Namespace")

  Set swagger.basePath = "/admin"

  Set swagger.info.title = "InterSystems IRIS REST ADMIN"

  Set swagger.info.version = "1.0"

  Set swagger.host = "localhost:50200"

  Return ..%ProcessResult($$$OK, swagger)
}

ClassMethod %ProcessResult(pStatus As %Status = {$$$OK}, pResult As %DynamicObject = "") As %Status [ Internal ]
{
  #dim %response As %CSP.Response
  SET tSC = $$$OK
  IF $$$ISERR(pStatus) {
    SET %response.Status = 500
    SET tSC = ..StatusToJSON(pStatus, .tJSON)
    IF $isobject(tJSON) {
      SET pResult = tJSON
    } ELSE {
      SET pResult = { "errors": [ { "error": "Unknown error parsing status code" } ] }
    }
  } 
  ELSEIF pStatus=1 {
    IF '$isobject(pResult){
      SET pResult = {
      }
    }
  }
  ELSE {
    SET %response.Status = pStatus
    SET error = $PIECE(pStatus, " ", 2, *)
    SET pResult = {
      "error": (error)
    }
  }
  
  IF pResult.%Extends("%Library.DynamicAbstractObject") {
    WRITE pResult.%ToJSON()
  }
  ELSEIF pResult.%Extends("%JSON.Adaptor") {
    DO pResult.%JSONExport()
  }
  ELSEIF pResult.%Extends("%Stream.Object") {
    DO pResult.OutputToDevice()
  }
  
  QUIT tSC
}

}
