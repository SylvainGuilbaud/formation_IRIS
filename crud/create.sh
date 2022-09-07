export filename="response-create-$1.json"
echo "deleting " $filename
rm -f $filename
curl -v -d "@../data/data.test-post.json" \
-H "Content-Type: application/json" \
-X POST http://127.0.0.1/crud/$1 \
-o $filename \
--user "_system:SYS"