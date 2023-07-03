Include common

Class REST.crud Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/" Method="GET" Call="version"/>
<Route Url="/api/:classname" Method="GET" Call="readAll"/>
<Route Url="/api/:classname" Method="POST" Call="create"/>
<Route Url="/api/:classname/:id" Method="GET" Call="read"/>
<Route Url="/api/:classname/:id" Method="PUT" Call="update"/>
<Route Url="/api/:classname/:id" Method="DELETE" Call="delete"/>
<Route Url="/_spec" Method="GET" Call="spec" />
</Routes>
}

ClassMethod readAll(classname As %String) As %Status
{
    set sc = $$$OK
    set %response.ContentType = ..#CONTENTTYPEJSON
    set json = {}
    Try {
        if ##class(%Dictionary.ClassDefinition).%ExistsId(classname) {
            set class = ##class(%Dictionary.ClassDefinition).%OpenId(classname)
            set tableName = class.SqlTableName
            set:tableName="" tableName = $replace(classname,".","_")
            set sql = "select ID from " _ tableName
            set result = ##class(%SQL.Statement).%ExecDirect(,sql)
            if result.%SQLCODE = 0 {
                set json = []
                while result.%Next() { 
                    set a = $CLASSMETHOD(classname,"%OpenId",result.%GetData(1))
                    if $ISOBJECT(a) {
                        set sc = a.%JSONExportToStream(.str)
                        do json.%Push({}.%FromJSON(str))
                    }
                }
            } else {
                set json.SQLCODE = (result.%SQLCODE) 
                set json.Message = (result.%Message) 
                do json.%ToJSON()
            }
        } else {
            set json.error = classname _ " doesn't exist"
            do json.%ToJSON()
        }
        do json.%ToJSON()
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    return sc
}

ClassMethod create(classname) As %Status
{
    Try {
        set start = $zh 
        set sc = $$$OK
        set %response.ContentType = ..#CONTENTTYPEJSON
        set json = {} 
        set json.system = $SYSTEM
        set json.ts = $zdt($now(),3,,6)
        set json.classname = (classname)
        set payload = {}.%FromJSON(%request.Content) 
        set id ="" 
        
        if ##class(%Dictionary.ClassDefinition).%ExistsId(classname) {
            set a = $CLASSMETHOD(classname,"%New")
            set sc = a.%JSONImport(payload)
            if sc {
                set sc = a.%Save()
                if sc {
                    set id = a.%Id()
                }
            }
        } else {
            set sc = $SYSTEM.Status.Error(5001,classname _ " doesn't exist")
        }
        if sc {
            set msg = "create " _ id _ " in " _ classname _ " successful"
            $$$log($this _ " create","ok",msg)
        } else {
            set msg = "error while creating " _ id _ " in " _ classname _ " : " _ $system.Status.GetErrorText(sc)
            $$$log($this _ " create","error",msg)
        }
        set json.id = (id)
        set json.msg = (msg)
        set json.elapse = $zh - start 
        do json.%ToJSON() 
    }
    Catch ex {
        set sc = ex.AsStatus()
    }
    return sc
}

ClassMethod read(classname, id) As %Status
{
    Try {
        set start = $zh 
        set sc = $$$OK
        set %response.ContentType = ..#CONTENTTYPEJSON
        set json = {}
        if ##class(%Dictionary.ClassDefinition).%ExistsId(classname) {
            if $CLASSMETHOD(classname,"%ExistsId",id) {
                set a = $CLASSMETHOD(classname,"%OpenId",id)
                if $IsObject(a) {
                    set sc = a.%JSONExportToStream(.str)
                    set json = {}.%FromJSON(str)
                }
            } else {
                set sc = $SYSTEM.Status.Error(5001, id _ " doesn't exist in " _ classname)
            }
        } else {
            set sc = $SYSTEM.Status.Error(5001,classname _ " doesn't exist")
        }
        if sc {
            set msg = "read " _ id _ " in " _ classname _ " successful"
            $$$log($this _ " read","ok",msg)
        } else {
            set msg = "error while deleting " _ id _ " of " _ classname _ " : " _ $system.Status.GetErrorText(sc)
            $$$log($this _ " read","error",msg)
            set json.msg = (msg)
        }

        do json.%ToJSON() 
    }
    Catch ex {
        set sc = ex.AsStatus()
    }
    return sc
}

ClassMethod update(classname, id) As %Status
{
    Try {
        set start = $zh 
        set sc = $$$OK
        set %response.ContentType = ..#CONTENTTYPEJSON
        set json = {} 
        set json.system = $SYSTEM
        set json.ts = $zdt($now(),3,,6)
        set json.classname = (classname)
        set payload = {}.%FromJSON(%request.Content) 
        
        if ##class(%Dictionary.ClassDefinition).%ExistsId(classname) {
            if $CLASSMETHOD(classname,"%ExistsId",id) {
                set a = $CLASSMETHOD(classname,"%OpenId",id)
                set sc = a.%JSONImport(payload)
                if sc {
                    set sc = a.%Save()
                }
            } else {
                set sc = $SYSTEM.Status.Error(5001, id _ " doesn't exist in " _ classname)
            }
        } else {
            set sc = $SYSTEM.Status.Error(5001,classname _ " doesn't exist")
        }
        if sc {
            set msg = "update " _ id _ " in " _ classname _ " successful"
            $$$log($this _ " update","ok",msg)
        } else {
            set msg = "error while updating " _ id _ " of " _ classname _ " : " _ $system.Status.GetErrorText(sc)
            $$$log($this _ " update","error",msg)
        }
        set json.id = id
        set json.msg = (msg)
        set json.elapse = $zh - start 
        do json.%ToJSON() 
    }
    Catch ex {
        set sc = ex.AsStatus()
    }
    return sc
}

ClassMethod delete(classname, id) As %Status
{
    Try {
        set start = $zh 
        set sc = $$$OK
        set %response.ContentType = ..#CONTENTTYPEJSON
        set json = {} 
        set json.system = $SYSTEM
        set json.ts = $zdt($now(),3,,6)
        set json.classname = (classname)
        if ##class(%Dictionary.ClassDefinition).%ExistsId(classname) {
            if $CLASSMETHOD(classname,"%ExistsId",id) {
                set sc = $CLASSMETHOD(classname,"%DeleteId",id)
            } else {
                set sc = $SYSTEM.Status.Error(5001, id _ " doesn't exist in " _ classname)
            }
        } else {
            set sc = $SYSTEM.Status.Error(5001,classname _ " doesn't exist")
        }
        if sc {
            set msg = "delete " _ id _ " in " _ classname _ " successful"
            $$$log($this _ " delete","ok",msg)
        } else {
            set msg = "error while deleting " _ id _ " of " _ classname _ " : " _ $system.Status.GetErrorText(sc)
            $$$log($this _ " delete","error",msg)
        }
        set json.id = id
        set json.msg = (msg)
        set json.elapse = $zh - start 
        do json.%ToJSON() 
    }
    Catch ex {
        set sc = ex.AsStatus()
    }
    return sc
}

ClassMethod version() As %Status
{

    set sc = $$$OK
    set %response.ContentType = ..#CONTENTTYPEJSON
    set json = {}
    set json.context="formation-iris-embedded"
    set json.version = ($zv)
    set json.date = ($zdt($h,3))
    set json.system = ($System)
    set json.username = ($Username)
    set json.roles = ($Roles)
    set json.namespace = ($Namespace)
    set nls = ##class(%SYS.NLS.Locale).GetLanguage()
    set json.country = ($listget(nls,1))
    set json.lang = ($listget(nls,2))
    set json.JavaHomeDirectory = $SYSTEM.Util.JavaHomeDirectory()
    set json.JavaExe = $SYSTEM.Util.JavaExe()
    do json.%ToJSON()
    return sc
}

// ClassMethod spec() As %Status

// {

//  try {

// 	set sc=$$$OK

// 	set %response.ContentType=..#CONTENTTYPEJSON

//     set file = ##class(%File).%New("/data/swagger-crud.json")

//     do file.Open("RS")

//     while 'file.AtEnd{

//         w file.ReadLine()

//     }

// 	} catch e {

// 		throw e

// 	}

// 	return sc

// }

ClassMethod spec() As %Status
{
  Set tSC = ##class(%REST.API).GetWebRESTApplication($NAMESPACE, %request.Application, .swagger)
  Do swagger.info.%Remove("x-ISC_Namespace")
  Set swagger.basePath = "/crud"
  Set swagger.info.title = "InterSystems IRIS CRUD demo"
  Set swagger.info.version = "0.1"
  Set swagger.host = "localhost:12773"
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

ClassMethod OnHandleCorsRequest(url As %String) As %Status
{
	set url = %request.GetCgiEnv("HTTP_REFERER")
    set origin = $p(url,"/",1,3) // origin = "http(s)://origin.com:port"

    // here you can check specific origins
    // otherway, it will allow all origins (useful while developing only)

	do %response.SetHeader("Access-Control-Allow-Credentials","true")
	do %response.SetHeader("Access-Control-Allow-Methods","GET,POST,PUT,DELETE,OPTIONS")
	do %response.SetHeader("Access-Control-Allow-Origin",origin)
	do %response.SetHeader("Access-Control-Allow-Headers","Access-Control-Allow-Origin, Origin, X-Requested-With, Content-Type, Accept, Authorization, Cache-Control")
	quit $$$OK
}

}
