import os
import time
from datetime import datetime, timedelta

class FichierSuppressionError(Exception):
    """Exception personnalisée pour les erreurs de suppression de fichiers."""
    pass

def supprimer_fichiers_anciens(chemin, jours_limite):
    date_limite = datetime.now() - timedelta(days=jours_limite)

    for fichier in os.listdir(chemin):
        chemin_fichier = os.path.join(chemin, fichier)
        if os.path.isfile(chemin_fichier):
            date_creation = datetime.fromtimestamp(os.path.getctime(chemin_fichier))
            if date_creation < date_limite:
                try:
                    os.remove(chemin_fichier)
                except PermissionError:
                    raise FichierSuppressionError(f"Erreur de permission : Impossible de supprimer {fichier}")
                except FileNotFoundError:
                    raise FichierSuppressionError(f"Fichier non trouvé : {fichier}")
                except Exception as e:
                    raise FichierSuppressionError(f"Erreur inattendue lors de la suppression de {fichier}: {str(e)}")

# Utilisation de la fonction
try:
    chemin = "/usr/irissys/mgr/Backup"
    jours_limite = 30
    supprimer_fichiers_anciens(chemin, jours_limite)
except FichierSuppressionError as e:
    print(f"Erreur lors de la suppression : {str(e)}")
except Exception as e:
    print(f"Erreur inattendue : {str(e)}")