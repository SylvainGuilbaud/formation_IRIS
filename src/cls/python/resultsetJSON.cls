Class python.resultsetJSON
{

/// Description
ClassMethod run() As %Status [ Language = python ]
{
import iris
import json

cursorIRIS = iris.cursor()

query = "SELECT top 3 name,age,to_char(dob,'Day DD Month YYYY') FROM sample.person"
cursorIRIS.execute(query)
 
resultSet = cursorIRIS.fetchall()

list = []
result = {"results":len(resultSet),"items":list}
for x in resultSet:
    row = {"name":x[0],"age":x[1],"dob":x[2]}
    list.append(row)
print(json.dumps(result))
}

}
