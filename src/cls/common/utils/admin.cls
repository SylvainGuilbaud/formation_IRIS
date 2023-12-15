Class common.utils.admin Extends %RegisteredObject
{

ClassMethod export(classname As %VarString) As %Status [ Language = python ]
{
    import iris
    sc=iris.cls("%SYSTEM.OBJ").Export(classname,"/tmp/export_"+classname+".xml")
    return sc
}

}
