Class python.csv
{

ClassMethod read() As %Status [ Language = python ]
{
import csv
with open('eggs.csv', newline='') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
    for row in spamreader:
        print(', '.join(row))
}

/// Import fichier CSV
ClassMethod importFile(filename As %String = "/data/CSV/test/data_source.csv") As %Status [ Language = python ]
{
import iris
# Chemin vers le fichier CSV ou URL
if filename == "":
    csv_source = "/data/CSV/test/data_source.csv"
csv_source = filename
# ou pour une URL :
# csv_source = "https://example.com/votre_fichier.csv"

# Nom de la table de destination
table_name = "MaTable"

# Nom du schéma (optionnel)
schema_name = "MonSchema"

# Importer le CSV
iris.cls("shvarov.csvgenpy.csv").Generate(csv_source, table_name, schema_name)

print("Import terminé avec succès")
}

}
