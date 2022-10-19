export filename="readIAM-$1-$2.json"
echo "deleting " $filename
rm -f $filename
curl -v \
-H "Content-Type: application/json" \
-X GET http://127.0.0.1:8000/crud/api/$1/$2 \
-o $filename \
--user "CRUD:CRUD"