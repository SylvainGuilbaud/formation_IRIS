export filename="response-create-$1.json"
echo "deleting " $filename
rm -f $filename
curl -v -d "@../data/data.test.json" \
-H "Content-Type: application/json" \
-X POST http://127.0.0.1:52773/formation/formation/crud/api/$1 \
-o $filename \
--user "CRUD:CRUD"