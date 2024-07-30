import csv
import intersystems_iris as iris

host = "iris"
port = 1972
namespace = "IRISAPP"
user = "_SYSTEM"
password = "SYS"

conn = iris.connect(
                    hostname=host, 
                    port=port, 
                    namespace=namespace, 
                    username=user, 
                    password=password
                   )

cursor = conn.cursor()

# Lecture du fichier CSV source
with open('/data/CSV/test/data_source.csv', 'r', newline='', encoding='utf-8') as csvfile:
    reader = csv.DictReader(csvfile, delimiter=';')
    
    for row in reader:
        # Insertion dans la table Clients
        cursor.execute('''
            INSERT INTO data_target.Clients (id_client, nom, prenom, email)
            VALUES (?, ?, ?, ?)
        ''', (row['id_client'], row['nom'], row['prenom'], row['email']))
        
        # Insertion dans la table Commandes  
        cursor.execute('''
            INSERT INTO data_target.Commandes (id_commande, id_client, date_commande, montant)
            VALUES (?, ?, ?, ?)
        ''', (row['id_commande'], row['id_client'], row['date_commande'], row['montant']))
        
        # Insertion dans la table Produits
        cursor.execute('''
            INSERT INTO data_target.Produits (id_produit, nom_produit, prix)
            VALUES (?, ?, ?)
        ''', (row['id_produit'], row['nom_produit'], row['prix']))

# Validation des changements et fermeture de la connexion        
conn.commit()
conn.close()

print("Import terminé avec succès")