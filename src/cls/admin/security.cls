Class admin.security Extends %RegisteredObject
{

ClassMethod createUser(username As %String, roles As %String = "connectBNA", password As %String = "password", fullName As %String, namespace As %String, expirationDate As %String, email As %String = "") As %Status
{
    Set sc = $$$OK
    set ns = $NAMESPACE
    zn "%SYS"
    set prop("NameSpace")=namespace   
    set prop("ChangePassword")=1    
    set prop("FullName")=fullName    
    set prop("ExpirationDate")=expirationDate   
    set prop("Roles")=roles    
    set prop("EmailAddress")=email    

    if '##class(Security.Users).Exists(username) {
        set (ChangePassword,Enabled) = 1
        Try {
            set sc = ##class(Security.Users).Create(username,roles,password,fullName,namespace,"","",ChangePassword,Enabled)
            do ##class(%SYS.System).WriteToConsoleLog($system.Status.GetErrorText(sc))

        }
        Catch ex {
            Set sc=ex.AsStatus()
            do ##class(%SYS.System).WriteToConsoleLog($system.Status.GetErrorText(sc))
        }
    }
    Try {
        set sc = ##class(Security.Users).Modify(username,.prop)
        do ##class(%SYS.System).WriteToConsoleLog($system.Status.GetErrorText(sc))
    }
    Catch ex {
        Set sc=ex.AsStatus()
        do ##class(%SYS.System).WriteToConsoleLog($system.Status.GetErrorText(sc))
    }
    zn ns
    return sc
}

}
