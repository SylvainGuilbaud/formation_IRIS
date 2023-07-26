Class globals.utils
{

ClassMethod init(max As %Integer = 10) As %Status
{
    set sc = $$$OK
    kill ^data
    for i=1:1:max {
        set day=$h-$random(50000)
        set hour=$random(86400)
        set dayhour=day_","_hour
        set ^data(i)=$LB(##class(%PopulateUtils).FirstName(),##class(%PopulateUtils).LastName(),##class(%PopulateUtils).City(),$random(50000),$zdt(dayhour,3))
    }
    zw ^data
    return sc
}

ClassMethod getKeys() As %Status
{
    set sc = $$$OK
    set key=""
    FOR  {
        SET key=$ORDER(^data(key)) 
        QUIT:key=""
        WRITE !,key
    }        
    return sc
}

ClassMethod getData() As %Status
{
    set sc = $$$OK
    set key=""
    FOR  {
        SET key=$ORDER(^data(key),1,data) 
        QUIT:key=""
        ZWRITE data
        write "data(",key,")",!
        for i=1:1:$ListLength(data) {
            write i,":",$lg(data,i),!
        }
        write !!
    }        
    return sc
}

}
