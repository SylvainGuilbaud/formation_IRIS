Class transfo.ambulance.choixPDA2A Extends Ens.DataTransformDTL [ DependsOn = (ambulance.RM.choixPDA2A, ambulance.msg.choixPDA2A) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='ambulance.RM.choixPDA2A' targetClass='ambulance.msg.choixPDA2A' create='new' language='objectscript' >
<if condition='&apos;##class(ambulance.msg.choixPDA2A).%ExistsId(source.episode)' >
<true>
<assign value='source.episode' property='target.episode' action='set' />
</true>
<false>
<assign value='##class(ambulance.msg.choixPDA2A).%OpenId(source.episode)' property='target' action='set' />
</false>
</if>
<assign value='source.adresse' property='target.adresse' action='set' />
<trace value='target.%Id()' />
</transform>
}

}
