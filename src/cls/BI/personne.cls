Class BI.personne Extends %DeepSee.DataConnector
{

XData SourceQuery [ XMLNamespace = "http://www.intersystems.com/deepsee/connector/query" ]
{
<sql>
SELECT 
id, LastName, FirstName, DOB, Sex, FirstAction, LastAction
FROM mysql.personne
</sql>
}

/// This XData definition defines the output of this connector.
XData Output [ XMLNamespace = "http://www.intersystems.com/deepsee/connector/output" ]
{
<connector> 
<property name="ID" displayName="ID" idKey="true"
sourceProperty="ID" /> 

<property name="LastName" displayName="LastName" 
sourceProperty="LastName" /> 

<property name="FirstName" displayName="FirstName" 
sourceProperty="FirstName" /> 

<property name="DOB" displayName="DOB" 
sourceProperty="DOB" type="%Date"/>

<property name="Sex" displayName="Sex" 
sourceProperty="Sex"/>

<property name="FirstAction" displayName="FirstAction" 
sourceProperty="FirstAction"  />

<property name="LastAction" displayName="LastAction" 
sourceProperty="LastAction" />

</connector>
}

}
