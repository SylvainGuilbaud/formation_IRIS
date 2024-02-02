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

truncate = input("truncate [no]:") or 'no'
if truncate == 'yes':
    print("deleting all rows in Sample.Person")
    iris.cls('Sample.Person')._DeleteExtent()

query = "SELECT count(*) FROM sample.person"
rs=iris.sql.exec(query)

for idx, row in enumerate(rs):
    if row[0]==0:
        iris.cls('Sample.Person').Populate(10)

query = "SELECT top 5 name,age,to_char(dob,'Day DD Month YYYY') FROM sample.person order by id desc"
rs=iris.sql.exec(query)

list = []
for idx, x in enumerate(rs):
    row = {"name":x[0],"age":x[1],"dob":x[2]}
    list.append(row)
    count=idx+1
result = {"results":count,"items":list}
print(json.dumps(result))
