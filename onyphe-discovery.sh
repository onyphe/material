#!/bin/bash

ONYPHE="REPLACE_WITH_YOUR_APIKEY"

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

curl -s -XPOST -H "Authorization: apikey $ONYPHE" -H 'Content-Type: application/json' "https://www.onyphe.io/api/v2/bulk/discovery/$CATEGORY/asset?keepalive=true&size=10000" --data-binary @$INPUT | grep -v '"@category":"none"' >> /tmp/$CATEGORY.json
