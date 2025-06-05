Class web.zen.login Extends %ZEN.Component.page
{

XData Contents [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<page xmlns="http://www.intersystems.com/zen" title="">
  <loginForm id="loginForm" >
    <text name="IRISUserName" label="User:" />
    <password name="IRISPassword" label="Password:" />
    <submit caption="Login" />
  </loginForm>
</page>
}

}
