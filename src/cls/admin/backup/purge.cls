Class admin.backup.purge Extends %SYS.Task.BackupAllDatabases
{

Parameter TaskName = "Backup With Purge";

Property Daystokeep As %Integer(VALUELIST = ",0,1,2,3,4,5") [ InitialExpression = "1" ];

Method OnTask() As %Status
{
    //Call PurgeBackup Method, Return Status
    Set tsc = ..PurgeBackups(..Device,..Daystokeep)
    Set tsc = ..RunBackup()
    Quit tsc
}

Method PurgeBackups(Directory As %String, DaysToKeep As %Integer) As %Status
{
    set tSC = $$$OK
    // Calculate the oldest date to keep files on or after
    set BeforeThisDate = $zdt($h-DaysToKeep_",0",3)

    // Gather the list of files in the specified directory
    set rs=##class(%ResultSet).%New("%File:FileSet")
    do rs.Execute(Directory,"*.cbk","DateModified")

    // Step through the files in DateModified order
    while rs.Next() {
        set DateModified=rs.Get("DateModified")
        if BeforeThisDate]DateModified {
            // Delete the file
            set Name=rs.Get("Name")
            do ##class(%File).Delete(Name)
        }
        // Stop when we get to files with last modified dates on or after our delete date
        if DateModified]BeforeThisDate 
        set tSC = 1
    }
    quit tSC
}

Method RunBackup() As %Status
{
    d $zu(5,"%SYS")
    Set jobbackup = 0
    Set quietflag = 1
    Set Device = ..Device
    Set tSC = ##class(Backup.General).StartTask("FullAllDatabases", jobbackup, quietflag, Device, "0")
    Quit tSC
}

}
