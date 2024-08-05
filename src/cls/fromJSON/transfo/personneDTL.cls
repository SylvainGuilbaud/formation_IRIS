Class fromJSON.transfo.personneDTL Extends Ens.DataTransformDTL [ DependsOn = (fromJSON.source.message, fromJSON.target.personne) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='fromJSON.source.message' targetClass='fromJSON.target.personne' targetDocType='jsonObj.adresse.ville' create='new' language='objectscript' >
<code>
<![CDATA[    set jsonString = ""
    while 'source.content.AtEnd {
        set jsonString = jsonString _ source.content.Read()
    }
    set jsonObj = {}.%FromJSON(jsonString)]]></code>
<trace value='jsonString' />
<code>
<![CDATA[ do source.content.Rewind()]]></code>
<assign value='jsonObj.nom' property='target.Nom' action='set' />
<assign value='jsonObj.age' property='target.Age' action='set' />
<assign value='jsonObj.adresse.rue' property='target.Adresse.Rue' action='set' />
<assign value='jsonObj.adresse.ville' property='target.Adresse.Ville' action='set' />
<assign value='jsonObj.adresse.codePostal' property='target.Adresse.CodePostal' action='set' />
<code>
<![CDATA[  set interets = jsonObj.interets
    for i=0:1:interets.%Size()-1 {
      do target.Interets.Insert(interets.%Get(i))
    }]]></code>
<if condition='jsonObj.%IsDefined("telephone")' >
<true>
<assign value='jsonObj.telephone' property='target.Telephone' action='set' />
</true>
</if>
</transform>
}

}
