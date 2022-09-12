export filename="response-update-$1-$2.json"
echo "deleting " $filename
rm -f $filename
curl -v -d "@$1-$2.json" \
-H "Content-Type: application/json" \
-X PUT http://127.0.0.1/crud/api/$1/$2 \
-o $filename \
--user "_system:SYS"