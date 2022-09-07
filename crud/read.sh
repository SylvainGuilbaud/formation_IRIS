export filename="$1-$2.json"
echo "deleting " $filename
rm -f $filename
curl -v \
-H "Content-Type: application/json" \
-X GET http://127.0.0.1/crud/$1/$2 \
-o $filename \
--user "_system:SYS"