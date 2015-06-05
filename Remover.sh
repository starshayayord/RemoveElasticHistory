#!/bin/bash
while [[ $# > 0 ]]
do
key="$1"

case $key in
    -d|--days)
    DAYS="$2"
    shift # past argument
    ;;
    -p|--port)
    EPORT="$2"
    shift # past argument
    ;;
    -h|--host)
    EHOST="$2"
    shift # past argument
    ;;
    *)
     echo "ERROR: Wrong command line parameter"
     exit 1       # unknown option
    ;;
esac
shift # past argument or value
done
DateToCompare="$(date +%Y%m%d -d "${DAYS} days ago")"
array=( $(curl "http://${EHOST}:${EPORT}/_stats" | grep -o 'logstash\-[[:digit:]]\{4\}\.[[:digit:]]\{2\}\.[[:digit:]]\{2\}') )
for index in "${array[@]}"
do
indexdate="$(echo $index| grep -o '[[:digit:]]\{4\}\.[[:digit:]]\{2\}\.[[:digit:]]\{2\}' |sed -e 's/\.//g')"
if ((DateToCompare > indexdate)) ;  then
    echo "Deleting index $index"
    curl -X DELETE "${EHOST}:${EPORT}/$index"
  else
    echo "The $index index is relevant"
  fi
done
