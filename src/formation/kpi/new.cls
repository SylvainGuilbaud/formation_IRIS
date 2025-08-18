/// 
Class formation.kpi.new Extends %DeepSee.KPI
{

Parameter DOMAIN;

Parameter RESOURCE;

/// This XData definition defines the KPI.
XData KPI [ XMLNamespace = "http://www.intersystems.com/deepsee/kpi" ]
{
<kpi xmlns="http://www.intersystems.com/deepsee/kpi" name="kpi/new" sourceType="mdx" >
</kpi>
}

/// Notification that this KPI is being executed.
/// This is a good place to override properties, such as range and threshold.
Method %OnLoadKPI() As %Status
{
  Return $$$OK
}

/// Return an MDX statement to execute.
Method %OnGetMDX(ByRef pMDX As %String) As %Status
{
  Return $$$OK
}

/// This callback is invoked from a dashboard when an action defined by this dashboard is invoked.
ClassMethod %OnDashboardAction(pAction As %String, pContext As %ZEN.proxyObject) As %Status
{
  #; pAction is the name of the action (as defined in the XML list).
  #; pContext contains information from the client
  #; and can be used to return information.
  Return $$$OK
}

}
