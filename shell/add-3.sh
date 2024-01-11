export filename="response-add.json"
echo "deleting " $filename
rm -f $filename
curl -d '{"filename":"/tmp/IRIS.pdf"}' \
-H "Content-Type: application/json" \
-X POST http://localhost:52773/common/add \
-o $filename \
--user "_system:SYS"

curl -d '{"filename":"/tmp/InterSystems IRIS Migration Guide-V2.87-2022_06_10.pdf"}' \
-H "Content-Type: application/json" \
-X POST http://localhost:52773/common/add \
-o $filename \
--user "_system:SYS"

curl -d '{"filename":"/usr/irissys/csp/sys/images/logo-topl-intersystems.gif"}' \
-H "Content-Type: application/json" \
-X POST http://localhost:52773/common/add \
-o $filename \
--user "_system:SYS"