#!/bin/bash

ONYPHE="REPLACE_WITH_YOUR_APIKEY"

SEARCH=$1

if [ -z "$SEARCH" ]; then
	echo "Usage: $0 \"ONYPHE Query Language string\""
	exit 1
fi

if [[ "$SEARCH" =~ category:([a-z]+) ]]; then
	CATEGORY="${BASH_REMATCH[1]}"
else
	echo "*** ERROR: please start your search with category:CATEGORY"
	exit 2
fi

SEARCH=$(perl -MURI::Escape -e "print uri_escape('$SEARCH')")

MAX_PAGE=`curl -s -H "Authorization: apikey $ONYPHE" -H 'Content-Type: application/json' "https://www.onyphe.io/api/v2/search/$SEARCH" | jq .max_page`
if [ -z "$MAX_PAGE" ]; then
   echo "*** No result, aborting"
   exit 3
fi
if [ "$MAX_PAGE" = "null" ]; then
   echo "*** No result, aborting"
   exit 4
fi

echo "*** Last page: $MAX_PAGE"

for i in $(seq 1 $MAX_PAGE); do
	echo "*** Fetching page: $i"
	curl -s -H "Authorization: apikey $ONYPHE" -H 'Content-Type: application/json' "https://www.onyphe.io/api/v2/search/$SEARCH?page=$i" | jq '.results[]' -cM >> /tmp/$CATEGORY.json
	sleep 1
done
