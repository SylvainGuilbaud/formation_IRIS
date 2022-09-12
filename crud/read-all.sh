export filename="$1-all.json"
echo "deleting " $filename
rm -f $filename
curl -v \
-H "Content-Type: application/json" \
-X GET http://127.0.0.1/crud/api/$1 \
-o $filename \
--user "_system:SYS"