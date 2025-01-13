Class admin.purge Extends %SYS.Task.Definition
{

Property Directory As %String(MAXLEN = 2000) [ InitialExpression = "/usr/irissys/mgr/Backup" ];

Property DaysToKeep As %Integer(VALUELIST = ",0,1,2,3,4,5") [ InitialExpression = "1" ];

Method OnTask() As %Status
{
    set sc = $$$OK
    Try {
        do ..purge(..Directory,..DaysToKeep)
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    return sc
}

ClassMethod purge(path As %String, daysToKeep As %Integer) As %Status [ Language = python ]
{
import iris
import os
import time
from datetime import datetime, timedelta

event = "[TASK PURGE OLD BACKUP FILES]"

class FileDeletionError(Exception):
    """Custom exception for file deletion errors."""
    pass

def delete_old_files(path, days_limit):
    limit_date = datetime.now() - timedelta(days=int(days_limit))

    for file in os.listdir(path):
        file_path = os.path.join(path, file)
        if os.path.isfile(file_path):
            creation_date = datetime.fromtimestamp(os.path.getctime(file_path))
            if creation_date < limit_date:
                try:
                    os.remove(file_path)
                    iris.cls("%SYS.System").WriteToConsoleLog(f"{event} Deleted: {str(file_path)}")
                except PermissionError:
                    raise FileDeletionError(f"Permission error: Unable to delete {file}")
                except FileNotFoundError:
                    raise FileDeletionError(f"File not found: {file}")
                except Exception as e:
                    raise FileDeletionError(f"Unexpected error while deleting {file}: {str(e)}")

try:
    iris.cls("%SYS.System").WriteToConsoleLog(f"{event} Executing task to delete backup files from directory {path} created more than {str(daysToKeep)} days ago")
    days_limit = daysToKeep
    delete_old_files(path, days_limit)
except FileDeletionError as e:
    iris.cls("%SYS.System").WriteToConsoleLog(f"{event} Error during deletion: {str(e)}",0,1)
except Exception as e:
    iris.cls("%SYS.System").WriteToConsoleLog(f"{event} Unexpected error: {str(e)}",0,1)
}

}
