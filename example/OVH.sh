#!/usr/bin/env bash

# https://eu.api.ovh.com/createToken/
APPLICATION_KEY="MDAwMDAwMDAwMDAw"
APPLICATION_SECRET="MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw"
CONSUMER_KEY="MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw"
URL="https://eu.api.ovh.com/1.0/domain/zone" # or ca instead of eu

NOW=$(date +%s)
DIGEST=$(echo -n "$APPLICATION_SECRET+$CONSUMER_KEY+GET+$URL++$NOW" | sha1sum | awk '{print $1}')

curl -H "X-Ovh-Application: $APPLICATION_KEY" \
-H "X-Ovh-Consumer: $CONSUMER_KEY" \
-H "X-Ovh-Timestamp: $NOW" \
-H "X-Ovh-Signature: \$1\$$DIGEST" \
-i "$URL"