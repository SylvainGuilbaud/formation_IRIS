export filename="response-file-$1.json"
echo "deleting " $filename
rm -f $filename
curl -v -d "@../data/$1" \
-H "Content-Type: plain/text" \
-X POST http://127.0.0.1:12775/common/file/$1 \
-o $filename