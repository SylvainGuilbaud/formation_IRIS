Class web.zen.loginIRIS Extends %CSP.Login
{

ClassMethod OnLoginPage() As %Status
{
	// text strings
	Set ConfigName = $P($zu(86),"*",2)
	// get key, lookup in localization global
	Set tLang = $$$SessionLanguage
	Set tTitle = $$FormatText^%occMessages($$$GetSysMessage(tLang,..#DOMAIN,"logintitle","Login %1"),ConfigName)
	Set tPrompt = $$$GetSysMessage(tLang,..#DOMAIN,"loginenter","Please login")
	Set tUserName = $$$GetSysMessage(tLang,..#DOMAIN,"loginusername","User Name")
	Set tPassword = $$$GetSysMessage(tLang,..#DOMAIN,"loginpassword","Password")
	Set tLogin = $$$GetSysMessage(tLang,..#DOMAIN,"login","LOGIN")
	Set OtherAutheEnabled = $$OtherAuthEnabled^%SYS.cspServer(%request)
	&html<<html>>
	Do ..DrawHEAD("CONNEXION")

	&html<
		<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="pageLoad();">
		<div id="content">>
 
	Do ..DrawTitle("CONNEXION IRIS")

 	&html<
 	<div style="background-color:darkblue;">
 	<table border="0" cellpadding="10" align="center" class="LayoutTable">
 	<tr>
	<td align="center">
 	<table border="0" width="100%" cellpadding="5" cellspacing="0">>
 	&html<<tr><td style="height:90px;"><br/></td></tr>>
 	
 	&html<<tr><td><center>>

  If OtherAutheEnabled = 1 {
	// Show standard login form

	&html<
	
	<form name="Login" method="post" action="#($ZConvert($G(%request.Data("Error:FullURL",1)),"O","HTML"))#" autocomplete="off">>

	Write ..InsertHiddenFields($ZConvert($G(%request.Data("Error:URL",1)),"O","HTML"))

	&html<
	<table class="login" border="0" cellspacing="10" cellpadding="10" >
	<tr valign="bottom">
	<td nowrap class="loginCaption">#("code utilisateur Banque Nationale Alzheimer")#</td>
	<td><input type="text" size="30" name="IRISUsername" autocomplete="off" value="#($ZCVT($get(%request.Data("IRISUsername",1)),"O","HTML"))#"/>
 	</td>
 	</tr>
	<tr valign="bottom">
	<td nowrap class="loginCaption">#("mot de passe")#</td>
	<td><input type="password" size="30" name="IRISPassword" autocomplete="off"/>
	</td>
	</tr>
	<tr><td>&nbsp;</td>
	 <td style="text-align:right"><input type="submit" name="IRISLogin" class="button" value="#(tLogin)#" style="width:120px;"></td>
	</tr>
	</table>
	</form></center></div>>

  }  // End OtherAutheEnabled = 1 block
  Else {
	  // This is accessed when IRIS is installed with minimum security and user clicked Logout.
	  Set msg1 = $$$GetSysMessage(tLang,..#DOMAIN,"loginclickhere","Please click here to log in.")
	  Set tLink = ..Link("/csp/sys/UtilHome.csp")
	&html<
	<a href="#(tLink)#" class="loginlink">#(msg1)#</a>
	</center>
	</td>
	</tr>
	</table>
	>
  }

 	// test for error
 	Set tMsg = $Get(%request.Data("Error:ErrorCode",1))
 	If ((tMsg'="")&&($SYSTEM.Status.GetErrorCodes(tMsg)'[$$$ERRORCODE($$$RequireAuthentication))) {
 		&html<<tr><td><center>>
 		Do ShowError^%apiCSP(tMsg)
 		&html<</center></td></tr>>
 	}

 	&html<</td></tr><tr><td style="height:180px;"><br/></td></tr></table></div></div></body></html>>

 	Quit $$$OK
}

ClassMethod DrawHEAD(pTitle = "")
{
	&html<<head>
	<title>#(pTitle)#</title>>

	// link in stylesheet specified by parameter
	If (..#STYLESHEET '= "") {
		&html<<link rel="stylesheet" type="text/css" href="#(..Link(..#STYLESHEET))#">>
	}
	If (..#FAVORITEICON '= "") {
		&html<<link rel="icon" type="image/ico" href="#(..Link(..#FAVORITEICON))#">>
	}
	// js functions
	&html<<script language="javascript">
	// called when page is loaded
	function pageLoad()
	{
		// see if we can give focus to the UserName field:
		if (self.document.Login && self.document.Login.IRISUsername) {
			self.document.Login.IRISUsername.focus();
			self.document.Login.IRISUsername.select();
		}

		return true;
	}
	</script>>
	If ##class(%ZEN.Utils).%BrowserSupportsHTML5(%request.UserAgent) {
		Do ..DrawCSS3STYLE()
	}
	Else {
		Do ..DrawSTYLE()
	}
	&html<</head>>
}

/// Draw the title section of the login page.<br>
/// <var>pTitle</var> is the title for the page.<br>
/// Users can override this method to customize the login page.
ClassMethod DrawTitle(pTitle As %String)
{
	Set tLang = $$$SessionLanguage
	Set tAction = $$$GetSysMessage(tLang,..#DOMAIN,"login","Login")
	Set msgs("title") = pTitle
	Set msgs("tAction") = tAction
	
	Do ..DrawTitleSection( .msgs )
}

}
