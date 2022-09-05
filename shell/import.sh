export filename="response-import.json"
echo "deleting " $filename
rm -f $filename
curl -d "@../data/data-import.json" \
-H "Content-Type: application/json" \
-X POST http://localhost:12773/common/import \
-o $filename \
--user "_system:SYS"