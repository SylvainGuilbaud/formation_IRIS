export filename="loop-$1-xml.json"
echo "deleting " $filename
rm -f $filename

max=$1
for i in `seq 1 $max`
do
    echo $i
    ./import-xml-ID.sh 143
done