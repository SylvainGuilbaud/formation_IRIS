export filename="response-import-3.json"
echo "deleting " $filename
rm -f $filename
curl -d "@../data/data-import-3.json" \
-H "Content-Type: application/json" \
-X POST http://localhost:52773/common/importjson \
-o $filename \
--user "_system:SYS"