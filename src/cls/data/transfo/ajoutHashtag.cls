Class data.transfo.ajoutHashtag Extends Ens.DataTransformDTL [ DependsOn = (data.RM.customer.Batch, data.EXTERNAL.customer.Batch) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='data.RM.customer.Batch' targetClass='data.EXTERNAL.customer.Batch' create='new' language='objectscript' >
<foreach property='source.Records()' key='k1' >
<assign value='source.Records.(k1).id' property='target.records.(k1).id' action='set' />
<assign value='source.Records.(k1).active' property='target.records.(k1).active' action='set' />
<assign value='source.Records.(k1).category' property='target.records.(k1).category' action='set' />
<assign value='source.Records.(k1).city' property='target.records.(k1).city' action='set' />
<assign value='source.Records.(k1).created' property='target.records.(k1).created' action='set' />
<assign value='source.Records.(k1).firstName' property='target.records.(k1).firstName' action='set' />
<assign value='source.Records.(k1).lastName' property='target.records.(k1).lastName' action='set' />
<assign value='$system.Encryption.SHA1Hash(target.records.(k1).firstName_" "_target.records.(k1).lastName)' property='target.records.(k1).hashtag' action='set' />
</foreach>
</transform>
}

}
