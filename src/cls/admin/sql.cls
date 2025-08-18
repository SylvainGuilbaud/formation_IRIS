Class admin.sql Extends %RegisteredObject
{

/// Description
ClassMethod test() As %Status
{
    Set sc = $$$OK
    set sc = ..setSQLConnection("MyOracle", "C##supply", "supply_pwd", "oracle.jdbc.driver.OracleDriver", "/jdbc/ojdbc11.jar", "jdbc:oracle:thin:@host.docker.internal:1521:free")
    Return sc
}

/// @description "Class to manage SQL connections in the admin module"
ClassMethod setSQLConnection(connectionName As %String = "MyOracle", user As %String = "C##supply", pwd As %String = "supply_pwd", driver As %String = "oracle.jdbc.driver.OracleDriver", classpath As %String = "/jdbc/ojdbc11.jar", URL As %String = "jdbc:oracle:thin:@host.docker.internal:1521:free") As %Status
{
        set sc = $$$OK
        try {
            if ##class(%Library.SQLConnection).ConnExists(connectionName) {
                // If the connection already exists, edit it
                &sql(select id into :id from %Library.sys_SQLConnection where Connection_Name = :connectionName)
                if id {
                    set gateway = ##class(%Library.SQLConnection).%OpenId(id)
                }
            } else {
                set gateway = ##class(%Library.SQLConnection).%New()
            }
            // Code to add SQL Gateway
            set gateway.Name = connectionName
            set gateway.URL = URL
            set gateway.classpath = classpath
            set gateway.driver = driver
            set gateway.Usr = user
            set gateway.pwd = pwd
            set gateway.isJDBC = 1
            set sc = gateway.%Save()
        } catch (e) {
            set sc=e.AsStatus()
            do ##class(%SYS.System).WriteToConsoleLog($system.Status.GetErrorText(sc))
        }
        return sc
}

}
