Class admin.security Extends %RegisteredObject
{

ClassMethod createUser(username As %String, roles As %String = "connectBNA", password As %String = "password", email As %String = "") As %Status
{
    Set sc = $$$OK
    set ns = $NAMESPACE
    zn "%SYS"
    set prop("EmailAddress")=email    
    if '##class(Security.Users).Exists(username) {
        set sc = ##class(Security.Users).Create(username,roles,password,"","USER","","",1,1)
        set sc = ##class(Security.Users).Modify(username,.prop)
    }
    zn ns
    return sc
}

}
