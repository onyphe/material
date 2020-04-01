#!/bin/bash

ONYPHE="REPLACE_WITH_YOUR_APIKEY"

SEARCH=$1

if [ -z "$SEARCH" ]; then
	echo "Usage: $0 \"ONYPHE Query String\""
	exit 1
fi

MAX_PAGE=`curl -s -H "Authorization: apikey $ONYPHE" -H 'Content-Type: application/json' "https://www.onyphe.io/api/v2/search/category:datascan%20$SEARCH" | jq .max_page`
if [ "$MAX_PAGE" = "null" ]; then
	echo "*** No result, aborting"
	exit 2
fi

echo "*** Last page: $MAX_PAGE"

for i in $(seq 1 $MAX_PAGE); do
	echo "*** Fetching page: $i"
	curl -s -H "Authorization: apikey $ONYPHE" -H 'Content-Type: application/json' "https://www.onyphe.io/api/v2/search/category:datascan%20$SEARCH?page=$i" | jq '.results[]' -cM >> /tmp/datascan.json
	sleep 1
done
