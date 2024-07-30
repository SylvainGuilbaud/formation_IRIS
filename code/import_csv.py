import os
import pandas as pd
from sqlalchemy import create_engine
import getpass
import iris
if not 'IRISNAMESPACE' in os.environ:
    os.environ['IRISNAMESPACE'] = input('set IRISNAMESPACE [IRISAPP] :') or "IRISAPP"
iris.system.Process.SetNamespace(os.environ['IRISNAMESPACE'])
engine = create_engine('iris+emb:///')
if not 'IRISUSERNAME' in os.environ:
    os.environ['IRISUSERNAME'] = input('set IRISUSERNAME [_SYSTEM] :') or "_SYSTEM"
if not 'IRISPASSWORD' in os.environ:
    os.environ['IRISPASSWORD'] = getpass.getpass('set IRISPASSWORD [SYS]:') or 'SYS'
if not 'IRISNAMESPACE' in os.environ:
    os.environ['IRISNAMESPACE'] = input('set IRISNAMESPACE [IRISAPP] :') or "IRISAPP"

schema_name = input('set IRISSCHEMA [data] :') or "data"
directory = input('set directory [/data/CSV/test] :') or "/data/CSV/test"

# Lister tous les fichiers dans le répertoire
files = [f for f in os.listdir(directory) if f.endswith('.csv')]

# Boucle pour lire chaque fichier CSV et l'insérer dans la base de données
for file in files:
    file_path = os.path.join(directory, file)
    # Lire le fichier CSV dans un DataFrame pandas
    df = pd.read_csv(file_path)
    # Insérer le DataFrame dans la base de données
    table_name = os.path.splitext(file)[0]  # Utiliser le nom du fichier sans l'extension comme nom de table
    df.to_sql(table_name, engine, schema=schema_name ,if_exists='replace', index=True)
    print(f"Le fichier {file} a été inséré dans la table {schema_name}.{table_name}.")

print("Tous les fichiers CSV ont été insérés dans la base de données.")