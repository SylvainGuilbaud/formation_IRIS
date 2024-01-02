Class dc.msw.py.xlsx
{

/// do ##class(dc.msw.py.xlsx).sql2xlsx("select * from apptools_core.Log order by id desc","n,,,,,n,,,,d","/tmp/sample-py.xlsx")
ClassMethod sql2xlsx(sql, format = "", file As %String = "d:\_proj\python\sample-py-*.xlsx", title = "")
{
	set st=$$$OK
	set myQuery = ##CLASS(%ResultSet).%New("%DynamicQuery:SQL")
	set st=myQuery.Prepare(sql)
	if 'st q st
	set st=myQuery.Execute()
	if 'st q st
	
	;prepare XLSX
	set file=$Replace(file,"*",$Tr($zts,".,"))
	try {
        set openpyxl = ##class(%SYS.Python).Import("openpyxl") 
    } catch err {
        set sc = ##class(%SYS.Python).Install("openpyxl")
        set openpyxl = ##class(%SYS.Python).Import("openpyxl") 
    }
	set wb = openpyxl.Workbook()
	#; grab the active worksheet
	set ws = wb.active
	set ws.title = "Report"
	set pybuiltins = $system.Python.Import("builtins")
	set pycols = pybuiltins.list()
	do pycols.append(" ")
	do ws.append(pycols)
	set ws."__getitem__"("A2").value=title

	set pycols = pybuiltins.list()
	set (count)=0
	set ColCount=myQuery.GetColumnCount()
	for i=1:1:ColCount {	
		do pycols.append(myQuery.GetColumnName(i))
		set col=$C(i+64)
		if i<27 set ws."column_dimensions"."__getitem__"(col).width = "20"
	}
	do ws.append(pycols)

	while (myQuery.Next())	{
		set count=count+1
		set pyrows = pybuiltins.list()
		for ii=1:1:ColCount {
			set val=myQuery.GetData(ii)
			if $P(format,",",ii)="d" { //date
				set dt = ##class(%SYS.Python).Import("datetime")
				set val=dt.datetime(+$p(val,"-",1), +$p(val,"-",2), +$p($p(val,"-",3)," "),+$p($p(val,":",1)," ",2),+$p($p(val,":",2)," ",2),+$p($p(val,":",3)," ",2))
			}
			if $P(format,",",ii)="n" { //number
				set val=+val
			}
			do pyrows.append(val)
		}
		do ws.append(pyrows)
	}
	write !,"Save into "_file_" rows: "_count
	do wb.save(file)
	q $GET(count)
}

}
