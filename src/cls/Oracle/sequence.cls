Class Oracle.sequence Extends %Persistent
{

Property number As %Integer;

ClassMethod init()
{
	set a=..%New()
	set a.number=0
	do a.%Save()
}

ClassMethod nextval(type As %String) As %Integer [ SqlName = nextval, SqlProc ]
{
	lock +^Oracle.sequenceD(type)
	set i=$i(^Oracle.sequenceD(type))
	lock -^Oracle.sequenceD(type)
	quit i
}

ClassMethod currval(type As %String) As %Integer [ SqlName = currval, SqlProc ]
{
	quit +$get(^Oracle.sequenceD(type))
}

ClassMethod fileDDL(filename As %String, delete As %Boolean = 0)
{
	if delete {
		kill ^Oracle.sequenceD
	}
	set file=##class(%File).%New(filename)
	set sc=file.Open("R")
	if 'sc {
		do $system.OBJ.DisplayError(sc)
	}
	else {
		while 'file.AtEnd {
			set line=file.ReadLine()
			write line,!
			set line=$zstrip(line,"<>W")
			if $zcvt($piece(line," ",1,2),"U")="CREATE SEQUENCE" {
				set seq=$piece(line," ",3)
				set line=file.ReadLine()
				set val=+$piece($zcvt(line,"U"),"START WITH ",2)
				set ^Oracle.sequenceD(seq)=val
				write !,seq,?30,val,!
			}
		}
	}
}

Storage Default
{
<Data name="sequenceDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>number</Value>
</Value>
</Data>
<DataLocation>^Oracle.sequenceD</DataLocation>
<DefaultData>sequenceDefaultData</DefaultData>
<IdLocation>^Oracle.sequenceD</IdLocation>
<IndexLocation>^Oracle.sequenceI</IndexLocation>
<StreamLocation>^Oracle.sequenceS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
