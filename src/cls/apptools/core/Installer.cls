Include apptools.core

/// Importing this class will install App Tools properly.
/// fork from WebTerminal 
Class apptools.core.Installer Extends %Projection.AbstractProjection [ DependsOn = apptools.core.msg ]
{

Parameter DispatchClass = "apptools.core.rest";

Parameter ResourceName = "%apptools";

Parameter RoleName = "apptools";

Parameter AppRest = "apptoolsrest";

Parameter AppCSP = "apptools";

Parameter AppName = "apptools";

Projection Reference As Installer;

Parameter VERSION = 1.0;

/// This method is invoked when a class is compiled.
///  d ##class(apptools.core.Installer).CreateProjection()
ClassMethod CreateProjection(cls As %String, ByRef params) As %Status
{
	new $Namespace
	set ns = $Namespace // ought to be package home namespace!
	if $g(@$$$GNEnsConf@("HomeNamespace"))'="",$g(@$$$GNEnsConf@("HomeNamespace"))'=ns {
		QUIT $$$OK
	}
	if $g(@$$$GNEnsConf@("HomeNamespace"))="" {
	;Filling the global default values
	 set @$$$GNEnsConf@("EMAILAUTH")="user_from_send_mail@server.com"
	 set @$$$GNEnsConf@("EMAILAUTHPASS")="some_password"
	 set @$$$GNEnsConf@("EMAILSERVERIP")="127.0.0.1"
	 set @$$$GNEnsConf@("EMAILSERVERPORT")=25
	 set @$$$GNEnsConf@("EMAILSUPPORT")="user_to_send_mail@server.com"
	 set @$$$GNEnsConf@("EMAILXLSPATH")=##class(%File).GetDirectory(##class(%File).TempFilename())
	 set @$$$GNEnsConf@("EXPORTPROJPATH")=^("EMAILXLSPATH")
	 set @$$$GNEnsConf@("Language")="en"
	 set @$$$GNEnsConf@("PATHCSP")="/"_..#AppCSP_"/"
	 ;set @$$$GNEnsConf@("EnsProductStatusRun")="Run" 
			
	}
    set @$$$GNEnsConf@("HomeNamespace") = ns
    write !, "Installing "_..#AppName_" application to " _ ns
    set dbdir = $$$defdir
    $$$NspGoto(curNs,"%SYS")
    try {
        set $Namespace = "%SYS"
    } catch (e) {
        set mes = "<PROTECT> The user " _ $Username _ " has no privileges"
            _ " to enter the %SYS namespace. Please, log in as a privileged user"
            _ " to set up the "_..#AppName_" application."
        set err = $$$ERROR($$$GeneralError, mes)
        write !, mes
        return err
    }

   	set result=##CLASS(%ResultSet).%New("%DynamicQuery:SQL")
	set tSC=result.Prepare("select * FROM Security.Applications where Name=?")
	set:tSC tSC=result.Execute("/csp/"_ns)
	if '$$$ISOK(tSC) {
		set text="Error application :"_$SYSTEM.Status.GetErrorText(tSC)  w !,text QUIT $$$ERROR(text)
	}
	else {
		while result.Next() {
			set cspProperties("Path")=result.Data("Path")
		}
	}
	if ns="IRISAPP" set cspProperties("Path")="/opt/irisapp/web/",IsNameSpaceDefault=1 ;Docker
    if '$data(cspProperties("Path")) {
	    set tempdir=$p($zu(12),$$$slash,1,*-2)_$$$slash_$s($zversion(1)=3:"csp",1:"CSP")_$$$slash_ns
		write !,"Create directory ",tempdir
		set st=##class(%File).CreateDirectory(tempdir)
		if 'st w !,"Error creating directory " ; quit $$$OK
	    set cspProperties("Path")=tempdir
    }
    set cspProperties("AutheEnabled") = $$$AutheCache ;$$$AutheUnauthenticated ;
    set cspProperties("NameSpace") = ns
    set cspProperties("Description") = "A WEB application for "_..#AppName_"."
    set cspProperties("IsNameSpaceDefault") = +$GET(IsNameSpaceDefault)
    set st = ..RegisterWebApplication("/"_..#AppCSP, .cspProperties)
    return:$$$ISERR(st) st
    
 
	set @$$$GNEnsConf@("CSP-Path")=cspProperties("Path")
	KILL cspProperties("Path")
	
    set cspProperties("AutheEnabled") = $$$AutheCache ;$$$AutheUnauthenticated
    set cspProperties("NameSpace") = ns
    set cspProperties("Description") = "A WEB application for "_..#AppName_"."
    set cspProperties("IsNameSpaceDefault") = $$$NO
    set cspProperties("DispatchClass") = ..#DispatchClass
    set st = ..RegisterWebApplication("/"_..#AppRest, .cspProperties)
    return:$$$ISERR(st) st
  	set @$$$GNEnsConf@("PATHCSP")="/"_..#AppCSP_"/"
    
    do ..CreateAllNamespace()
    
    write !, "Mapping "_..#AppName_" package into all namespaces:"
    set st = ..Map(ns,..#AppName)
    if ($$$ISERR(st)) {
        do $System.Status.DisplayError(st)
    } else {
	    write !, ""_..#AppName_" package successfully mapped into all namespaces."
    }

    if (##class(Security.Resources).Exists(..#ResourceName) = 0) {
        set st = ##class(Security.Resources).Create(..#ResourceName,
            "Grants access to "_..#AppName_" if set up.", "")
    }

    if (##class(Security.Roles).Exists(..#RoleName) = 0) {
        set st = ##class(Security.Roles).Create(..#RoleName,
            "AppTools user role which may grant access to /"_..#AppCSP_" application if set up.",
            ..#ResourceName_":RWU")
    }
	do ..AddExtentions()
	do ..AddFavorites()
	$$$NspReturn(curNs)
    return st
}

/// Add Extentions
/// do ##class(apptools.core.Installer).AddExtentions()
ClassMethod AddExtentions() As %Status
{
	// @$$$GNExtentions@( Namespace , FavoriteNode , Description )
	 for prep="tmp","log" {
	 	set @$$$GNExtentions@("%All","ShowGlobals^"_prep_"**","Desc")="ShowGlobals ^"_prep_"**"
	 	set ^("Xecute")="xec do ##class(apptools.core.Production).ShowGlobals(""^"_prep_"**"",##class(apptools.core.sys).ListNS(.info,""NotPre,Ens""))"
	 }
 	set @$$$GNExtentions@("%All","FindAndDrawAllQueue","Desc")="Watch all queues"
 	set ^("Xecute")="xec do ##class(apptools.core.Production).FindAndDrawAllQueue(##class(apptools.core.sys).ListNS(.info,""NotPre,Ens""))"

	 set @$$$GNExtentions@("%All","FindAndDrawAllErr","Desc")="Sample extension for all namespaces. Monitoring products in all namespaces with rapid transition to visual tracing"
	 set ^("Xecute")="xec d ##class(apptools.core.Production).FindAndDrawAllErr(""Select * from Ens_Util.Log where Type='2' and TimeLogged>'""_$zd($h-1,3)_"" 21:00' order by id desc"",##class(apptools.core.sys).ListNS(.info,""NotPre,Ens""))"
	 set @$$$GNExtentions@("DOCBOOK","Query DocBook.articl","Desc")=$lb("Sample extension for DOCBOOK namespaces. Query DocBook.articl")
	 set ^("Xecute")="select * From DocBook.article"
}

/// Add Favorites
/// do ##class(apptools.core.Installer).AddFavorites()
ClassMethod AddFavorites() As %Status
{
	new $namespace
	set $namespace="%SYS"
	set Status=##Class(Config.Startup).Get(.Properties)
	if Status s ServerPort="http://"_$zu(110)_":"_$g(Properties("WebServerPort"),52773) write !
    do ..AddAndWriteFavorite(..#AppName,"/"_..#AppCSP_"/apptools.core.LogInfo.cls",$g(ServerPort))
    do ..AddAndWriteFavorite(..#AppName_" Permission Matrx","/"_..#AppCSP_"/apptools.Tabs.PanelUikitPermissMatrx.cls?autoload=Matrix",$g(ServerPort))
    do:$$$JSLibLocal ..AddAndWriteFavorite(..#AppName_" Samples Admin Panel","/"_..#AppCSP_"/apptools.Tabs.PanelUikitAdmin.cls?autoload=Matrix",$g(ServerPort))
    do:$$$JSLibLocal ..AddAndWriteFavorite(..#AppName_" REST service Admin Panel","/"_..#AppCSP_"rest/get-html/apptools.Tabs.PanelUikitAdmin.cls?autoload=Find",$g(ServerPort))
}

/// AddFavorite 
ClassMethod AddAndWriteFavorite(name As %String, url, ServerPort) As %Status
{
    Set tSC = ##class(%SYS.Portal.Users).%AddFavorite(name,url) 
    if ServerPort'="" write !,ServerPort_url
}

ClassMethod RegisterWebApplication(name As %String, spec) As %Status
{
    new $Namespace
    set $Namespace = "%SYS"
    set st = $$$OK
    if ('##class(Security.Applications).Exists(name)) {
        write !,"Creating WEB application """_name_"""..."
        set st = ##class(Security.Applications).Create(name, .spec)
        write !, "WEB application """_name_""" is created."
    } else { // ensure configuration matches in case of updating from old terminal versions
        write !, "Updating web application """_name_"""..."
        set st = ##class(Security.Applications).Modify(name, .spec)
        write !, "WEB application """_name_""" is updated."
    }
    return st
}

ClassMethod RemoveWebApplication(name As %String)
{
    new $Namespace
    set $Namespace = "%SYS"
    set st = $$$OK
    if (##class(Security.Applications).Exists(name)) {
        do ##class(Security.Applications).Get(name, .props)
        if (props("DispatchClass") '= ..#DispatchClass) && (name = "/"_..#AppCSP) {
            write !, "Won't delete WEB-application """_name_""" because it does not refer to dispatch class anymore."
        } else {
            write !, "Deleting WEB application """_name_"""..."
            set st = ##class(Security.Applications).Delete(name)
            write !, "WEB application """_name_""" was successfully deleted."
        }
    }
    return st
}

/// This method is invoked when a class is 'uncompiled'.
ClassMethod RemoveProjection(cls As %String, ByRef params, recompile As %Boolean) As %Status
{
	new $Namespace

	write:(recompile) !, "Recompiling "_..#AppName_", skipping the deletion..."
    return:(recompile) $$$OK

	set ns = $get(@$$$GNEnsConf@("HomeNamespace"), $Namespace)
    write !, "Uninstalling "_..#AppName_" application from ", ns
    zn "%SYS"
    set st = ..RemoveWebApplication("/"_..#AppCSP)
    return:($$$ISERR(st)) st
    
    set st = ..RemoveWebApplication("/"_..#AppRest)
    return:($$$ISERR(st)) st
    
    if (##class(Security.Resources).Exists(..#ResourceName) = 1) {
        set st = ##class(Security.Resources).Delete(..#ResourceName)
        return:($$$ISERR(st)) st
    }
    if (##class(Security.Roles).Exists(..#RoleName) = 1) {
        set st = ##class(Security.Roles).Delete(..#RoleName)
        return:($$$ISERR(st)) st
    }

    kill:st @$$$GNEnsConf
    write !, "Global "_$$$GNEnsConf_" removed."

    kill:st @$$$GNLang
    write !, "Global "_$$$GNLang_" removed."

    write !, "Unmapping App package from all namespaces:"
	set st = ..UnMap(ns,..#AppName)
    if ($$$ISERR(st)) {
        do $System.Status.DisplayError(st)
       
    } else {
	    write !, "Unmapping complete."
    }

    return st
}

ClassMethod CreateAllNamespace() As %Status
{
	new $Namespace
    set $Namespace = "%SYS"
	set ns = "%All"
	set st = $$$OK
	if ('##Class(Config.Namespaces).Exists(ns)) {

        if ($system.Version.GetISCProduct() >= 4) {
            set Properties("Globals") = "IRISTEMP"
            set Properties("Library") = "IRISLIB"
            set Properties("Routines") = "IRISTEMP"
            set Properties("SysGlobals") = "IRISSYS"
            set Properties("SysRoutines") = "IRISSYS"
            set Properties("TempGlobals") = "IRISTEMP"
        } else {
            set Properties("Globals") = "CACHETEMP"
            set Properties("Library") = "CACHELIB"
            set Properties("Routines") = "CACHETEMP"
            set Properties("SysGlobals") = "CACHESYS"
            set Properties("SysRoutines") = "CACHESYS"
            set Properties("TempGlobals") = "CACHETEMP"
        }
		
		set st = ##Class(Config.Namespaces).Create(ns, .Properties)
		if ($$$ISERR(st)) {
        	do $System.Status.DisplayError(st)
    	} else {
        	write !, "%All namespace is created."
    	}
	}
	return st
}

ClassMethod Map(fromNS = "", Packet) As %Status
{
	new $Namespace
    set $Namespace = "%SYS"
    set st = $$$OK

    set mapTo = $LISTBUILD("%All", "SAMPLES", "DOCBOOK")
    do ##Class(Config.Namespaces).Get(fromNS, .InstallNSProps)
    set Properties("Database") = $get(InstallNSProps("Routines"))
    set ptr = 0
    while $LISTNEXT(mapTo, ptr, namespace) {
        continue:(fromNS = namespace)
        continue:('##Class(Config.Namespaces).Exists(namespace))
        write " ", namespace
        if ('##Class(Config.MapPackages).Exists(namespace, Packet)) {
        	set st1 = ##Class(Config.MapPackages).Create(namespace, Packet, .Properties)
        }
        if ('##Class(Config.MapGlobals).Exists(namespace, Packet)) {
	        set st2 = ##Class(Config.MapGlobals).Create(namespace, Packet, .Properties)
        }
        set st = $$$ADDSC(st,$$$ADDSC($get(st1,$$$OK),$get(st2,$$$OK)))
    }
    return st
}

ClassMethod UnMap(fromNS As %String, Packet) As %Status
{
	new $Namespace
    set $Namespace = "%SYS"
    set st = $$$OK
    
	set mapTo = $LISTBUILD("%All", "SAMPLES", "DOCBOOK")
    set ptr = 0
    while $LISTNEXT(mapTo, ptr, namespace) {
	    continue:(fromNS = namespace)
	    continue:('##Class(Config.Namespaces).Exists(namespace))
        write " ", namespace
        if (##Class(Config.MapPackages).Exists(namespace, Packet)) {
        	set st1 = ##Class(Config.MapPackages).Delete(namespace, Packet, .Properties)
        }
        if (##Class(Config.MapGlobals).Exists(namespace, Packet)) {
	        set st2 = ##Class(Config.MapGlobals).Delete(namespace, Packet, .Properties)
        }
        set st = $$$ADDSC(st,$$$ADDSC($get(st1,$$$OK),$get(st2,$$$OK)))
    }
    return st
}

ClassMethod Ver() As %Status
{
	q "1.0.5"
}

}
