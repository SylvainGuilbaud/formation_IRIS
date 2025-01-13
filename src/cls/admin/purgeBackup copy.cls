Class admin.purgeBackup Extends %SYS.Task.Definition
{

Property Directory As %String(MAXLEN = 2000) [ InitialExpression = "/usr/irissys/mgr/Backup" ];

Property DaysToKeep As %Integer(VALUELIST = ",0,1,2,3,4,5") [ InitialExpression = "1" ];

Method OnTask() As %Status
{
    set sc = $$$OK
    Try {
        do ##class(admin.purgeBackup).purge(..Directory,..DaysToKeep)
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    return sc
}

ClassMethod purge(chemin As %String, daysToKeep As %Integer) As %Status [ Language = python ]
{
import iris
import os
import time
from datetime import datetime, timedelta

class FichierSuppressionError(Exception):
    """Exception personnalisée pour les erreurs de suppression de fichiers."""
    pass

def supprimer_fichiers_anciens(chemin, jours_limite):
    date_limite = datetime.now() - timedelta(days=int(jours_limite))

    for fichier in os.listdir(chemin):
        chemin_fichier = os.path.join(chemin, fichier)
        if os.path.isfile(chemin_fichier):
            date_creation = datetime.fromtimestamp(os.path.getctime(chemin_fichier))
            if date_creation < date_limite:
                try:
                    os.remove(chemin_fichier)
                    iris.cls("%SYS.System").WriteToConsoleLog(f"suppression de : {str(chemin_fichier)}")
                except PermissionError:
                    raise FichierSuppressionError(f"Erreur de permission : Impossible de supprimer {fichier}")
                except FileNotFoundError:
                    raise FichierSuppressionError(f"Fichier non trouvé : {fichier}")
                except Exception as e:
                    raise FichierSuppressionError(f"Erreur inattendue lors de la suppression de {fichier}: {str(e)}")

try:
    iris.cls("%SYS.System").WriteToConsoleLog(f"exécution de la tâche de suppression des fichiers de sauvegarde du répertoire {chemin} créés il y a plus de {str(daysToKeep)} jours")
    jours_limite = daysToKeep
    supprimer_fichiers_anciens(chemin, jours_limite)
except FichierSuppressionError as e:
    iris.cls("%SYS.System").WriteToConsoleLog(f"Erreur lors de la suppression : {str(e)}",0,1)
except Exception as e:
    iris.cls("%SYS.System").WriteToConsoleLog(f"Erreur inattendue : {str(e)}",0,1)
}

}
