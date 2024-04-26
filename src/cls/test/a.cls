Class test.a Extends %RegisteredObject
{

ClassMethod run() As %Status
{
    Set sc = $$$OK
    read !,"Enter the hour: ",hr  
    read !,"Enter the minute: ",min 
    read !,"Enter the second: ",sec     
    do ..getInternalTime(hr,min,sec)

     /// Display some other internal time values :
    for a = 0,3600,43200,45296,86399 {
        w !,"Equivalent M time: ",a," (Time:",$zt(a),")",!
    }
    Return sc
}

ClassMethod getInternalTime(hr As %Integer, min As %Integer, sec As %Integer) As %Status
{
    set sc=$$$OK
    set Mtime=$$ConvertToMTime(hr,min,sec)
    write !,"Equivalent M time: ",Mtime," (Time:",$zt(Mtime),")",!
    return sc
}

ClassMethod ConvertToMTime(h, m, s) As %Integer
{
        Return (h*3600)+(m*60)+(s)
}

}
