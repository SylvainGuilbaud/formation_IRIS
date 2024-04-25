Class common.REST Extends %CSP.REST
{

Parameter IMPORTDESTINATION = "IRISAPP";

Parameter UseSession As BOOLEAN = 1;

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPEPDF = "application/pdf";

Parameter CONTENTTYPEGIF = "image/gif";

Parameter CONTENTTYPEOCTETSTREAM = "application/octet-stream";

Parameter CONTENTTYPESVG = "image/svg+xml";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/" Method="GET" Call="version"/>
<Route Url="/pop/:classname/:nb" Method="GET" Call="pop"/>
<Route Url="/add" Method="POST" Call="add"/>
<Route Url="/initdb" Method="POST" Call="initdb "/>
<Route Url="/import" Method="POST" Call="importXML"/>
<Route Url="/delete" Method="POST" Call="delete"/>
<Route Url="/importjson" Method="POST" Call="importJSON"/>
<Route Url="/importxml" Method="POST" Call="importXML"/>
<Route Url="/nb/:classname" Method="GET" Call="nb"/>
<Route Url="/kill/:classname" Method="DELETE" Call="kill"/>
<Route Url="/kill/:classname" Method="GET" Call="kill"/>
<Route Url="/exportbyid/:classname/:format/:id" Method="GET" Call="exportById"/>
<Route Url="/list/:classname/:format" Method="GET" Call="list"/>
<Route Url="/list/:classname/:format/:min/:max" Method="GET" Call="listTop"/>
<Route Url="/stream/:classname/:property/:id" Method="GET" Call="stream" />
<Route Url="/request/:classname/:property/:id/:full" Method="GET" Call="Request" />
<Route Url="/file/:filename" Method="POST" Call="file"/>
<Route Url="/service" Method="POST" Call="service" />
<Route Url="/_spec" Method="GET" Call="spec" />
<Route Url="/__spec/:filename" Method="GET" Call="fileSpec" />
<Route Url="/dump" Method="GET" Call="dump" />
</Routes>
}

ClassMethod fileSpec(filename As %String) As %Status
{

 try {

	set sc=$$$OK

	set %response.ContentType=..#CONTENTTYPEJSON

    #; set json = {
    #;     "ts":($zdt($h,3)),
    #;     "filename":(##class(%CSP.Page).UnescapeURL(filename))
    #; }
    #; do json.%ToJSON()

    set data = {}.%FromJSON(##class(%CSP.Page).UnescapeURL(filename))
    #; do data.%ToJSON()

    set file = ##class(%File).%New(data.directory_data.name)


    do file.Open("RS")

    while 'file.AtEnd{

        w file.ReadLine()

    }

	} catch e {

		throw e

	}

	return sc
}

ClassMethod Request(classname, property, id, full) As %Status
{
	Set %response.ContentType="text/plain"	
    Do:full $SYSTEM.OBJ.Dump(%request)   
    #; write %request.CgiEnvs("PATH")
    write "HTTP_USER_AGENT : " _ %request.CgiEnvs("HTTP_USER_AGENT") 
    write $c(13,10)
    write "SERVER_ADDR : " _%request.CgiEnvs("SERVER_ADDR")
    write $c(13,10)
    write "REMOTE_ADDR : " _%request.CgiEnvs("REMOTE_ADDR")
    write $c(13,10)
    write "SERVER_SOFTWARE : " _%request.CgiEnvs("SERVER_SOFTWARE")
    write $c(13,10)
    write "HTTP_HOST : " _%request.CgiEnvs("HTTP_HOST")
    Quit $$$OK
}

ClassMethod dump() As %Status
{
	Set %response.ContentType="text/plain"
	Do $System.OBJ.Dump(%request)
    Quit $$$OK
}

ClassMethod delete() As %Status
{
    Try {
        set start = $zh 
        set sc = $$$OK
        set %response.ContentType = ..#CONTENTTYPEJSON
        set json = {} 
        set json.system = $SYSTEM
        set json.ts = $zdt($now(),3,,6)
        set payload = {}.%FromJSON(%request.Content) 
        set json.classname = payload.tablename 
        set json.init = payload.init 
        set imported = 0 
        set array = payload.data.%GetIterator() 
        set json.nbRecords = payload.data.%Size() 
        set json.parseError = [],json.saveError = [] 
        set ^import(json.classname,json.ts,"received") = $Get(^import.received(json.classname,json.ts,"received"),0) + json.nbRecords
        
        if ##class(%Dictionary.ClassDefinition).%ExistsId(json.classname) {
            set class = ##class(%Dictionary.ClassDefinition).%OpenId(json.classname)  
            set IdLocation = class.Storages.GetAt(1).IdLocation
            set DataLocation = class.Storages.GetAt(1).DataLocation
            set IndexLocation = class.Storages.GetAt(1).IndexLocation
            set StreamLocation = class.Storages.GetAt(1).StreamLocation
            set json.IdLocation = (IdLocation)
            if (json.init) { 
                kill @DataLocation,@IndexLocation,@StreamLocation 
            }
            
            while array.%GetNext(.key,.value) { 
                set a=$CLASSMETHOD(json.classname,"%New") 
                set ID = $INCREMENT(^admin.migration(json.classname))
                set parseOK=a.%JSONImport(value)    
                if 'parseOK { 
                set parseError = {}
                set parseError.error = $system.Status.GetErrorText(parseOK)
                set parseError.key = (key) 
                set ^admin.migration(json.classname,"parse error",$zdt($now(),3,,6)) = parseError.error 
                do json.parseError.%Push(parseError) 
            } 
                set saveOK = a.%Save() 
                if 'saveOK { 
                    set saveError = {}
                    set saveError.key = (key)
                    set saveError.error = ($system.Status.GetErrorText(saveOK)) 
                    set ^admin.migration(json.classname,"save error",ID) = saveError.error 
                    do json.saveError.%Push(saveError) 
                } else {
                    set imported=$INCREMENT(imported) 
                }
            }

        } else {
            set sc = $SYSTEM.Status.Error(5001,json.classname _ " doesn't exist")
            set ^admin.migration(json.classname,"error","non existing class") = "" 
        }
        set json.imported = imported 
        set ^import(json.classname,json.ts,"imported") = $Get(^import.imported(json.classname,json.ts,"imported"),0) + json.imported
        set json.elapse = $zh-start 
        set ^admin.migration(json.classname,"import",$zdt($now(),3,,6)) = "imported:"_imported_" size:"_json.nbRecords_" (elapse:"_json.elapse_")" 
        do json.%ToJSON() 
    }
    Catch ex {
        set sc = ex.AsStatus()
    }
    return sc
}

ClassMethod importJSON() As %Status
{
    Try {
        set start = $zh 
        set sc = $$$OK
        set %response.ContentType = ..#CONTENTTYPEJSON
        set json = {} 
        set json.system = $SYSTEM
        set json.ts = $zdt($now(),3,,6)
        set payload = {}.%FromJSON(%request.Content) 
        set json.classname = payload.tablename 
        set json.init = payload.init 
        set imported = 0 
        set array = payload.data.%GetIterator() 
        set json.nbRecords = payload.data.%Size() 
        set json.parseError = [],json.saveError = [] 
        set ^import(json.classname,json.ts,"received") = $Get(^import.received(json.classname,json.ts,"received"),0) + json.nbRecords
        
        if ##class(%Dictionary.ClassDefinition).%ExistsId(json.classname) {
            set class = ##class(%Dictionary.ClassDefinition).%OpenId(json.classname)  
            set IdLocation = class.Storages.GetAt(1).IdLocation
            set DataLocation = class.Storages.GetAt(1).DataLocation
            set IndexLocation = class.Storages.GetAt(1).IndexLocation
            set StreamLocation = class.Storages.GetAt(1).StreamLocation
            set json.IdLocation = (IdLocation)
            if (json.init) { 
                kill @DataLocation,@IndexLocation,@StreamLocation 
            }
            
            while array.%GetNext(.key,.value) { 
                set a=$CLASSMETHOD(json.classname,"%New") 
                set ID = $INCREMENT(^admin.migration(json.classname))
                set parseOK=a.%JSONImport(value)    
                if 'parseOK { 
                set parseError = {}
                set parseError.error = $system.Status.GetErrorText(parseOK)
                set parseError.key = (key) 
                set ^admin.migration(json.classname,"parse error",$zdt($now(),3,,6)) = parseError.error 
                do json.parseError.%Push(parseError) 
            } 
                set saveOK = a.%Save() 
                if 'saveOK { 
                    set saveError = {}
                    set saveError.key = (key)
                    set saveError.error = ($system.Status.GetErrorText(saveOK)) 
                    set ^admin.migration(json.classname,"save error",ID) = saveError.error 
                    do json.saveError.%Push(saveError) 
                } else {
                    set imported=$INCREMENT(imported) 
                }
            }

        } else {
            set sc = $SYSTEM.Status.Error(5001,json.classname _ " doesn't exist")
            set ^admin.migration(json.classname,"error","non existing class") = "" 
        }
        set json.imported = imported 
        set ^import(json.classname,json.ts,"imported") = $Get(^import.imported(json.classname,json.ts,"imported"),0) + json.imported
        set json.elapse = $zh-start 
        set ^admin.migration(json.classname,"import",$zdt($now(),3,,6)) = "imported:"_imported_" size:"_json.nbRecords_" (elapse:"_json.elapse_")" 
        do json.%ToJSON() 
    }
    Catch ex {
        set sc = ex.AsStatus()
    }
    return sc
}

ClassMethod importXML() As %Status
{
    Try {
        zn ..#IMPORTDESTINATION
        set start = $zh 
        set sc = $$$OK
        set %response.ContentType = ..#CONTENTTYPEJSON
        set json = {} 
        set json.system = $SYSTEM
        set json.ts = $zdt($now(),3,,6)
        set payload = %request.Content 

        set content = ##class(%ArrayOfDataTypes).%New()
        #; do content.SetAt(%request.CgiEnvs("SERVER_ADDR"),"SERVER_ADDR")
        #; do content.SetAt(%request.CgiEnvs("REMOTE_ADDR"),"REMOTE_ADDR")
        #; do content.SetAt(%request.CgiEnvs("SERVER_SOFTWARE"),"SERVER_SOFTWARE")
        #; do content.SetAt(%request.CgiEnvs("HTTP_HOST"),"HTTP_HOST")
        #; do content.SetAt(%request.CgiEnvs("HTTP_USER_AGENT") ,"HTTP_USER_AGENT")
        do content.SetAt(%request.Content.Size ,"CONTENT SIZE")
        do ##class(common.trace).log("0-HTTP REQUEST",$this,"import XML",content)
        set imported = 0 
        set errors = 0 
        set reader = ##class(%XML.Reader).%New()
        set status = reader.OpenStream(payload)
        set json.parseError = [],json.saveError = [] 
        set firstNode = reader.Document.GetDocumentElement().NodeData 
        set json.firstNode = firstNode
        set classname = "undefined"
        if firstNode [ "-" {
            set classname = $PIECE(firstNode,"-",2)
            set json.classname = classname
            if ##class(%Dictionary.ClassDefinition).%ExistsId(classname) {
                set class = ##class(%Dictionary.ClassDefinition).%OpenId(classname)
                set IDPROPERTY = ""
                for p = 1 : 1 : class.Parameters.Count() {
                    if class.Parameters.GetAt(p).Name = "IDPROPERTY" {
                        set IDPROPERTY = class.Parameters.GetAt(p).Default
                    }
                }
                if IDPROPERTY '= "" {
                    do reader.Correlate(classname,classname)
                    while reader.Next(.a,.status) {
                        if $ISOBJECT(a) {
                            if a.%IsA(classname) {
                                set sc = a.%Save()
                                if sc {
                                    set imported = $INCREMENT(imported)
                                } else {
                                    set %response.Status = "422 - SAVE ERROR " _ $system.Status.GetErrorCodes(sc)
                                    set errors = $INCREMENT(errors)
                                    set saveError = {}
                                    set saveError.error = ($system.Status.GetErrorText(sc) _ " (" _ IDPROPERTY _ ":" _ $PROPERTY(a,IDPROPERTY) _ ")") 
                                    #; set ^admin.migration(classname,"save error",$PROPERTY(a,IDPROPERTY)) = saveError.error 
                                    
                                    set content = ##class(%ArrayOfDataTypes).%New()
                                    for i = 1 : 1 : class.Properties.Count() {
                                        set propertyName = class.Properties.GetAt(i).Name
                                        if class.Properties.GetAt(i).Type [ "%Stream."
                                        {
                                            set contentText = "Size:" _ $PROPERTY($PROPERTY(a,propertyName),"Size") _ " - Content:" _ $METHOD($PROPERTY(a,propertyName),"Read")
                                            
                                        } 
                                        elseif class.Properties.GetAt(i).Type = "%Date"
                                        {
                                            set contentText = $zdt($PROPERTY(a,propertyName),3)
                                        }
                                        #; elseif class.Properties.GetAt(i).Type = "%TimeStamp"  {
                                        #;     set contentText = $tr($PROPERTY(a,propertyName),"TZ"," ")
                                        #; }
                                        else {
                                            set contentText = $PROPERTY(a,propertyName)
                                        }
                                        do content.SetAt(contentText,propertyName)
                                    }
                                    do ##class(common.trace).log(classname,"save error",saveError.error,content)
                                    do json.saveError.%Push(saveError) 
                                }
                            } else {
                                set %response.Status = "422 - Mapping Error"
                                set msg = "erreur lors du mapping"
                                set sc = $SYSTEM.Status.Error(5001,msg)
                                #; set ^admin.migration(classname,"error",msg) = $zdt($h,3) 
                                do ##class(common.trace).log(classname,"error",msg)
                                set saveError = {}
                                set saveError.error = "erreur lors du mapping"
                                do json.saveError.%Push(saveError)
                            }
                        } else {
                            set %response.Status = "422 - Correlate Error"
                            set saveError = {}
                            set saveError.error = "erreur lors du Correlate"
                            set sc = $SYSTEM.Status.Error(5001,msg)
                            #; set ^admin.migration(classname,"error",msg) = $zdt($h,3) 
                            do ##class(common.trace).log(classname,"error",msg)
                            do json.saveError.%Push(saveError)
                        }
                    }
                } else {
                    set %response.Status = "422 - no IDPROPERTY"
                    set msg = classname _ " n'a pas de paramètre IDPROPERTY"
                    set sc = $SYSTEM.Status.Error(5001,msg)
                    #; set ^admin.migration(classname,"error",msg) = $zdt($h,3) 
                    do ##class(common.trace).log(classname,"error",msg)
                }
            } else {
                set %response.Status = "422 - " _ classname _ " does not exist"
                set msg = classname _ " n'existe pas"
                set sc = $SYSTEM.Status.Error(5001,msg)
                #; set ^admin.migration(classname,"error",msg) = $zdt($h,3)
                do ##class(common.trace).log(classname,"error",msg)
            }
        } else {
            set %response.Status = "422 - first node unrecognized"
            set msg = "le premier élément <" _ firstNode _ "> doit être de la forme <tablename-Package.ClassName>"
            set sc = $SYSTEM.Status.Error(5001,msg)
            #; set ^admin.migration("error",msg,$zdt($h,3)) = firstNode
            do ##class(common.trace).log(classname,"error",msg)
        }   
        set json.imported = imported 
        set json.elapse = $zh-start 
        #; set ^admin.migration(json.classname,"import",$zdt($now(),3,,6)) = "imported:"_imported_" (elapse:"_json.elapse_")" 
        set msg = "imported:"_imported_" (elapse:"_json.elapse_")"
        
        set content = ##class(%ArrayOfDataTypes).%New()
        do content.SetAt(imported ,"IMPORTED")
        do content.SetAt(json.elapse ,"ELAPSE")
        do content.SetAt(errors ,"ERRORS")
        do ##class(common.trace).log("0-HTTP REQUEST",$this,"import XML",content)
        do ##class(common.trace).log(classname,"import",msg,content)


        do json.%ToJSON() 
    }
    Catch ex {
        set sc = ex.AsStatus()
        set %response.Status = "422 - EXCEPTION " _ $SYSTEM.Status.GetErrorCodes(sc)
        set content = ##class(%ArrayOfDataTypes).%New()
        do content.SetAt(payload.Read(100) ,"PAYLOAD")
        do ##class(common.trace).log("EXCEPTION","error",$SYSTEM.Status.GetErrorText(sc),content)
    }
    return sc
}

ClassMethod import() As %Status
{
    Try {
        set start = $zh 
        set sc = $$$OK
        set %response.ContentType= ..#CONTENTTYPEJSON
        set json = {} 
        set json.system = $SYSTEM
        set json.ts = $zdt($now(),3,,6)
        set payload = {}.%FromJSON(%request.Content) 
        set json.classname=payload.tablename 
        set json.init = payload.init 
        set imported = 0 
        set array = payload.data.%GetIterator() 
        set json.nbRecords=payload.data.%Size() 
        set json.parseError=[],json.saveError=[] 
        set ^import(json.classname,json.ts,"received") = $Get(^import.received(json.classname,json.ts,"received"),0) + json.nbRecords
        if ##class(%Dictionary.ClassDefinition).%ExistsId(json.classname) {
            set class = ##class(%Dictionary.ClassDefinition).%OpenId(json.classname)  
            set IdLocation = class.Storages.GetAt(1).IdLocation
            set DataLocation = class.Storages.GetAt(1).DataLocation
            set IndexLocation = class.Storages.GetAt(1).IndexLocation
            set StreamLocation = class.Storages.GetAt(1).StreamLocation
            set json.IdLocation=(IdLocation)
            if (json.init) { 
                kill @DataLocation,@IndexLocation,@StreamLocation 
            }
            
            while array.%GetNext(.key,.value) { 
                set a =$CLASSMETHOD(json.classname,"%New") 
                set ID = $INCREMENT(^admin.migration(json.classname))
                #; set parseOK=a.%JSONImport(value) 
                set tmp = ##class(%Stream.GlobalBinary).%New()
                do value.%ToJSON(tmp)
                do tmp.Rewind()
                set x = {}.%FromJSON(tmp.ReadLineIntoStream())

                for i = 1 : 1 : class.Properties.Count() {
                    set propertyName = class.Properties.GetAt(i).Name
                    if x.%IsDefined(propertyName) {
                        if 'class.Properties.GetAt(i).Calculated {
                            if class.Properties.GetAt(i).Type [ "%Stream." {
                                if x.%Get(propertyName,,"stream").Size > 0 {
                                    set ^admin.migration(json.classname,ID,propertyName,x.%Get(propertyName,,"stream").Size) =  x.%Get(propertyName,,"stream").Read(100)
                                    if class.Properties.GetAt(i).Type = "%Stream.GlobalBinary" {
                                        set tmp = ##class(%Stream.GlobalBinary).%New()
                                        do tmp.CopyFrom(x.%Get(propertyName,,"stream"))
                                        do tmp.Rewind() 
                                        while 'tmp.AtEnd {
                                            do $METHOD($PROPERTY(a,propertyName),"Write",$system.Encryption.Base64Decode(tmp.Read()))
                                        }
                                    } 
                                    if class.Properties.GetAt(i).Type = "%Stream.GlobalCharacter" {
                                        do $METHOD($PROPERTY(a,propertyName),"CopyFrom",x.%Get(propertyName,,"stream"))
                                    }
                                }
                            } else {
                                if class.Properties.GetAt(i).Type = "%Date"  {
                                    if x.%Get(propertyName) '= "" {
                                        set ^admin.migration(json.classname,ID,propertyName) = x.%Get(propertyName)
                                        set $PROPERTY(a,propertyName) = $zdh(x.%Get(propertyName),3)
                                    }
                                } elseif class.Properties.GetAt(i).Type = "%TimeStamp"  {
                                    if x.%Get(propertyName) '= "" {
                                    set ^admin.migration(json.classname,ID,propertyName) = x.%Get(propertyName)
                                    set $PROPERTY(a,propertyName) = $tr(x.%Get(propertyName),"TZ"," ")
                                    }
                                } else {
                                    set ^admin.migration(json.classname,ID,propertyName) = x.%Get(propertyName)
                                    set $PROPERTY(a,propertyName) = x.%Get(propertyName)
                                }
                            }  
                        }
                    }
                }
                set saveOK = a.%Save() 
                if 'saveOK { 
                    set saveError = {}
                    set saveError.key = (key)
                    set saveError.error = ($system.Status.GetErrorText(saveOK)) 
                    set ^admin.migration(json.classname,"save error",ID) = saveError.error 
                    do json.saveError.%Push(saveError) 
                } else {
                    set imported = $INCREMENT(imported) 
                }
            }

        } else {
            set sc = $SYSTEM.Status.Error(5001,json.classname _ " doesn't exist")
            set ^admin.migration(json.classname,"error","non existing class") = "" 
        }
        set json.imported = imported 
        set ^import(json.classname,json.ts,"imported") = $Get(^import.imported(json.classname,json.ts,"imported"),0) + json.imported
        set json.elapse = $zh-start 
        set ^admin.migration(json.classname,"import",$zdt($now(),3,,6)) = "imported:"_imported_" size:"_json.nbRecords_" (elapse:"_json.elapse_")" 
        do json.%ToJSON() 
    }
    Catch ex {
        set sc = ex.AsStatus()
    }
    return sc
}

ClassMethod kill(classname As %String) As %Status
{
    set start = $zh
    set sc = $$$OK,ts = $zdt($now(),3,,6)
    set %response.ContentType = ..#CONTENTTYPEJSON
    set json = {}
    set json.classname = classname
    set json.status = $CLASSMETHOD(classname,"%KillExtent")
    set json.elapse = $zh-start
    set ^admin.migration(classname,ts,"killed") = json.status_" (elapse:"_json.elapse_")"
    do json.%ToJSON()
    return sc
}

ClassMethod pop(classname As %String, nb As %String) As %Status
{
    set start = $zh
    set sc = $$$OK
    set %response.ContentType = ..#CONTENTTYPEJSON
    set json = {}
    set json.classname = classname
    set json.nb=nb
    set json.inserted = $CLASSMETHOD(classname,"Populate",nb)
    set json.elapse = $zh-start
    do json.%ToJSON()
    return sc
}

ClassMethod add() As %Status
{
    set start = $zh
    set sc = $$$OK
    set %response.ContentType = ..#CONTENTTYPEJSON
    set payload = {}.%FromJSON(%request.Content)
    set json = {}
    set json.filename = payload.filename
    set sc = ##class(data.test).add(payload.filename)
    set json.sc = (sc)
    set json.elapse = $zh-start
    do json.%ToJSON()
    return sc
}

ClassMethod nb(classname As %String) As %Status
{
    set start = $zh
    set sc = $$$OK
    set %response.ContentType = ..#CONTENTTYPEJSON
    set json = {}
    set json.classname = classname
    set class = ##class(%Dictionary.CompiledClass).%OpenId(classname)
    set json.tableName = class.SqlSchemaName_"."_class.SqlTableName
    set tStatement = ##class(%SQL.Statement).%New(1) 
    set sql = 2
    set sql(1) = "select count(*)" 
    set sql(2) = "from "_json.tableName
    set sc = tStatement.%Prepare(.sql) 
    set result = tStatement.%Execute() 
    if 'result.%SQLCODE {  
        do result.%Next()
        set json.nb=result.%GetData(1)
    }
    set json.elapse=$zh-start
    do json.%ToJSON()
    return sc
}

ClassMethod exportById(classname As %String, format As %String, id As %String) As %Status
{
    set start = $zh
    set sc = $$$OK
    set sc = ..listTop(classname,format,id,id)
    return sc
}

ClassMethod list(classname As %String, format As %String) As %Status
{
    set sc = $$$OK
    set %response.ContentType = ..#CONTENTTYPEJSON
    set json = {}
    Try {
    if ##class(%Dictionary.ClassDefinition).%ExistsId(classname) {
        set class = ##class(%Dictionary.ClassDefinition).%OpenId(classname)
        set tableName = class.SqlTableName
        set:tableName="" tableName = classname
        set sql = "select count(*) from " _ tableName
        set result = ##class(%SQL.Statement).%ExecDirect(,sql)
        if result.%SQLCODE = 0 {
            do result.%Next() 
            set max = result.%GetData(1)
            set sc = ..listTop(classname,format,0,max)
        } else {
            set json.SQLCODE = (result.%SQLCODE) 
            set json.Message = (result.%Message) 
            do json.%ToJSON()
        }
    } else {
        set json.error = classname _ " doesn't exist"
        do json.%ToJSON()
    }
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    return sc
}

ClassMethod listTop(classname As %String, format As %String, min As %Integer, max As %Integer) As %Status
{
    set start=$zh
    set sc = $$$OK,i = min
    set %response.ContentType = ..#CONTENTTYPEJSON
    if min > max {
        set json = {"ERROR":(min _ ">" _max)}
        do json.%ToJSON()
    } else {
        set format = $zcvt(format,"L")
        if format = "json" {
            set %response.ContentType = ..#CONTENTTYPEJSON
            if min > max {
                set json = {"ERROR":(min _ ">" _max)}
            } else {
                #; set json = {"tablename": (classname)}
                #; set json.data = []
                set json=[]
                while i <= max { 
                    if $CLASSMETHOD(classname,"%ExistsId",i) {
                        set a = $CLASSMETHOD(classname,"%OpenId",i)
                        if $ISOBJECT(a) {
                            set sc = a.%JSONExportToStream(.str)
                            #; do json.data.%Push({}.%FromJSON(str))
                            do json.%Push({}.%FromJSON(str))
                        }
                    }
                    do $INCREMENT(i)
                } 
            }
            write ""
            do json.%ToJSON()
        }
        if format = "xml" {
            set %response.ContentType = ..#CONTENTTYPETEXT
            set writer=##class(%XML.Writer).%New()
            set writer.Charset="UTF-8"
            set sc=writer.RootElement("tablename-"_classname)
            while i <= max { 
                if $CLASSMETHOD(classname,"%ExistsId",i) {
                    set a = $CLASSMETHOD(classname,"%OpenId",i)
                    if $ISOBJECT(a) {
                        set sc=writer.Object(a,classname)
                    }
                }
                do $INCREMENT(i)
            }
            set sc = writer.EndRootElement()
        }
        if format = "csv" {
            set %response.ContentType = ..#CONTENTTYPETEXT
            set class = ##class(%Dictionary.ClassDefinition).%OpenId(classname)

            set header = "ID;"
            for h = 1 : 1 : class.Properties.Count() {
                set propertyName = class.Properties.GetAt(h).Name 
                set header = header _ propertyName
                if h < class.Properties.Count() {
                        set header = header _ ";"
                    }
            }
            write header,!
            while i <= max { 
                if $CLASSMETHOD(classname,"%ExistsId",i) {
                    set a = $CLASSMETHOD(classname,"%OpenId",i)
                    set line = i _ ";"
                    if $ISOBJECT(a) {
                        for l = 1 : 1 : class.Properties.Count() {
                            set propertyName = class.Properties.GetAt(l).Name
                            if class.Properties.GetAt(l).Type = "%Date"  {
                                set line = line _ $zd($PROPERTY(a,propertyName),4)
                            } else {
                                set line = line _ $PROPERTY(a,propertyName) 
                            }
                            if l < class.Properties.Count() {
                                set line = line _ ";"
                            }
                            
                        }
                    write line,!
                    }
                }
                do $INCREMENT(i)
            }
        }
    }
    return $$$OK
}

ClassMethod version() As %Status
{
    set sc = $$$OK
    set %response.ContentType = ..#CONTENTTYPEJSON
    set json = {}
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
    #; set json.XYZ = (%request.CgiEnvs("HTTP_XYZ"))
    set json.CgiEnvsContentType = (%request.CgiEnvs("CONTENT_TYPE"))
    set json.ContentType = (%request.ContentType)
    do json.%ToJSON()
    #; write "Hello "_$USERNAME
    return sc
}

ClassMethod stream(classname As %String, property As %String, id As %Integer) As %Status
{
    if $CLASSMETHOD(classname,"%ExistsId",id) {
        set data = $CLASSMETHOD(classname,"%OpenId",id)
        if $ISOBJECT(data) {
            set stream = $PROPERTY(data,property)
            set %response.ContentType = ..#CONTENTTYPEOCTETSTREAM
            if classname = "data.test" {
                if property = "BStream" {
                    set extension = $PROPERTY(data,"extension") 
                    if extension = "svg" {
                        set %response.ContentType = ..#CONTENTTYPESVG 
                    } 
                    if extension = "pdf" {
                        set %response.ContentType = ..#CONTENTTYPEPDF 
                    } 
                    if extension = "gif" {
                        set %response.ContentType = ..#CONTENTTYPEGIF 
                    }
                } 
                if property = "CStream" {
                    set %response.ContentType = ..#CONTENTTYPETEXT
                }
            }
            set sc = $METHOD(stream,"OutputToDevice")
        }
    } else {
        set sc = $SYSTEM.Status.Error(5001,id_" doesn't exist")
    }
    set %response.Status=200
    return sc
}

ClassMethod service() As %Status
{
 try {
	set sc=$$$OK
	set %response.ContentType="application/json"

	set payload=%request.Content

	set tSC=##class(Ens.Director).CreateBusinessService("from personnes REST",.tService)

	set request=##class(formation.RM.personne.Record).%New()
    #; set request = ##class(NomProjet.RM.personne.Record).%New()
	set sc = request.%JSONImport(payload.Read())

    set retour={}
    

    if 'sc {
         set retour.importJSON = ($system.Status.GetErrorText(sc))
    } else {

        set sc=tService.ProcessInput(request,.response)

        #dim response as formation.msg.mysql.response.personne
        
        if $ISOBJECT(response) {
            if 'response.status {
                set retour.status = ($system.Status.GetErrorText(response.status))
            } else {
                set retour.status = "OK"
            }
            if response.inserted {
                set retour.action = "inserted"
            } 
            if response.updated {
                set retour.action = "updated"
            } 
        } else {
            set retour.action = "processed"

        }
    }
    set retour.ts=($zdt($h,3))
	write retour.%ToJSON()
	} catch e {
		throw e
	}
	return sc
}

ClassMethod file(filename As %String) As %Status
{
    Try {
        set start = $zh 
        set sc = $$$OK
        set %response.ContentType = ..#CONTENTTYPEJSON
        set json = {} 
        set json.system = ($SYSTEM)
        set json.filename = (filename)
        set json.ts = ($zdt($now(),3,,6))
        set payload = %request.Content

        set directory = "/data/patient/test/"
        set file = ##class(%File).%New(directory _ filename)
        set sc = file.Open("WSN")
        do file.CopyFrom(payload)

        do file.Close()


        do json.%ToJSON() 
    }
    Catch ex {
        set sc = ex.AsStatus()
    }
    return sc
}

ClassMethod spec() As %Status
{
  Set tSC = ##class(%REST.API).GetWebRESTApplication($NAMESPACE, %request.Application, .swagger)
  Do swagger.info.%Remove("x-ISC_Namespace")
  Set swagger.basePath = "/common"
  Set swagger.info.title = "InterSystems IRIS COMMON"
  Set swagger.info.version = "0.1"
  Set swagger.host = "localhost:52773"
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
