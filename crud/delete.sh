export filename="response-delete-$1-$2.json"
echo "deleting " $filename
rm -f $filename
curl -v \
-H "Content-Type: application/json" \
-X DELETE http://127.0.0.1/crud/api/$1/$2 \
-o $filename \
--user "_system:SYS"