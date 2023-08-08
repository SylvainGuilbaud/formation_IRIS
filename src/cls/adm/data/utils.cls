Class adm.data.utils [ Abstract, Not ProcedureBlock ]
{

ClassMethod export(file As %String, globalName As %String, delimiter As %String = ";") As %Status
{
    set s=$zts write !,"Started at ",s
    set nb=0
    set file=$g(file) if $l(file) open file:"WNS" use file
    set key=$order(@globalName@(""),1,x)
    while key'="" {
	    set nb=$i(nb)
	    write $lts(x,delimiter),!
	    set key=$order(@globalName@(key),1,x)
	}
    i $l(file) c file
    write !,"Exported ",nb," objects in ",$p($zts,",",2)-$p(s,",",2)," seconds"
    return $$$OK
}

ClassMethod import(file As %String, globalName As %String, delimiter As %String = ";") As %Status
{
	kill ^CacheTempImport($job)
    set s=$zts write !,"Started at ",s
    set file=$g(file) if $l(file) open file:"R" use file
    set $zt="eof"
    while 1 {
	    read x 
	    set @globalName@($i(@globalName))=$lfs(x,delimiter)
	    set nb=$i(nb)
	}
eof i $l(file) c file
    write !,"Loaded ",nb," objects in ",$p($zts,",",2)-$p(s,",",2)," seconds"
    return $$$OK
}

}
