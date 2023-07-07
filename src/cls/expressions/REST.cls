Class expressions.REST Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>

<Route Url="/" Method="GET" Call="Version" Cors="true"/>

<Route Url="/bonjour/:nom" Method="GET" Call="Bonjour" Cors="true"/>

<Route Url="/crud" Method="POST" Call="Create" Cors="true"/>
<Route Url="/crud/:id" Method="GET" Call="Read" Cors="true"/>
<Route Url="/crud/:id" Method="PUT" Call="Update" Cors="true"/>
<Route Url="/crud/:id" Method="DELETE" Call="Delete" Cors="true"/>

</Routes>
}

ClassMethod Create() As %Status
{
    Set sc = $$$OK

    set %response.ContentType = ..#CONTENTTYPEJSON

    set content=""
    while '%request.Content.AtEnd {
        set content = content _ %request.Content.Read()
    }

    set data = {}.%FromJSON(content)

    set json = {}
    set json.name1 = data.name1
    set json.name2 = data.name2
    set json.name3 = data.name3
    #; set json.content = content

    #; set json.nom = data.name
   
    #dim commande as data.commande
    set commande = ##class(data.commande).%New()
    set sc = commande.%JSONImport(data)
    if sc {
        set sc = commande.%Save()
        if sc {
            set json.id = commande.%Id()
        }
    } 
    if sc {
        set json.commandeSauvergardee = "OK"
        set json.commandeID = commande.%Id()
    } 

    #; set sc = $system.Status.Error(5001,"Ceci est un test d'erreur")
    if 'sc {
        set error = {}
        set error.errorCode = $system.Status.GetErrorCodes(sc)
        set error.errorText = $system.Status.GetErrorText(sc)
        write error.%ToJSON()
    } else {
        write json.%ToJSON()
    }
    
    Return $$$OK
}

ClassMethod Read(id As %Integer) As %Status
{
    set sc = $$$OK

    set %response.ContentType = ..#CONTENTTYPEJSON
    
    #dim commande as data.commande
    if ##class(data.commande).%ExistsId(id) {
        set commande = ##class(data.commande).%OpenId(id)
        if $ISOBJECT(commande) {
            set sc = commande.%JSONExportToString(.commandeJSON)
            write commandeJSON
        } else {
            set json={}
            set json.id=id
            set json.notOBJECT=id_" pb sur OpenId"
            write json.%ToJSON()
        }  
    } else {
            set json={}
            set json.id=id
            set json.noFound=id_" n'existe pas dans data.commande"
            write json.%ToJSON()
    }  

    #; set sc = $system.Status.Error(5001,"Ceci est un test d'erreur")
    if 'sc {
        set error = {}
        set error.errorCode = $system.Status.GetErrorCodes(sc)
        set error.errorText = $system.Status.GetErrorText(sc)
        write error.%ToJSON()
    } 
    
    Return $$$OK
}

ClassMethod Update(id As %Integer) As %Status
{
    Set sc = $$$OK

    set %response.ContentType = ..#CONTENTTYPEJSON

    set content=""
    while '%request.Content.AtEnd {
        set content = content _ %request.Content.Read()
    }

    set data = {}.%FromJSON(content)

    set json = {}
    set json.name1 = data.name1
    set json.name2 = data.name2
    set json.name3 = data.name3
    #; set json.content = content

    #; set json.nom = data.name
   
   #dim commande as data.commande
    if ##class(data.commande).%ExistsId(id) {
        set commande = ##class(data.commande).%OpenId(id)
        if $ISOBJECT(commande) {
            set commande.orderStatus = data.orderStatus
            set sc = commande.%Save()
            if sc {
                set json.commandeSauvergardee = "OK"
                set json.commandeID = commande.%Id()
                set sc = commande.%JSONExportToString(.commandeJSON)
                set json.data = {}.%FromJSON(commandeJSON)
            } 
            
        } else {
            set json={}
            set json.id=id
            set json.notOBJECT=id_" pb sur OpenId"
            write json.%ToJSON()
        }  
    } else {
            set json={}
            set json.id=id
            set json.noFound=id_" n'existe pas dans data.commande"
            write json.%ToJSON()
    }  
    

    #; set sc = $system.Status.Error(5001,"Ceci est un test d'erreur")
    if 'sc {
        set error = {}
        set error.errorCode = $system.Status.GetErrorCodes(sc)
        set error.errorText = $system.Status.GetErrorText(sc)
        write error.%ToJSON()
    } else {
        write json.%ToJSON()
    }
    
    Return $$$OK
}

ClassMethod Delete(id As %Integer) As %Status
{
    set sc = $$$OK

    set %response.ContentType = ..#CONTENTTYPEJSON
    
    #dim commande as data.commande
    if ##class(data.commande).%ExistsId(id) {
        set sc = ##class(data.commande).%DeleteId(id)
        if sc {
            set json = {}
            set json.id = id
            set json.resultDELETE = "OK"
            write json.%ToJSON()
        }
    } else {
            set json={}
            set json.id=id
            set json.noFound=id_" n'existe pas dans data.commande"
            write json.%ToJSON()
    }  

    #; set sc = $system.Status.Error(5001,"Ceci est un test d'erreur")
    if 'sc {
        set error = {}
        set error.errorCode = $system.Status.GetErrorCodes(sc)
        set error.errorText = $system.Status.GetErrorText(sc)
        write error.%ToJSON()
    } 
    
    Return $$$OK
}

ClassMethod Version() As %Status
{
    Set sc = $$$OK

    set %response.ContentType = ..#CONTENTTYPEJSON

    set json = {}

    set json.version = "V1.0"
    set json.IRISversion = ($ZVERSION)
    set json.username = ($USERNAME)
    set json.roles = ($ROLES)
    set json.ts = ($zdt($h,3))
   

    #; set sc = $system.Status.Error(5001,"Ceci est un test d'erreur")
    if 'sc {
        set error = {}
        set error.errorCode = $system.Status.GetErrorCodes(sc)
        set error.errorText = $system.Status.GetErrorText(sc)
        write error.%ToJSON()
    } else {
        write json.%ToJSON()
    }
    
    Return $$$OK
}

ClassMethod BonjourOS(name As %String) As %Status
{
    Set sc = $$$OK

    set %response.ContentType = ..#CONTENTTYPEJSON

    set json = {}

    set json.message = "Bonjour " _ name
    set json.name =  name
    set json.username = $USERNAME
    set json.roles = $ROLES

    #; set sc = $system.Status.Error(5001,"Ceci est un test d'erreur")
    if 'sc {
        set error = {}
        set error.errorCode = $system.Status.GetErrorCodes(sc)
        set error.errorText = $system.Status.GetErrorText(sc)
        write error.%ToJSON()
    } else {
        write json.%ToJSON()
    }
    
    Return $$$OK
}

ClassMethod Bonjour(name As %String) As %Status [ Language = python ]
{
    import iris
    sc = 1
    print("Bonjour " + name)
    return 1
}

}
