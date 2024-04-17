/// 
Class python.process.demo Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='python' request='Ens.StringRequest' response='Ens.StringResponse' height='2000' width='2000' >
<pyFromImport>
import requests
</pyFromImport>
<sequence xend='200' yend='1050' >
<switch name='What Drink' xpos='200' ypos='250' xend='200' yend='500' >
<annotation><![CDATA[looking for Drink keyword in request]]></annotation>
<case condition='request.StringValue.lower().find("coffee")&gt;0' name='is coffee' languageOverride='python' >
<assign name="Coffe" property="response.StringValue" value="&quot;Coffee&quot;" action="set" languageOverride="objectscript" xpos='200' ypos='400' />
</case>
<case condition='request.StringValue.lower().find("tea")&gt;0' name='is tea' languageOverride='python' >
<assign name="Tea" property="response.StringValue" value="&quot;Tea&quot;" action="set" languageOverride="objectscript" xpos='470' ypos='400' />
</case>
<default>
<assign name="Chocolate" property="response.StringValue" value="&quot;Chocolate&quot;" action="set" languageOverride="objectscript" xpos='740' ypos='400' />
</default>
</switch>
<if name='Is White' condition='request.StringValue.lower().find("black")==-1' languageOverride="python" xpos='200' ypos='600' xend='200' yend='850' >
<annotation><![CDATA[looking for absence of keyword "black" in request]]></annotation>
<true>
<assign name="Add Milk" property="response.StringValue" value="response.StringValue + &quot; MILK&quot;" action="set" languageOverride="python" xpos='335' ypos='750' />
</true>
</if>
<assign name="Add Hot Water" property="response.StringValue" value="response.StringValue + &quot; HOT WATER&quot;" action="set" languageOverride="python" xpos='200' ypos='950' />
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
