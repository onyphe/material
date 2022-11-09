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

EXPORT=$(perl -MURI::Escape -e "print uri_escape('$SEARCH')")

curl -s -H "Authorization: apikey $ONYPHE" -H 'Content-Type: application/json' "https://www.onyphe.io/api/v2/export/$SEARCH" >> /tmp/$CATEGORY.json
