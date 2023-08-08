Class adm.tasks.data Extends %SYS.Task.Definition
{

Property file As %String [ InitialExpression = "c:\temp\data.csv" ];

Property globalName As %String [ InitialExpression = "^Sample.PersonD" ];

Property delimiter As %String [ InitialExpression = ";" ];

Method OnTask() As %Status
{
	return ##class(adm.data.utils).export(..file,..globalName,..delimiter)
}

}
