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

}
