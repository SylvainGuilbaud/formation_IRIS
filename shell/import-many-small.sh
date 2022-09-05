export filename="response-import-many-small.json"
echo "deleting " $filename
rm -f $filename
curl -d "@../data/data-many-small.json" \
-H "Content-Type: application/json" \
-X POST http://localhost:12773/common/importjson \
-o $filename \
--user "_system:SYS"