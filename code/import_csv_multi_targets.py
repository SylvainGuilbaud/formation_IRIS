import pandas as pd
from sqlalchemy import create_engine, text,types,engine
# conn = create_engine('iris+emb:///')
conn = create_engine('iris://_SYSTEM:SYS@iris:1972/IRISAPP')
schema_name = "data_target"

# Lecture du fichier CSV
df = pd.read_csv('/data/CSV/test/data_source.csv', delimiter=';')

# Création des DataFrames pour chaque table
df_clients = df[['id_client', 'nom', 'prenom', 'email']].drop_duplicates()
df_commandes = df[['id_commande', 'id_client', 'date_commande', 'montant']]
df_produits = df[['id_produit', 'nom_produit', 'prix']].drop_duplicates()

# Insertion des données dans les tables
df_clients.to_sql('Clients', conn, schema=schema_name,  if_exists='append', index=False)
df_commandes.to_sql('Commandes', conn, schema=schema_name,  if_exists='append', index=False)
df_produits.to_sql('Produits', conn, schema=schema_name, if_exists='append', index=False)

print("Import terminé avec succès")