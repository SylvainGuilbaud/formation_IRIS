export filename="response-import-large.json"
echo "deleting " $filename
rm -f $filename
curl -d "@../data/data-import-large.json" \
-H "Content-Type: application/json" \
-X POST http://localhost:52773/common/import \
-o $filename \
--user "_system:SYS"