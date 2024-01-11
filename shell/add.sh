export filename="response-add.json"
echo "deleting " $filename
rm -f $filename
curl -d "@../data/data-add.json" \
-H "Content-Type: application/json" \
-X POST http://localhost:52773/common/add \
-o $filename \
--user "_system:SYS"