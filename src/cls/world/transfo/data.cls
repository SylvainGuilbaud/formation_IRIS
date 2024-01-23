Class world.transfo.data Extends Ens.DataTransformDTL [ DependsOn = world.data ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='world.data' targetClass='world.data' create='new' language='objectscript' >
<assign value='source.Country' property='target.Country' action='set' />
<assign value='source.AgriculturalLand' property='target.AgriculturalLand' action='set' />
<assign value='source.BirthRate' property='target.BirthRate' action='set' />
</transform>
}

}
