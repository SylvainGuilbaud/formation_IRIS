Class journal.utils
{

ClassMethod purge(directory As %String, purge As %Boolean = 0) As %Status
{
	set sc = $$$OK
    set sc = ##class(%SYS.Journal.System).SwitchFile()
    set currentJournal = ##class(%SYS.Journal.System).GetCurrentFileName()
	try {
        write:'purge "listing all journal files in ",directory,!
        write:purge "purging all journal files in ",directory,!
		set directory = ##class(%File).NormalizeDirectory(directory)
		set statement = ##class(%SQL.Statement).%New()
        set sc = statement.%PrepareClassQuery("%File","FileSet")
		set rs=statement.%Execute(directory)
		while (rs.%Next()) {
            set journal = rs.%Get("Name")
            if journal[".lck" continue
            if purge 
            && (journal '= currentJournal) {
                set sc = ##class(%SYS.Journal.File).PurgeOne(journal)
                 if sc {
                    write $i(i),":",journal," successfully purged",!
                } else {
                    do $system.OBJ.DisplayError(sc)
                 } 
            } else {
                write $i(i),":",journal,!
            }
		}
	} catch ex {
		set sc = ex.AsStatus()
	}
	quit sc
}

}
