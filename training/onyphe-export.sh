#!/bin/bash

ONYPHE="REPLACE_WITH_YOUR_APIKEY"
AUTH=""

CURL=curl
APIURL=https://www.onyphe.io/api/v2
if [ "$AUTH" ]; then
   CURL="curl --basic -u $AUTH"
   APIURL=https://www.onyphe.io/unrated/api/v2
fi

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

$CURL -s -H 'Content-Type: application/json' "$APIURL/export/$SEARCH?k=$ONYPHE" >> /tmp/$CATEGORY.json
