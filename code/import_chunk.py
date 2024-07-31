import pandas as pd
from sqlalchemy import create_engine, text,types,engine
# conn = create_engine('iris+emb:///')
conn = create_engine('iris://_SYSTEM:SYS@iris:1972/IRISAPP')
schema_name = "data_target"

# Définir le chemin du fichier CSV
chemin_fichier = '/data/CSV/test/data_source.csv'

# Définir la taille du chunk (par exemple, 10 000 lignes à la fois)
taille_chunk = 10000

# Initialiser un compteur pour suivre le nombre total de lignes traitées
total_lignes = 0

# Utiliser read_csv avec chunksize
for chunk in pd.read_csv(chemin_fichier, chunksize=taille_chunk, delimiter=';'):
    # Traiter chaque chunk ici
    # Par exemple, vous pouvez effectuer des opérations sur le chunk
    
    # Compter le nombre de lignes dans ce chunk
    lignes_dans_chunk = len(chunk)
    
    # Ajouter au total
    total_lignes += lignes_dans_chunk
    
    # Exemple de traitement : afficher les 5 premières lignes de chaque chunk
    print(f"Aperçu du chunk (5 premières lignes) :")
    print(chunk.head())
    
    # Exemple de traitement : calculer la moyenne d'une colonne
    if 'montant' in chunk.columns:
        moyenne = chunk['montant'].mean()
        print(f"Moyenne de 'montant' dans ce chunk : {moyenne}")
    
    print(f"Lignes traitées dans ce chunk : {lignes_dans_chunk}")
    print("--------------------")
    chunk.to_sql('testImport', conn, schema=schema_name,  if_exists='append', index=False)


# Afficher le nombre total de lignes traitées
print(f"Nombre total de lignes traitées : {total_lignes}")