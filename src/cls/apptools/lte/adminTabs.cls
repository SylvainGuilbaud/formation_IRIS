Include apptools.core

/// The template GUI of the application selector and tabs on the basis jQueryUi, Uikit
Class apptools.lte.adminTabs Extends %CSP.Page [ ClassType = "", DependsOn = apptools.core.msg, ProcedureBlock ]
{

/// The application title
Parameter HeaderText = "AdminTabsApplication";

/// Global Name Store Referens files and id sessions
Parameter GNStore = "^%apptools.ui";

/// For Redirect 
Parameter PreLoad;

Parameter ToAdmin = "You need to contact <a target=_new href='https://github.com/SergeyMi37'> technical support.</a>";

Parameter AppRoles;

/// is there a right to work with this form
ClassMethod IsPermiss(role = "", userroles = {$roles}) As %Status
{
	if userroles["%All" quit $$$OK
	set st=""
	for i=1:1:$L(role,",") { continue:$P(role,",",i)=""
		if (","_userroles_",")[(","_$P(role,",",i)_",") set st=$$$OK quit
	}
	if 'st quit $$$ERROR($$$GeneralError,"Protect st="_st_"="_userroles_"="_role_"=")
	quit st
}

ClassMethod CheckPermiss(ByRef par) As %Status
{
 do ..GetAllApps(.opt)
 if '..IsPermiss(..#AppRoles) {
	set par("=Message-default=")="You are missing access rights. "_..#ToAdmin
 	set par("=Tab=")="Error"
 }
 elseif '$d(opt) {
	set par("=Message-default=")="You don't have a single menu item. "_..#ToAdmin
 	set par("=Tab=")="Message"
 }
 else {
	set par("=Message-default=")=" "
 	set par("=Tab=")=" "
 }
 quit $$$OK
}

ClassMethod CheckRoleMenu(ByRef opt) As %Status
{
	quit:$roles["%All" $$$OK
	set i="" for { set i=$Order(opt(i)) quit:i=""
		kill found
		if $GET(opt(i,"Roles"))'="" {
			set roles=$GET(opt(i,"Roles"))
			set found=..CheckRole(roles)
		}
		else { set found=1
		}
		if '$GET(found) KILL opt(i)
	}
	quit $$$OK
}

ClassMethod CheckRole(roles) As %String
{
	for r=1:1:$l(roles,",") { continue:$p(roles,",",r)=""
		if (","_$roles_",")[(","_$p(roles,",",r)_",") set found=1 quit
	}
	quit +$GET(found)
}

/// Icon from png
ClassMethod GetAppIcon(path = "", ext = "", base64 = "") As %String
{
	if path'="" {
		quit "<link rel=""icon"" href="""_path_"."_ext_""" type=""image/x-"_ext_"""/><link rel=""shortcut icon"" href="""_path_"."_ext_""" type=""image/x-"_ext_"""/>"
	}
	elseif base64'="" {
		quit "<link rel=""icon"" type=""image/x-"_ext_""" href="""_base64_"""/>"		
	}
	else {
		;hammer gray
	   quit "<link rel=""icon"" type=""image/x-icon"" href="""_##class(apptools.core.rest).getStatic("apptools.Tabs.PanelUikit:IconTools")_"""/>"		
		; raisen
		;quit "<link rel=""icon"" type=""image/x-icon"" href=""data:image/x-icon;base64,AAABAAEAEBAAAAAAAABoBAAAFgAAACgAAAAQAAAAIAAAAAEAIAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8AJCQk/yQkJP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/0ZGRv8XFxf/////AP///wD///8A////AP///////////////+7u7v9OTk7/sbGx/11dXf9KSkr///////////+lpaX/4eHh/////wD///8A////AAAAAP8AAAD///////////+8vLz///////X19f/t7e3/gICA/5eXl////////////wAAAP8AAAD/////AKysrP8AAAD/AAAA/wAAAP+enp7/////////////////////////////////5OTk/wAAAP8AAAD/AAAA/6ysrP////8A////AP///wCurq6PlJSUzP///wD///8A////AP///wD///8A////AJSUlMyQkJDY////AP///wD///8A////AP///wD///8AAAAA/wAAAP////8A////AP///wD///8A////AP///wAAAAD/AAAA/////wD///8A////AP///wD///8AAAAA/wAAAP8AAAD/////AP///wD///8A////AP///wD///8AAAAA/wAAAP8AAAD/////AP///wD///8ACwsL/wAAAP8AAAD/lJSU2AAAAP8AAAD/cnJy/1hYWP8AAAD/AAAA/2FhYdgHBwf/AAAA/wAAAP////8A////AP///wD///8A////AP///wAAAAD/s7Oz/wAAAP8AAAD/x8fH/wAAAP////8A////AP///wD///8A////AP///wD///8A////AP///wAAAAD/AAAA/////wAAAAD/AAAA/////wAAAAD/AAAA/////wD///8A////AP///wD///8A////AP///wD///8AAAAA/wAAAP+qqqqlAAAA/wAAAP9lZWXjAAAA/wAAAP////8A////AP///wD///8A////AP///wD///8A////ALa2tv////8A9vb2UQAAAP8AAAD/////Uf///wDAwMD/////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wBcXFz/AAAA/////wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A//8AAP//AADAAwAAwAMAAIABAAAAAAAA5+cAAOfnAADH4wAAgAEAAPgfAADyTwAA8A8AAPZvAAD+fwAA//8AAA==""/>"
	}
}

/// Replace parameters
ClassMethod RepaceParameter(ByRef h, ByRef par) As %Status
{
 set url=par("input-cgivar")
 set path=par("=path=")
 set p=""
 for { set p=$Order(par(p)) quit:p=""
 	set h=$replace(h,p,par(p))
 }
 ;links 
 set linkjqueyuikit= ##class(apptools.core.LogInfoPane).GetLink()
 set linkjqueyuikit2= ##class(apptools.core.LogInfoPane).AddJsScripts() 
 set js= ..GetStringJs($namespace,..%ClassName(1),0)
 set h=$replace(h,"<!--=Links=-->",
 				linkjqueyuikit_$$$NL_
 				linkjqueyuikit2_$$$NL_
 				js_$$$NL
 	)
 set menu=..DrawMenu() ;sidebar
 set h=$replace(h,"<!-- =Sidebar Menu= -->",menu)
 set menuTop=..DrawMenuTop() ;top think
 set h=$replace(h,"<!-- =Item Dropdown Menu= -->",menuTop)
 if url["autoload=" set autoload=$p($p($p(url,"autoload=",2),"-"),"&")
 set js= ..GetStringJs($namespace,..%ClassName(1),1,$G(autoload))
  set h=$replace(h,"<!--=JS-Autoload=-->",js)
 quit $$$OK
}

ClassMethod GetStringJs(ns, cls, postload = 0, autoload = "") As %String
{
 set js=""
 if postload {
  set js=js_$$$NL_"<script language='javascript'>"_$$$NL
  set js=js_$$$NL_##class(apptools.core.Action).WriteActJs(%request,"","account_status",..%ClassName(1),"DrawStatus","")_$$$NL
 	set enter=##class(apptools.core.Action).WriteActJs(%request,"","MainHidden",..%ClassName(1),"ShowTab","&appPar=Search&Searchstr='+document.getElementById('searchstr').value")_$$$NL
 	set js=js_$$$NL_"$('#searchstr').keydown(function (e) { if (e.keyCode == 13) { "_enter_" }});"_$$$NL
 	set js=js_$$$NL_"$('#HideSideMenu').click();"_$$$NL
  	if autoload="" {
	 	do ..GetAllApps(.opt) 
	 	set i="" 
	 	for { set i=$o(opt(i)) q:i=""
	 		if $GET(opt(i,"Active")) set js=js_$$$NL_"$('#Menu"_opt(i,"id")_"').trigger('click');"_$$$NL
	 	}
 	} else {
	 	set js=js_$$$NL_"$('#Menu"_autoload_"').trigger('click');"_$$$NL
 	}
 	set js=js_$$$NL
  set js=js_$$$NL_"</script>"_$$$NL
 }
 else {
 	set js=js_$$$NL_##class(apptools.core.rest).getStatic("apptools.lte.adminStatic:AddJS")_$$$NL
 	set js=js_$$$NL_##class(apptools.core.rest).getStatic("apptools.lte.adminStatic:AddStyle")_$$$NL
 }
 quit js
}

/// what are the available modes
ClassMethod GetAllApps(opt) As %Status
{
	;----- Setup the search in the top menu
	s key="Search"
	s opt(key)="Search"
	s opt(key,"id")="Search-"
	s opt(key,"TabName")="Search"_"-"
	s opt(key,"ClassName")=..%ClassName(1)
	s opt(key,"Method")="ShowTabSearch"
	s opt(key,"TabMenu","Close")=1
	s opt(key,"TabMenu","Mode")=0 ;1 - for each new search bar to make new tab, 0-tab is always the same
}

/// Get a list of top-level menus to go to the product panel
/// set elem(1)="Productions",elem(2)="EventLogs" do ##class(apptools.lte.adminTabs).GetAppsProducts(.opt,2,.elem)
ClassMethod GetAppsProducts(ByRef opt, number = 2, ByRef elem) As %Status
{
	quit:$roles'["%All" $$$OK
	set nslist=##class(apptools.core.sys).ListNS(.info,"NotPre,Ens")
	set NS=""
	for { set NS=$o(info(NS)) quit:NS=""
		do ##class(apptools.lte.adminTabs).GetUrlProd(NS,.urls)
		for i=1:1 { quit:'$d(elem(i))
			set id=NS_"-"_elem(i)
			set key="menu-top-"_id
			do ..GetAppsOpenWinPanel(.opt,key, $g(urls(elem(i))), id ,$lb(number+i-1,elem(i)))
		}
	}
	quit $$$OK
}

/// Set opt panel
/// do ##class(apptools.lte.adminTabs).GetAppsProductPanel(.opt,key, url, id,LeftMenuName)
ClassMethod GetAppsOpenWinPanel(ByRef opt, key, url, id, LeftMenuName, csp = "csp") As %String
{
	set opt(key)=id
	set opt(key,"id")=id
	set opt(key,"TabName")=id
	set opt(key,"ClassName")=..%ClassName(1)
	set opt(key,"Method")="OpenNewWin"
	set opt(key,"InFrameUrl")=url
	set opt(key,"MenuTop")=LeftMenuName
	quit $$$OK
}

/// Get URL to go to the product panel
/// write ##class(apptools.lte.adminTabs).GetUrlProd("APP")
ClassMethod GetUrlProd(NS, ByRef urls, csp = "csp") As %String
{
	set ns=$zconvert(NS,"L")
	set urls("Productions")="/"_csp_"/"_ns_"/EnsPortal.ProductionConfig.zen?$NAMESPACE="_NS
	set urls("EventLogs")="/"_csp_"/"_ns_"/EnsPortal.EventLog.zen?$NAMESPACE="_NS
	set urls("Queues")="/"_csp_"/"_ns_"/EnsPortal.Queues.zen?$NAMESPACE="_NS
	set urls("SQL")="/csp/sys/exp/%25CSP.UI.Portal.SQL.Home.zen?$NAMESPACE="_NS
	set urls("GlobalList")="/csp/sys/exp/%25CSP.UI.Portal.GlobalList.zen?$NAMESPACE="_NS
	quit urls("Productions")
}

/// the rendering top menu 
ClassMethod DrawMenuTop(Par) As %String
{
	do ..GetAllApps(.opt) 
	do ..GetAllMenu(.opt,.menu,1)
	set m="",ret=""
	for { set m=$o(menu(m)) quit:m=""
		set i=""
		  set iditem="id_top_item"_m
		  if m=99 set iditem="account_status" //account - with submenu
		 s ret=ret_"<li class=""nav-item dropdown"">"_
        	"<a class=""nav-link"" data-toggle=""dropdown"" href=""#"">"_
          	 "<span id="""_iditem_""">"_$lg(menu(m),2)_"</span>"_
        	"</a>"_
        	"<div class=""dropdown-menu dropdown-menu-lg dropdown-menu-right"">"
			for { set i=$o(menu(m,i)) quit:i=""
				set ns=$GET(opt(i,"Namespace"))
				set onclick=##class(apptools.core.Action).WriteActJs(%request,"","MainHidden",..%ClassName(1),"ShowTab","&appPar="_i,ns)
				set ret=ret_
			     "<div class=""dropdown-divider""></div>"_
          		"<a href=""#"" class=""dropdown-item"" id='Menu"_$g(opt(i,"id"))_"' onclick="""_onclick_""">"_
           		 "<i class=""fas fa-file333 mr-2""></i>"_
            	 "<span class=""float-right text-muted text-sm"">"_$g(opt(i))_"</span>"_
          		"</a>"
			}
 			s ret=ret_ 
    	    	"</div>"_
	      	"</li>"
		}
	
  quit ret
}

/// render side menu 
ClassMethod DrawMenu(Par) As %String
{
	do ..GetAllApps(.opt) 
	do ..GetAllMenu(.opt,.menu)
	set m="",ret=""
	for { set m=$o(menu(m)) quit:m=""
		set i=""
		set icon=$select($lg(menu(m),4)'="":$lg(menu(m),4),1:"fa-copy")
		set active=$s($lg(menu(m),3):"menu-open",1:"")
		set ret=ret_
		"<li class=""nav-item "_active_""">"_
            "<a href=""#"" class=""nav-link"" >"_
              //"<i class=""nav-icon fas fa-chart-pie""></i>"_
              "<i class=""nav-icon fas "_icon_"""></i>"_
              "<p>"_$lg(menu(m),2)_
                "<i class=""right fas fa-angle-left""></i>"_
              "</p>"_
            "</a>"

		for { set i=$o(menu(m,i)) quit:i=""
			set ns=$GET(opt(i,"Namespace"))
			set Title=$GET(opt(i,"Title"),$g(opt(i)))
	   		set onclick=##class(apptools.core.Action).WriteActJs(%request,"","MainHidden",..%ClassName(1),"ShowTab","&appPar="_i,ns)
			set iconInem=$select($g(opt(i,"aw-icon"))'="":$g(opt(i,"aw-icon")),1:"fa-ellipsis-h")
		 	set ret=ret_	
			"<ul class=""nav nav-treeview"">"_
              "<li class=""nav-item"">"_
                "<a id='Menu"_$g(opt(i,"id"))_"' href=""#"" onclick="""_onclick_""" class=""nav-link""  title="""_Title_""">"_
                "<i class=""nav-icon fas "_iconInem_"""></i>"_
                			
                  "<p>"_$g(opt(i))_"</p>"_
                "</a>"_
              "</li>"_
            "</ul>"
			;set ret=ret_
			;	"<li><a id='Menu"_$g(opt(i,"id"))_
			;	"' href='#' onclick="""_onclick_""">"_
			;	$g(opt(i))_
			;	"</a></li>"
		}
		;s ret=ret_"</ul></li>"
	}
	set ret=ret_"</li>"
  quit ret
}

/// To obtain information on the support
ClassMethod GetSupportInfo() As %String
{
	set msg=$$$aText("Software complex to debug. Try to log in later, or contact tech support:","")
	quit msg_"Support info mailto: sergey.mikhaylenko@gmail.com"
}

/// To add to the form js code if development mode
ClassMethod IsDebugMode(mode = 0) As %Status
{
 if mode,'%request.Get("debug") { 
	$$$jsstart
	  write $$$blockui(..GetSupportInfo())
	$$$jsstop
  quit $$$OK
 }
	quit 0
}

/// rendering status of the user
ClassMethod DrawStatus(Par) As %Status
{
 set fio=##class(apptools.core.sys).GetFullName($username)
 set:fio="" fio=$$$aText("The user","")
 write "<span class='tip' title='"_fio_"-"_$roles_"-"_$zu(5)_"'>"_$username_" - "_fio_"</span>"
 quit $$$OK
}

/// To menu
ClassMethod GetAllMenu(opt, menu, top = 0) As %Status
{
 set i="" for { s i=$o(opt(i)) q:i=""
	if 'top,$d(opt(i,"Menu")) { 
		set m=$lg(opt(i,"Menu"),1)
		set:'$d(menu(m)) menu(m)=opt(i,"Menu")
		set menu(m,i)=""
	}
	if top,$d(opt(i,"MenuTop")) { 
		set m=$lg(opt(i,"MenuTop"),1)
		set:'$d(menu(m)) menu(m)=opt(i,"MenuTop")
		set menu(m,i)=""
	} else {
		;s:'$d(menu(99)) menu(99)=$lb(0,"---",0)
		;s menu(99,i)=""
	}
  }
}

/// drawing Tabs search
/// Par - code menu item from the GetAllApps ..
ClassMethod ShowTabSearch(key = "") As %Status
{
 ;do ..GetAllApps(.opt) 
 ;if $g(opt(key,"Disable")) write ..GetSupportInfo() quit $$$OK
 ;set NSpace=$zu(5)
 write $$$aText("Context","")_" :"_$g(key)
 ;set pref=$g(opt(key,"id"))
}

/// the render Tab on the menu
/// Par - code menu item from the GetAllApps ..
ClassMethod ShowTab(Par) As %Status
{
	zw Par
	if $g(Par("appPar"))'="" set Par=Par("appPar")
	w $zn
	zw Par
	do ..GetAllApps(.opt) 
	w $namespace
	zw opt ;debugwrite
	do ..ShowTabApps(.Par,.opt)
}

/// the render Tab on the menu
/// Par - code menu item from the GetAllApps ..
ClassMethod ShowTabApps(Par, opt) As %Status
{
	if Par="Search" {
		set Searchstr=$g(Par("%request.Data","Searchstr"),$GET(Par("Searchstr")))
		if Searchstr="" q $$$OK
		;s tr=$tr(##class(apptools.MSW.type).Transliteration(Searchstr)," №`()\/*;'"":%","_N---")
		;s tr=$tr($zts,".,") 
		set tr=$e($tr(Searchstr," №`()\/*;'"":%?$@&.,",""),1,20) 
		if '$e($g(opt(Par,"TabMenu","Mode")),2) set tr=tr_$i(@..#GNStore@("jobs",$j))
		set key=tr ;Searchstr
		MERGE opt(key)=opt(Par)
		set opt(key)=$GET(opt(key))_tr ;Searchstr
		if $e($g(opt(Par,"TabMenu","Mode")),1)=1 { ;mode add a new tab 
			set opt(key,"id")=opt(key,"id")_tr
		} else { ;mode add a new replace the old 
			set tabId="tab-"_opt(Par,"id")
			set tabIdMenu="tabMenu-"_opt(Par,"id")
			$$$jsstart
		  	 write "$('#"_tabId_"').remove();"
		  	 write "$('#"_tabIdMenu_"').remove();"
		  	$$$jsstop
		}
		s opt(key,"CGIvar")="&Searchstr="_Searchstr ;$zconvert(Searchstr,"O","URI")
		s opt(key,"TabName")=opt(key,"TabName")_tr 
		s Par=key

	}
	set tabId="tab-"_opt(Par,"id")
	set tabIdMenu="tabMenu-"_opt(Par,"id")
	if $g(opt(Par,"TabMenu","Close"))'="0" s IconMenu="<span class=""uk-margin-small-left uk-icon uk-close"" uk-icon=""close"" onclick=""$(\'#"_tabIdMenu_",#"_tabId_"\').remove();""></span>"
 	if $DATA(opt(Par,"TabMenu","Close"))>9 { //there are more points
 		;TODO
 	}
 	$$$jsstart
 	 if $g(opt(Par,"MethodUrlNewWin"))'="" {
	 	 if $g(opt(Par,"Disable")) { w "alert('"_$$$aText("Mode debugging","")_"');"}
	 	 else {write "window.open('"_$g(opt(Par,"MethodUrlNewWin"))_"','_blank');"
	 	 }
 	}
	else {
 	 write "if (!$('li').is('#"_tabId_"')) { $('.uk-active').removeClass('uk-active');"_$c(13,10)
 		write " $('#tabList').append('<li id="_tabId_"></li>');"_$c(13,10)
 		write " $('#tabMenu').append('<li id="_tabIdMenu_"><a><font color=Lightsteelblue>"_$g(opt(Par,"TabName"))_"</font>"_$g(IconMenu)_"</a></li>');"_$c(13,10)
 		write " $('#t1,#ta1').hide();"_$c(13,10) //" $('#t1').prop('disabled',true);"
 		set ns=$GET(opt(Par,"Namespace"))
 		if $GET(opt(Par,"Disable")) {
	 		;write "$('#"_tabId_"').load('apptools.core.Action.cls','appClass="_..%ClassName(1)_"&appMethod=ShowTabAbout&appNsp="_$zu(5)_"&appPar="_Par_"');"
	 		write ##class(apptools.core.Action).WriteActJs(%request,"",tabId,..%ClassName(1),"ShowTabAbout","&appPar="_Par_$g(opt(Par,"CGIvar")),ns)
 		}
 		elseif $g(opt(Par,"MethodUrl"))'="" {
	 		write "$('#"_tabId_"').load('"_$g(opt(Par,"MethodUrl"))_"');"
 		}
 		else {
	 		;write "$('#"_tabId_"').load('apptools.core.Action.cls','appClass="_$g(opt(Par,"ClassName"))_"&appMethod="_$g(opt(Par,"Method"))_"&appNsp="_$zu(5)_"&appPar="_Par_"');"
	 		write ##class(apptools.core.Action).WriteActJs(%request,"",tabId,$g(opt(Par,"ClassName")),$g(opt(Par,"Method")),"&appPar="_Par_$g(opt(Par,"CGIvar")),ns)
 		}
 	 write "};"
 	 write " UIkit.tab('#tabMenu').show($('#"_tabIdMenu_"'));"
	}
	$$$jsstop
}

/// Return in a single string
ClassMethod Logout(Par) As %Status
{
 if $g(Par("appPar"))'="" set Par=Par("appPar")
 do ##class(apptools.core.sys).logout()
 do ..GetAllApps(.opt) 
 $$$jsstart
 set i=""
 for { set i=$o(opt(i)) q:i=""
 	continue:i=Par
 	set tabId="tab-"_opt(i,"id")
	set tabIdMenu="tabMenu-"_opt(i,"id")
 	write "$('#"_tabIdMenu_",#"_tabId_"').remove();"
 }
 $$$jsstop
 set onclick = "top.document.location.reload();"
 &html<
 <br>
 <div class="uk-align-center uk-width-1-1 uk-margin-left uk-margin-right ">
	<div class="uk-alert-warning" uk-alert>
	<p>#($$$aText("The output of System produced",""))#</p>
	</div>
	<center>
		<button class="uk-button uk-button-primary uk-margin-small-right" type="button" onclick="#(onclick)#" >
		<span class="uk-margin-small-left uk-icon" uk-icon="sign-in">
		</span>#($$$aText("Login",""))#</button>
	</center>
</div>
>
 	quit $$$OK
}

/// The output of the First button
ClassMethod ButtonAgainOld(divId = "", key = "", text = "") As %Status
{
	//set onclick="$('#"_divId_"MainContent"_"').empty();"_##class(apptools.core.Action).WriteActJs(%request,divId_"MainForm",divId_"MainHeader",..%ClassName(1),divId_"FirstHead","&key="_key_"&divId="_divId)
	set onclick="$('#"_divId_"MainContent"_"').empty();"_
		$$$onclick(divId_"MainForm",divId_"MainHeader",$namespace,..%ClassName(1),divId_"FirstHead","&key="_key_"&divId="_divId)
	if text="" set text=$$$aText("Again","")
	quit $$$appButton("appButtonExit","onclick="""_$g(onclick)_"""",text)
}

/// The output of the First button
ClassMethod ButtonAgain(divId = "", key = "", text = "", metod = "", title = "") As %Status
{
	if metod="" set metod=divId
	set onclick="$('#"_divId_"MainContent"_"').empty();"_
		$$$onclick(divId_"MainForm",divId_"MainHeader",$namespace,..%ClassName(1),metod_"FirstHead","&key="_key_"&divId="_divId)
	if text="" set text=$$$aText("Again","")
	quit $$$appButton("appButtonExit",title_" onclick="""_$g(onclick)_"""",text)
}

/// the render Tab On the program"
/// Par - code menu item from the GetAllApps ..
ClassMethod ShowTabAbout(key = "") As %Status
{
	if $g(key("appPar"))'="" set key=key("appPar")
	do ..GetAllApps(.opt) 
	if $g(opt(key,"Disable")) write ..GetSupportInfo() quit $$$OK
	set divId=$g(opt(key,"id"))
	write ..#ToAdmin
	write "<br>Parameter key: "_key_"<br>Sample create custom tab"
	write $$$appText(divId_"nametab","","tabname")_" "
	set onclick=##class(apptools.core.Action).WriteActJs(%request,"","MainHidden",..%ClassName(1),"ShowTab","&appPar=Search&Searchstr='+$('#"_divId_"nametab"_"').val()")
	set %ui=1
	write $$$appButton(divId_"appButtonAbout","onclick="""_$tr(onclick,"*",1)_"""",""_$$$aText("Make tab",""))
}

/// rendering the Tab previously submitted
/// Par - code menu item from the GetAllApps ..
ClassMethod ShowInIFrame(key = "") As %Status
{
 if $g(key("appPar"))'="" set key=key("appPar")
 do ..GetAllApps(.opt) 
 if $g(opt(key,"Disable")) write ..GetSupportInfo() quit $$$OK
 set NSpace=$zu(5)
 set pref=$g(opt(key,"id"))
 set mhead=pref_"MainHeader"
 set mcont=pref_"MainContent"

 ;  <iframe id="#(mcont)#" width="100%" height="100%" style='overflow: auto;' src='#($g(opt(key,"InFrameUrl")))#' ></iframe>
 &html<
<form id="#(pref_"MainForm")#">
<div class="uk-grid">
    <iframe id="#(mcont)#" width="1500" height="1000" style='overflow: auto;' src='#($g(opt(key,"InFrameUrl")))#' ></iframe>
    </div>
</div>
</form>
>
 quit $$$OK
}

/// Open New Windows
/// Par - code menu item from the GetAllApps ..
ClassMethod OpenNewWin(key = "") As %Status
{
 if $g(key("appPar"))'="" set key=key("appPar")
 do ..GetAllApps(.opt) 
 if $g(opt(key,"Disable")) write ..GetSupportInfo() quit $$$OK
 set NSpace=$zu(5)
 set pref=$g(opt(key,"id"))
 set url=$g(opt(key,"InFrameUrl"))
 
 zw opt
 
 if url'="" {
	w "<a target='_blank' id=123 href='"_url_"'>Open new windows "_pref_"</a>"
	$$$jsstart
  	write "window.open('"_url_"', '_blank'); //"_$$$NL
  	write "$('#tabMenu-"_pref_",#tab-"_pref_"').remove(); //"_$$$NL
	$$$jsstop
 }
 quit $$$OK
}

/// rendering the Tab previously submitted
/// Par - code menu item from the GetAllApps ..
ClassMethod ShowTabSample(key = "") As %Status
{
 if $g(key("appPar"))'="" set key=key("appPar")
 do ..GetAllApps(.opt) 
 if $g(opt(key,"Disable")) write ..GetSupportInfo() quit $$$OK
 set NSpace=$zu(5)
 set pref=$g(opt(key,"id"))
 set ClassMetod=pref_"FirstHead"
 if $D(opt(key,"ClassMetod"),data) set ClassMetod=data
 set mhead=pref_"MainHeader"
 set mcont=pref_"MainContent"
 &html<
<form id="#(pref_"MainForm")#">
<div class="uk-grid">
    <div class="uk-width-1-1 "id="#(mhead)#" ></div>
    <div style='overflow: auto;' class="uk-width-1-1 uk-margin-top uk-margin-left" id="#(mcont)#"></div>
</div>
</form>
>
 ;d ##class(apptools.core.LogInfoPane).AddJS(NSpace,..%ClassName(1))
 
 $$$jsstart
  	; to calculate the height of the container as a result of wijetunge victory container-Taba height of the container header
    write ##class(apptools.core.Action).WriteActJs(%request,pref_"MainForm",mhead,..%ClassName(1),ClassMetod,"&divId="_pref_"&key="_key)_$$$NL
  	write $$$blockui($$$aText("Loading...",""))_$$$NL
  	;write "$('#"_mcont_"').height($(window).height()-($('#"_mhead_"').height()+$('#t1').height()+300)); //^^^height"_$$$NL
  	;write "console.log('^^^height');"_$$$NL
 $$$jsstop
 
 quit $$$OK
}

/// Lighbox Draw JSON
/// List - files array 
/// subdir - application static
ClassMethod LighboxDrawJson(List, subdir = "", appdynamic, gn = "") As %Status
{
 set i=""
 for { set i=$o(List(i)) q:i=""
 	if $lv($g(List(i))),$lg($g(List(i)),2)="F" {
		 	set fullpath=$lg($g(List(i)),1)
		 	set ItemName=$lg($g(List(i)),4)
 	} else {
 		set ItemName=$g(List(i,"ItemName"))
 		set fullpath=$g(List(i,"Name"))
 	}
 	set ext=$p(ItemName,".",*)
 	set mimetype=##class(apptools.core.filesMimeTypes).GetMimeTypes4ext(ext)
 	set type=$s(mimetype[("video"):"video",(mimetype)[("image"):"image",1:"iframe")
 	if subdir'="" {
 		write "{source: '"_subdir_ItemName_"', caption: '"_ItemName_"', type: '"_type_"'}",$c(13,10)
 	} else {
	 	set fileId=##class(apptools.core.files).GetFileIdView(fullpath,gn) 
		write "{source: '"_appdynamic_fileId_"', caption: '"_ItemName_"', type: '"_type_"'}",$c(13,10)
 	}
	write:$o(List(i))'="" ","
 }
}

/// Encode string to URL
ClassMethod EnCode(s) As %Status
{
	set:$zversion(1)'=3 s=$zconvert(s,"O","URL")
	quit s
}

/// Decode string from URL
ClassMethod DeCode(s) As %Status
{
	set:$zversion(1)'=3 s=$zconvert(s,"I","URL")
	quit s
}

/// Draw Tables UiKit
ClassMethod DrawTableUi(mode = "beg", divId = "tab2", attr = "", ByRef Enum) As %Status
{
	if mode="beg" {
	&html<
 <div #(attr)# id="#(divId)#" >
    <table class="uk-table uk-table-hover uk-table-middle uk-table-divider">
        <thead>
           <tr>
          >
          set i=""  for {  s i=$o(Enum(i)) quit:i=""
            write " <th "_$GET(Enum(i,"attr"))_" >"_$g(Enum(i))_"</th>"
          }
               /* <th class="uk-table-shrink">Preserve</th>
                <th class="uk-table-expand">Expand + Link</th>
                <th class="uk-width-small">Truncate</th>
                <th class="uk-table-shrink uk-text-nowrap">Shrink + Nowrap</th> */
    &html<
            </tr>
        </thead>
        <tbody>
        >
	}
    elseif mode="tr" {
			write "<tr>"
            set i=""  for {  set i=$o(Enum(i)) quit:i=""
				write "<td "_$GET(Enum(i,"attr"))_"><font color=Lightblue>"_$GET(Enum(i))_"</font></td>"
               
               /* <td><input class="uk-checkbox" type="checkbox"></td>
               <td><img class="uk-preserve-width uk-border-circle" src="image/msw.jpg" width="40" alt=""></td>
                <td class="uk-table-link">
                    <a class="uk-link-reset" href="">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.</a>
                </td>
                <td class="uk-text-truncate">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.</td>
                <td class="uk-text-nowrap">Lorem ipsum dolor</td>*/
            } 			
            w "</tr>"
	}
	elseif mode="end" {
		&html<
		   </tbody>
 	 	 </table>
 		</div>
    	>
	} else {
	}
}

/// Get property element object
/// do ##class(apptools.lte.adminTabs).GetElemProp("","test",.gn,"pref",,.tag)
ClassMethod GetElemProp(obj = "", propName, ByRef gn, PrefixIdDIV = "", Mode = "", ByRef tags = "", ByRef Par = "")
{
	set sysType=$g(gn("Properties",propName,"Type"))
	
	if sysType["%Stream." quit $$$OK ;TODO exception
	set Name=$g(gn("Properties",propName,"Name"))

	if Name="" quit $$$ERROR($$$GeneralError,"No Exsist Property "_propName) 
	
	set Required=$g(gn("Properties",propName,"Required"))
	set ReadOnly=$g(gn("Properties",propName,"ReadOnly"))
	set Parameters=$g(gn("Properties",propName,"Parameters"))
	
	set Value=$G(Par("ValueElement"))
	if $iso(obj) set Value=$property(obj,Name)
	
	set redstar="" if Required s redstar="<font color=red title='"_$$$aText("Required field","")_"'>*</font>"
	
	do ##class(apptools.core.Form).GetJsonProp(obj, propName, .gn, .pr)
	if $GET(Par("attr"))'="" set pr("attr")=Par("attr") 
	if 'ReadOnly set ReadOnly=$g(pr("readOnly"))
	if 'Mode set ReadOnly=1
	
	set label=pr("description")_redstar
	if Mode["ShowFieldName" set label=label_"<br>("_propName_")"
	if $g(pr("inputpattern"))="hidden" set label=""
	set tags=tags_"<td style='text-align: right;' title='"_$g(pr("title"))_"' ><label>"_label_"</label></td>"
	set tags=tags_"<td style='text-align: left;' title='"_$g(pr("title"))_"' >"
	s pr("attr")=$g(pr("attr"))_" "_$s(Required:"Required",1:"")_" "_$s(ReadOnly:"disabled",1:"")
	
	s %id=$g(PrefixIdDIV)_Name
	s %val=$g(Value)
	s pr("WebComp-size")=" size=50 " if pr("attr")["size" set pr("WebComp-size")=""
	
	if sysType="%Boolean",pr("inputtype")'="checkbox" {
		d ..SelectFieldYesNo(%id,%val,.tag)
		set tags=tags_tag
	}
	elseif sysType="%Date" {
	 	set tags=tags_$$$appText(%id," size=10 "_pr("attr"),%val)
	}
	else {  //%String
		if $g(pr("inputpattern"))="textarea" {
			if pr("attr")'["cols" s pr("attr")=pr("attr")_" cols=77 "
			if pr("attr")'["rows" s pr("attr")=pr("attr")_" rows=3 "
			set tags=tags_$$$appTextarea(%id,pr("attr"),%val)
		}
		elseif $g(pr("inputpattern"))="hidden" {
			set tags=tags_"<input type='hidden' id='"_%id_"' name='"_%id_"' "_$g(pr("attr"))_" value='"_%val_"'>"
		}
		elseif $g(pr("inputpattern"))="autocomplete" {
			set met=$g(pr("autocompleteMethod"))
			if met'=""  xecute "do "_met
			set tags=tags_$$$appAutocomplete(%id," "_pr("attr"),%val)
		}
		elseif $g(pr("inputpattern"))="files" {
			set tags=tags_##class(apptools.core.Form).WebCompShowFiles(obj,.pr,Mode,%id,%val)
		}
		elseif $g(pr("inputpattern"))="select" {
			set met=$g(pr("selectMethod"))
			if met'="" {
				;;w met
				if (met["{") { //a list of json
					;TODO
				}
				else { //a list of functions
					xecute "do "_met
				}
			}
			;w $$$appInputHidden(.%id," "_attr,%val)
		}
		elseif $g(pr("inputpattern"))="selectize" {
			s met=$g(pr("selectMethod"))
			set tags=tags_"<input type='text' id='"_%id_"' name='"_%id_"' class='input-tags demo-default ui-corner-all ui-widget ui-widget-content' value='"_%val_"'>"
			if met'="" {
				xecute "do "_met
			}
		}
		elseif pr("inputtype")="checkbox" {
			set tags=tags_##class(apptools.core.Form).WebCompShowCheckbox(,.pr,Mode,%id,%val)
		}
		elseif pr("inputtype")'="" {
			set tags=tags_$$$appInput(%id," type='"_pr("inputtype")_"' "_pr("WebComp-size")_pr("attr"),%val)
		}
		elseif Parameters["{" {
			if {}.$$$jsonFromJSON(Parameters).VALUELIST'="" {
			  set vl={}.$$$jsonFromJSON(Parameters).VALUELIST
			  set dl={}.$$$jsonFromJSON(Parameters).DISPLAYLIST
			  ;	s ^tmpMSW(1,$i(^tmpMSW),"Parameters")=$lb(propName,vl,dl)
			  set:dl="" dl=vl
			  do ..SelectField($lfs(vl),,$lfs(dl),.gn2,,%id,%val,600,.tag)
			  set tags=tags_tag
			} else {
				set tags=tags_$$$appText(%id,pr("WebComp-size")_pr("attr"),%val)
			}
		}
		else { set tags=tags_$$$appText(%id,pr("WebComp-size")_pr("attr"),%val)
		}
	}
	set tags=tags_"</td>"
	Quit $$$OK
}

/// The output type field select Yes or no 
/// do ##class(apptools.lte.adminTabs).SelectFieldYesNo("test","0",.tag)
ClassMethod SelectFieldYesNo(idSelect = "selectmenu", dfltKey = "", ByRef tags) As %Status
{
	do ..SelectField($lb(0,1),,$lb($$$aText("No",""),$$$aText("Yes","")),.gn,,idSelect,dfltKey,100,.tags)
	q $$$OK
}

/// The output fields of type select
/// do ##class(apptools.lte.adminTabs).SelectField($lb("",0,1),"alert(1);",$lb("","No","Yes"),.gn,,"test","0",50,.tag) 
ClassMethod SelectField(KeyList = "", ONCHANGE = "", ValueList = "", gnRet, order = 1, idSelect = "selectmenu", dfltKey = "", width = 500, ByRef tags) As %Status
{
	kill gnRet
	set selectNS="<SELECT id='"_idSelect_"' name='"_idSelect_"' "_$s(ONCHANGE'="":"ONCHANGE='"_ONCHANGE_"'",1:"")_">",
		tags=""
	set gnRet($i(gnRet))=selectNS
	for i=1:1:$ll(KeyList) { 
		set selected=""
		if dfltKey'="",dfltKey=$lg(KeyList,i) s selected="selected"
		set select=" <OPTION "_$g(selected)_" VALUE="""_$lg(KeyList,i)_""">"_$lg(ValueList,i)_"</OPTION>"
  		set gnRet($i(gnRet))=select
	}
	set gnRet($i(gnRet))="</SELECT>"
	for i=1:1 {q:'$DATA(gnRet(i))  set tags=tags_gnRet(i)}
	set tags=tags_"<script language='javascript'>"
		set tags=tags_"$( '#"_idSelect_"' ).selectmenu({ change: function( event, data ) { "_ONCHANGE_" }, width:"_width_" }).selectmenu('menuWidget');" ;;.selectmenu('refresh') .addClass('overflow');"
		set tags=tags_"$( '#"_idSelect_"-menu' ).css( 'max-height','500px');"
	set tags=tags_"<script language='javascript'>"
	q $$$OK
}

}
