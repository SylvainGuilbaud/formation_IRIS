import json
from dataclasses import dataclass

@dataclass
class Adresse:
    rue: str
    ville: str
    code_postal: str

@dataclass
class Personne:
    nom: str
    age: int
    adresse: Adresse
    interets: list
    telephone: str = None

def transform(source_content):
    # Lire le contenu JSON depuis le flux source
    json_string = source_content.read()
    
    # Parser le JSON en dictionnaire Python
    json_obj = json.loads(json_string)
    
    # Créer et mapper l'adresse
    adresse = Adresse(
        rue=json_obj['adresse']['rue'],
        ville=json_obj['adresse']['ville'],
        code_postal=json_obj['adresse']['codePostal']
    )
    
    # Créer et mapper la personne
    personne = Personne(
        nom=json_obj['nom'],
        age=json_obj['age'],
        adresse=adresse,
        interets=json_obj['interets']
    )
    
    # Mapper le téléphone s'il existe
    if 'telephone' in json_obj:
        personne.telephone = json_obj['telephone']
    
    return personne

# Exemple d'utilisation
if __name__ == "__main__":
    # Simuler un flux de contenu source
    class SourceContent:
        def read(self):
            return '''
            {
                "nom": "Dupont",
                "age": 30,
                "adresse": {
                    "rue": "123 Rue de la Paix",
                    "ville": "Paris",
                    "codePostal": "75001"
                },
                "interets": ["lecture", "voyage", "cuisine"],
                "telephone": "0123456789"
            }
            '''
    
    source = SourceContent()
    resultat = transform(source)
    print(resultat)