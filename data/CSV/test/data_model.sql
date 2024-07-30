CREATE TABLE IF NOT EXISTS data_target.Clients (
    id_client INTEGER PRIMARY KEY,
    nom TEXT,
    prenom TEXT,
    email TEXT
);

CREATE TABLE IF NOT EXISTS data_target.Commandes (
    id_commande INTEGER PRIMARY KEY,
    id_client INTEGER,
    date_commande TEXT,
    montant REAL,
    FOREIGN KEY (id_client) REFERENCES data_target.Clients(id_client)
);

CREATE TABLE IF NOT EXISTS data_target.Produits (
    id_produit INTEGER PRIMARY KEY,
    nom_produit TEXT,
    prix REAL
);