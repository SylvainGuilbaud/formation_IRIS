export filename="response-read-allIAM-$1.json"
echo "deleting " $filename
rm -f $filename
curl -v \
-H "Content-Type: application/json" \
-X GET http://127.0.0.1:8000/formation/crud/api/$1 \
-o $filename 