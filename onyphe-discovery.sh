#!/bin/bash

ONYPHE="REPLACE_WITH_YOUR_APIKEY"
AUTH=""

CURL=curl
APIURL=https://www.onyphe.io/api/v2
if [ "$AUTH" ]; then
   CURL="curl --basic -u $AUTH"
   APIURL=https://www.onyphe.io/unrated/api/v2
fi

CATEGORY=$1
INPUT=$2

if [ -z "$CATEGORY" ]; then
   echo "Usage: $0 \"category\" \"input file\""
   exit 1
fi

if [ -z "$INPUT" ]; then
   echo "Usage: $0 \"category\" \"input file\""
   exit 1
fi

$CURL -s -XPOST -H 'Content-Type: application/json' "$APIURL/bulk/discovery/$CATEGORY/asset?keepalive=true&size=10000&k=$ONYPHE" --data-binary @$INPUT | grep -v '"@category":"none"' >> /tmp/$CATEGORY.json
