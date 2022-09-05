export filename="response-import-ID-$1-xml.json"
echo "deleting " $filename
rm -f $filename
curl -d "@../data/$1.xml" \
-H "Content-Type: plain/text" \
-X POST http://127.0.0.1:12773/common/import \
-o $filename \
--user "_system:SYS"