Class large.utils
{

ClassMethod init(nb As %Integer = 10, max As %Integer = 100) As %Status
{
        set sc = $$$OK

        set serialclass = "large.serial" _ max

        if ##class(%Dictionary.ClassDefinition).%ExistsId(serialclass) {
            set sc = ##class(%Dictionary.ClassDefinition).%DeleteId(serialclass)
            write "deleting "_ serialclass,!
            do $system.Status.GetErrorText(sc)
        }

        set a = ##class(%Dictionary.ClassDefinition).%New()
        set a.Description = "<p> created on "_$zdt($h,3) _"<p>generated automatically by <example>do ##class(large.utils).init()</example>"
        set a.Name = serialclass
        set a.Super = "%SerialObject,%Populate,%XML.Adaptor,%JSON.Adaptor"
        for i = 1:1:max {
            set p = ##class(%Dictionary.PropertyDefinition).%New()
            set p.Name = "s"_i
            set p.Type = "%String"
            do p.Parameters.SetAt("","MAXLEN")
            do a.Properties.Insert(p)
        }
        set sc = a.%Save()
        write "creating "_ serialclass,!
        if sc {
            write "compiling "_ serialclass,!
            set sc = $system.OBJ.Compile(serialclass)
        } else {
            do $system.Status.GetErrorText(sc)
        }   
        do $system.Status.GetErrorText(sc)
        write !
        kill a
        set classname = "large.c"_ nb
        if ##class(%Dictionary.ClassDefinition).%ExistsId(classname) {
            set sc = ##class(%Dictionary.ClassDefinition).%DeleteId(classname)
            write "deleting "_classname,!
            do $system.Status.GetErrorText(sc)
        }

        set a = ##class(%Dictionary.ClassDefinition).%New()
        set a.Description = "<p> created on "_$zdt($h,3) _"<p>generated automatically by <example>do ##class(large.utils).init()</example>"
        set a.Name = classname
        set a.Super = "%Persistent,%Populate,%XML.Adaptor,%JSON.Adaptor"
        for i = 1:1:nb {
            set p = ##class(%Dictionary.PropertyDefinition).%New()
            set p.Name = "p"_i
            set p.Type = serialclass
            do a.Properties.Insert(p)
        }
        set sc = a.%Save()
        write "creating "_ classname,!
        if sc {
            write "compiling "_ classname,!
            set sc = $system.OBJ.Compile(classname)
        } else {
            do $system.Status.GetErrorText(sc)
        }   
        write !
        return sc
}

}
