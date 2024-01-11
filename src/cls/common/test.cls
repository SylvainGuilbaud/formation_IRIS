Class common.test
{

ClassMethod post(filename As %String = "/data/143.xml", classname As %String = "Exparf.BRIEFS", nb As %Integer = 1) As %Status
{
    set sc = $$$OK
    Try {
    
    set status = ""
    
    for i=1 : 1 : nb {
        set httpRequest = ##class(%Net.HttpRequest).%New()
        #; set httpRequest.Server = "172.30.0.200"
        set httpRequest.Server = "host.docker.internal"
        set httpRequest.Port = 80
        #;  set httpRequest.Port = 52773
        set httpRequest.Username = "_system"
        set httpRequest.Password = "SYS"
        set httpRequest.Timeout = 5
        #; set httpRequest.SSLConfiguration="ISC.FeatureTracker.SSL.Config"
        
        set file=##class(%Stream.FileBinary).%New()
        set sc=file.LinkToFile(filename)

        do httpRequest.EntityBody.CopyFrom(file)


        set ^post($i(post),"size") = httpRequest.EntityBody.Size

        #; set sc=httpRequest.Post("http://host.docker.internal:52773/common/import/" _ classname)


        #; set sc = httpRequest.Get("http://" _ httpRequest.Server _ ":" _ httpRequest.Port _ "/api/atelier/")
        #; if $$$ISOK(sc) && $IsObject(httpRequest.HttpResponse.Data) {
        #;     set ^post($i(^post)) = httpRequest.HttpResponse.Data.Read()
        #;     set status = httpRequest.HttpResponse.StatusCode
        #; }

        #; write i, " status:" , status,!

        #; set sc = httpRequest.Get("http://" _ httpRequest.Server _ ":" _ httpRequest.Port _ "/common/")
        #; if $$$ISOK(sc) && $IsObject(httpRequest.HttpResponse.Data) {
        #;     set ^post($i(^post)) = httpRequest.HttpResponse.Data.Read()
        #;     set status = httpRequest.HttpResponse.StatusCode
        #; }

        #; write i, " status:" , status,!

        set sc = httpRequest.Post("http://" _ httpRequest.Server _ ":" _ httpRequest.Port _ "/common/import/" _ classname)
        if $$$ISOK(sc) && $IsObject(httpRequest.HttpResponse.Data) {
            set ^post($i(^post)) = httpRequest.HttpResponse.Data.Read()
            set status = httpRequest.HttpResponse.StatusCode
        } 
        set ^post($i(^post)) = $SYSTEM.Status.GetErrorCodes(sc)
        set ^post($i(^post)) = $SYSTEM.Status.GetErrorText(sc)
        

        write i, " status:" , status,!
    }
    }
    Catch ex {
        Set sc = ex.AsStatus()
    }
    return sc
}

ClassMethod post2(filename As %String = "/data/143.xml", classname As %String = "Exparf.BRIEFS", nb As %Integer = 1) As %Status [ Language = python ]
{
    import iris
    import requests
    from datetime import datetime
    now = datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S.%f")
    Server = "host.docker.internal"
    Port = 80
    Username = "_system"
    Password = "SYS"
    url = "http://" + Server + ":" + str(Port) + "/common/import"

    for x in range(0,nb):
        print(x+1)
        with open(filename, 'rb') as f:
            resp = requests.post(url, data=f ,  auth=(Username, Password))
        print("resp:" + resp.text)
        print("status:" + str(resp.status_code))
}

ClassMethod run(nb As %Integer = 1) As %Status [ Language = python ]
{
    import iris
    test = iris.cls('common.test')
    test.post2("/data/143.xml","Exparf.BRIEFS",nb)
    test.post2("/data/data-import-3.xml","data.test",nb)
}

ClassMethod pop(nb As %Integer = 1, classname As %String = "data.test") As %Status [ Language = python ]
{
    import iris
    c = iris.cls(classname)
    print(c.Populate(nb))
}

ClassMethod kill(classname As %String = "data.test") As %Status [ Language = python ]
{
    import iris
    for x in ["D","I","S"]:
        g = iris.gref("^" + classname + x)
        g.kill([])
}

ClassMethod db(db As %String = "/irisdata/db/app/irisapp/data/") As %Status [ Language = python ]
{
        import iris
    #; try:
        ns = iris.cls("common.test").GetNameSpace()
        print(iris.cls("common.test").SetNameSpace("%SYS"))
        print("<<< dismounting "+ db + " status:" + str(iris.cls("SYS.Database").DismountDatabase(db)))
        print(">>>    mounting "+ db + " status:" + str(iris.cls("SYS.Database").MountDatabase(db)))
        print(iris.cls("common.test").SetNameSpace(ns))
    #; except RuntimeError:
    #;     print("Wrong NameSpace")
}

ClassMethod GetNameSpace() As %Status
{
    Return $namespace
}

ClassMethod SetNameSpace(pNameSpace) As %Status
{
    zn pNameSpace
    Return $namespace
}

}
