import time
from datetime import datetime, timedelta

# Chemin du répertoire contenant les fichiers à supprimer
chemin = "/chemin/vers/votre/repertoire"

# Date limite (par exemple, supprimer les fichiers créés il y a plus de 30 jours)
date_limite = datetime.now() - timedelta(days=30)

for fichier in os.listdir(chemin):
    chemin_fichier = os.path.join(chemin, fichier)
    if os.path.isfile(chemin_fichier):
        date_creation = datetime.fromtimestamp(os.path.getctime(chemin_fichier))
        if date_creation < date_limite:
            try:
                os.remove(chemin_fichier)
                print(f"Fichier supprimé : {fichier}")
            except PermissionError:
                print(f"Erreur de permission : Impossible de supprimer {fichier}")
            except FileNotFoundError:
                print(f"Fichier non trouvé : {fichier}")