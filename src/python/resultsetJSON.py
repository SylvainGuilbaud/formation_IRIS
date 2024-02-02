import iris
import json
import getpass
import os
hostname = input("hostname [localhost]:") or "localhost"
port = input("port [1972]:") or "1972"
if 'IRISUSERNAME' in os.environ:
    username = os.environ['IRISUSERNAME']
else:
    username = input('login [_SYSTEM] :') or "_SYSTEM"
if 'IRISPASSWORD' in os.environ:
    password = os.environ['IRISPASSWORD']
else:
    password = getpass.getpass('password [SYS]:') or 'SYS'
if 'IRISNAMESPACE' in os.environ:
    namespace = os.environ['IRISNAMESPACE']
else:
    namespace = input('namespace [IRISAPP] :') or "IRISAPP"
connection_string = hostname + ":" + port + "/" + namespace
connectionIRIS = iris.connect(connection_string, username, password)
cursorIRIS = connectionIRIS.cursor()
print("Connected to",connection_string)

query = "SELECT top 3 name,age,to_char(dob,'Day DD Month YYYY') FROM sample.person"
cursorIRIS.execute(query)
 
resultSet = cursorIRIS.fetchall()

list = []
result = {"results":len(resultSet),"items":list}
for x in resultSet:
    row = {"name":x[0],"age":x[1],"dob":x[2]}
    list.append(row)
print(json.dumps(result))
 
connectionIRIS.close()
