Class common.tasks.export Extends %SYS.Task.Definition
{

Property directory As %VarString [ InitialExpression = "/tmp/", Required ];

Property classname As %VarString [ InitialExpression = "Sample.Person", Required ];

Property format As %String(VALUELIST = ",CSV,JSON,XML") [ InitialExpression = "CSV", Required ];

Property minID As %Integer(MINVAL = 1) [ InitialExpression = 1, Required ];

Property maxID As %Integer;

Method OnTask() As %Status
{
       
    set start=$zh
    
    Try {
        set class = ##class(%Dictionary.ClassDefinition).%OpenId(..classname)
        set tableName = class.SqlTableName
        set:tableName="" tableName = ..classname
        set sql = "select count(*) from " _ tableName
        set result = ##class(%SQL.Statement).%ExecDirect(,sql)
        if result.%SQLCODE = 0 {
            do result.%Next() 
            set max = result.%GetData(1)
        }

        set sc = $$$OK,i = ..min
        if ..min > ..max {
            set json = {"ERROR":(..min _ ">" _..max)}
            do json.%ToJSON()
        } else {
            set ..format = $zcvt(..format,"L")
            if ..format = "json" {
                if ..min > ..max {
                    set json = {"ERROR":(..min _ ">" _..max)}
                } else {
                    set json = {"tablename": (..classname)}
                    set json.data = []
                    while i <= ..max { 
                        if $CLASSMETHOD(..classname,"%ExistsId",i) {
                            set a = $CLASSMETHOD(..classname,"%OpenId",i)
                            if $ISOBJECT(a) {
                                set sc = a.%JSONExportToStream(.str)
                                do json.data.%Push({}.%FromJSON(str))
                            }
                        }
                        do $INCREMENT(i)
                    } 
                }
                write ""
                do json.%ToJSON()
            }
            if ..format = "xml" {
                set writer=##class(%XML.Writer).%New()
                set writer.Charset="UTF-8"
                set sc=writer.RootElement("tablename-"_..classname)
                while i <= ..max { 
                    if $CLASSMETHOD(..classname,"%ExistsId",i) {
                        set a = $CLASSMETHOD(..classname,"%OpenId",i)
                        if $ISOBJECT(a) {
                            set sc=writer.Object(a,..classname)
                        }
                    }
                    do $INCREMENT(i)
                }
                set sc = writer.EndRootElement()
            }
            if ..format = "csv" {
                set class = ##class(%Dictionary.ClassDefinition).%OpenId(..classname)

                set header = "ID;"
                for h = 1 : 1 : class.Properties.Count() {
                    set propertyName = class.Properties.GetAt(h).Name 
                    set header = header _ propertyName
                    if h < class.Properties.Count() {
                            set header = header _ ";"
                        }
                }
                write header,!
                while i <= ..max { 
                    if $CLASSMETHOD(..classname,"%ExistsId",i) {
                        set a = $CLASSMETHOD(..classname,"%OpenId",i)
                        set line = i _ ";"
                        if $ISOBJECT(a) {
                            for l = 1 : 1 : class.Properties.Count() {
                                set propertyName = class.Properties.GetAt(l).Name
                                if class.Properties.GetAt(l).Type = "%Date"  {
                                    set line = line _ $zd($PROPERTY(a,propertyName),4)
                                } else {
                                    set line = line _ $PROPERTY(a,propertyName) 
                                }
                                if l < class.Properties.Count() {
                                    set line = line _ ";"
                                }
                                
                            }
                        write line,!
                        }
                    }
                    do $INCREMENT(i)
                }
            }
        }
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    return sc
}

}
