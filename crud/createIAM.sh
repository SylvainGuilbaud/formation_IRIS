export filename="response-createIAM-$1.json"
echo "deleting " $filename
rm -f $filename
# curl -v \
# -d "@../data/data.test-all.json" \
curl -v \
-d "@../data/data.test-post.json" \
-H "Content-Type: application/json" \
-X POST http://127.0.0.1:8000/formation/crud/api/$1 \
-o $filename 