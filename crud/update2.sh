export filename="response-update2-$1-$2.json"
echo "deleting " $filename
rm -f $filename
curl -v -d "@../data/data.test-post.json" \
-H "Content-Type: application/json" \
-X UPDATE http://127.0.0.1/crud/api/$1/$2 \
-o $filename \
--user "_system:SYS"