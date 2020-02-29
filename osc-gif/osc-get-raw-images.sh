#!/bin/bash
url="https://openstreetcam.org/details"
header="access_token=0b6cf293c5f031815293f3fa19ebe75834c4f4b719b57975caed05d4297b876c&id=$1"
curl $url --data $header -o osc_$1.json
cat osc_$1.json | jq ".osv.photos[].name" | xargs -I{} echo "www.openstreetcam.org/"{} >>urls_$1.txt 
cat urls_$1.txt | xargs -n 1 -P 100 wget
# to avoid redownloading the same image URLs
mv urls_$1.txt urls_$1_old.txt
