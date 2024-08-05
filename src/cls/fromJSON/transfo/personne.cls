Class fromJSON.transfo.personne Extends Ens.DataTransform
{

ClassMethod Transform(source As fromJSON.source.message, target As fromJSON.target.personne) As %Status
{
    // Lire le contenu JSON depuis le flux source
    set jsonString = ""
    while 'source.content.AtEnd {
        set jsonString = jsonString _ source.content.Read()
    }
    
    // Parser le JSON en DynamicObject
    set jsonObj = {}.%FromJSON(jsonString)
    
    // Mapper les propriétés JSON vers les propriétés de la classe de message
    set target.Nom = jsonObj.nom
    set target.Age = jsonObj.age
    
    // Créer et mapper l'adresse
    set adresse = ##class(fromJSON.target.adresse).%New()
    set adresse.Rue = jsonObj.adresse.rue
    set adresse.Ville = jsonObj.adresse.ville
    set adresse.CodePostal = jsonObj.adresse.codePostal
    set target.Adresse = adresse
    
    // Mapper les intérêts
    set interets = jsonObj.interets
    for i=0:1:interets.%Size()-1 {
      do target.Interets.Insert(interets.%Get(i))
    }
    
    // Mapper le téléphone
    if (jsonObj.%IsDefined("telephone")) {
      set target.Telephone = jsonObj.telephone
    }
    
    // Retourner le statut de succès
    Quit $$$OK
}

ClassMethod TransformPy(source As fromJSON.source.message, target As fromJSON.target.personne) As %Status [ Language = python ]
{
    import iris
    import json

    def transform(source_content):
        # Lire le contenu JSON depuis le flux source
        json_string = ""
        while not source_content.AtEnd:
            json_string += source_content.Read()
        
        # Parser le JSON en dictionnaire Python
        json_obj = json.loads(json_string)
        
        # Créer et mapper la personne
        personne = iris.cls('fromJSON.target.personne')._New()
        personne.Nom = json_obj['nom']
        personne.Age = json_obj['age']
        
        # Créer et mapper l'adresse
        adresse = iris.cls('fromJSON.target.adresse')._New()
        adresse.Rue = json_obj['adresse']['rue']
        adresse.Ville = json_obj['adresse']['ville']
        adresse.CodePostal = json_obj['adresse']['codePostal']
        personne.Adresse = adresse
        
        # Mapper les intérêts
        for interet in json_obj['interets']:
            personne.Interets.Insert(interet)
        
        # Mapper le téléphone s'il existe
        if 'telephone' in json_obj:
            personne.Telephone = json_obj['telephone']
        
        return personne

    # Appeler la fonction transform
    resultat = transform(source.content)

    # Copier les propriétés du résultat vers l'objet target
    target.Nom = resultat.Nom
    target.Age = resultat.Age
    target.Adresse = resultat.Adresse
    target.Telephone = resultat.Telephone

    # Copier les intérêts
    for i in range(resultat.Interets.Count()):
        target.Interets.Insert(resultat.Interets.GetAt(i+1))

    # Retourner le statut de succès
    return 1  # Équivalent à $$$OK en ObjectScript
}

}
