export filename="response-file-$1.json"
echo "deleting " $filename
rm -f $filename
curl -v -d "@../data/$1" \
-H "Content-Type: plain/text" \
-X POST http://10.30.254.1:52773/common/file/$1 \
-o $filename \
--user "_system:SYS"