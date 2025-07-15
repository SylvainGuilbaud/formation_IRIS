# import oracledb
import pandas as pd
from sqlalchemy import create_engine
import sqlalchemy

import oracledb
# Connexion standard sans Oracle Client en mode Thin
# oracledb.init_oracle_client(lib_dir="/Users/guilbaud/Library/Oracle")  # Assurez-vous que le client Oracle est installé


# 1. Connexion à InterSystems IRIS
iris_engine = create_engine("iris://_SYSTEM:SYS@localhost:9091/USER")
print("Connexion à InterSystems IRIS réussie")

# 2. Connexion à Oracle
oracle_engine = create_engine("oracle+oracledb://SYSTEM:Oracle_123@localhost:1521/FREE")
print("Connexion à Oracle réussie")

# demande de source de données : IRIS ou Oracle
source = input("Quelle base de données source souhaitez-vous utiliser ? (IRIS/Oracle)\n").strip().lower()
if source not in ["iris", "oracle"]:
    print("Source de données non reconnue. Veuillez choisir 'IRIS' ou 'Oracle'.")
    exit(1) 

    
# demande le nom du schema source
# si source est IRIS, on demande le schema data
# si source est Oracle, on demande le schema C##SUPPLY
if source == "iris":
    schema_name_source = "data"
    schema_name_target = "C##SUPPLY"
elif source == "oracle":
    schema_name_source = "C##SUPPLY"
    schema_name_target = "data"

else:
    print("Source de données non reconnue. Veuillez choisir 'IRIS' ou 'Oracle'.")
    exit(1)
# demande le nom du schema source
# si source est IRIS, on demande le schema data
# si source est Oracle, on demande le schema C##SUPPLY
    
schema_name_source = input(f"Entrez le nom du schema source ({schema_name_source}) :\n").strip()
if not schema_name_source:
    print(f"Le nom du schema source ne peut pas être vide. Utilisation du schema par défaut : {schema_name_source}.")
    schema_name_source = "data" if source == "iris" else "C##SUPPLY"       
schema_name_source = input("Entrez le nom du schema source :\n").strip()

if not schema_name_source:
    print("Le nom du schema source ne peut pas être vide.")
    exit(1)

# demande le nom de la table source
table_name_source = input("Entrez le nom de la table source :\n").strip()
if not table_name_source:
    print("Le nom de la table source ne peut pas être vide.")
    exit(1)
# demande le nom de la table cible
table_name_target = input("Entrez le nom de la table cible :\n").strip()
if not table_name_target:
    print("Le nom de la table cible ne peut pas être vide.")
    exit(1)
    
# si la source est IRIS, on lit la table depuis IRIS
if source == "iris":
    try:
        df = pd.read_sql_table(table_name_source, iris_engine, schema=schema_name_source)
    except sqlalchemy.exc.NoSuchTableError:
        print(f"La table '{table_name_source}' n'existe pas dans la base de données InterSystems IRIS.")
        exit(1)
# si la source est Oracle, on lit la table depuis Oracle
elif source == "oracle":
    try:
        df = pd.read_sql_table(table_name_source, oracle_engine, schema=schema_name_source)
    except sqlalchemy.exc.NoSuchTableError:
        print(f"La table '{table_name_source}' n'existe pas dans la base de données Oracle.")
        exit(1)    

print(df.head())

# 3. Transfert des données vers la base de données cible
# si source est IRIS, on transfère vers Oracle
# si source est Oracle, on transfère vers IRIS
if source == "iris":
    # On utilise le moteur Oracle pour écrire dans la base de données cible
    df.to_sql(
        table_name_target, 
        con=oracle_engine, 
        if_exists="replace", 
        index=False,
        schema=schema_name_target
    )
elif source == "oracle":
    # On utilise le moteur IRIS pour écrire dans la base de données cible
    df.to_sql(
        table_name_target, 
        con=iris_engine, 
        if_exists="replace", 
        index=False,
        schema=schema_name_target 
    )
# Affichage du nombre de lignes transférées
print(f"{len(df)} lignes transférées de {source.upper()} vers {schema_name_target}.{table_name_target}.")

# 4. Fermeture des connexions
iris_engine.dispose()
oracle_engine.dispose()
print("Connexions fermées.")