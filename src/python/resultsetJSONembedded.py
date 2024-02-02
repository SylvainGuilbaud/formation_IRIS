import os
import getpass
if not 'IRISUSERNAME' in os.environ:
    os.environ['IRISUSERNAME'] = input('set IRISUSERNAME [_SYSTEM] :') or "_SYSTEM"
if not 'IRISPASSWORD' in os.environ:
    os.environ['IRISPASSWORD'] = getpass.getpass('set IRISPASSWORD [SYS]:') or 'SYS'
if not 'IRISNAMESPACE' in os.environ:
    os.environ['IRISNAMESPACE'] = input('set IRISNAMESPACE [IRISAPP] :') or "IRISAPP"
import iris
import json
query = "SELECT top 3 name,age,to_char(dob,'Day DD Month YYYY') FROM sample.person"
rs=iris.sql.exec(query)

list = []
for idx, x in enumerate(rs):
    row = {"name":x[0],"age":x[1],"dob":x[2]}
    list.append(row)
result = {"results":len(list),"items":list}
print(json.dumps(result))
