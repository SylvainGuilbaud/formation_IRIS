Class web.zen.tablePane Extends %ZEN.Component.page
{

XData Contents [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<page xmlns="http://www.intersystems.com/zen" title="">
<html id="title">Sample.Person</html>
<hgroup>
    <text label='Name' value="A" id="inputName" onchange="zenPage.changeParams()"/> 
    <text label='AgeMin' value="1" id="inputAgeMin" onchange="zenPage.changeParams()"/> 
    <text label='AgeMax' value="130" id="inputAgeMax" onchange="zenPage.changeParams()"/> 
</hgroup>
    <tablePane id="table" showQuery='true' countRows='true' showRowNumbers='true' useSnapshot='true' showRowSelector='false'
        sql="SELECT ID,Name,age,to_char(dob,'Day DD Month YYYY') as Date_of_Birth  FROM Sample.person
            WHERE Name %STARTSWITH ? 
            AND age between ? and ?
            ORDER BY Age"
    >
    <parameter value="A" id="pName"/>
    <parameter value="0" id="pAgeMin"/>
    <parameter value="130" id="pAgeMax"/>
    </tablePane>      
</page>
}

ClientMethod changeParams() [ Language = javascript ]
{
     // find the tablePane component
     var table = zenPage.getComponentById('table');
     var pName = zenPage.getComponentById("pName");
     var pAgeMin = zenPage.getComponentById("pAgeMin");
     var pAgeMax = zenPage.getComponentById("pAgeMax");


     pName.value=zenPage.getComponentById('inputName').value;
     pAgeMin.value=zenPage.getComponentById('inputAgeMin').value;
     pAgeMax.value=zenPage.getComponentById('inputAgeMax').value;

     table.executeQuery();
}

}
