#!/bin/bash
DAYS=2
DateToCompare="$(date +%Y%m%d -d $DAYS" days ago")"
array=( $(curl "http://192.168.76.241:9200/_stats" | grep -o 'logstash\-[[:digit:]]\{4\}\.[[:digit:]]\{2\}\.[[:digit:]]\{2\}') )
for index in "${array[@]}"
do
  indexdate="$(echo $index| grep -o '[[:digit:]]\{4\}\.[[:digit:]]\{2\}\.[[:digit:]]\{2\}' |sed -e 's/\.//g')"
  if ((DateToCompare > indexdate)) ;  then
    echo "Deleting index $index"
    curl -X DELETE "http://192.168.76.241:9200/$index"
  else
    echo "The $index index is relevant"
  fi
done
