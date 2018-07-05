for f in *.json; do mongoimport --port $1 --db ebay --collection items  $f  --jsonArray; done
