#!/bin/bash

LATEST_HASH="latestHash"
TMP_HASH="tmpHash"
DELAY=60

if [ -z "$WAPI_KEY" ]; then
  echo "WAPI_KEY environment variable is empty. "
  exit 1
fi
if [ -z "$WAPI_USER" ]; then
  echo "WAPI_USER environment variable is empty. "
  exit 5
fi
WAPI_URL="https://isod.ee.pw.edu.pl/isod-portal/wapi?q=mynewsheaders&username=$WAPI_USER&apikey=$WAPI_KEY&from=0&to=1"

if [ -z "$WEBHOOK_URL" ]; then
  echo "WEBHOOK_URL environment variable is empty. "
  exit 2
fi

if [ -z "$DISCORD_UID" ]; then
  PING_MESSAGE=""
else
  PING_MESSAGE=" <@$DISCORD_UID>"
fi

function fetch_isod_news() {
  local result

  if ! result=$(curl -s "$WAPI_URL"); then
    echo "Fetching news from ISOD failed. Please validate the URL: $WAPI_URL"
    exit 3
  fi
  echo "$result" | jq -r '.items[0].hash' >$TMP_HASH
}

function discord_webhook() {
  if ! curl -X POST -H "Content-Type: application/json" \
    -d '{"embeds":[{"description":"New message on ISOD!'"$PING_MESSAGE"'","color": 16106306}]}' \
    "$WEBHOOK_URL"; then
    echo "Posting Discord webhook failed. Please validate the URL: $WEBHOOK_URL"
    exit 4
  fi
}

# Fetch latest news message hash
fetch_isod_news
mv "$TMP_HASH" "$LATEST_HASH"

# Main loop
while true; do
  DATE=$(date)
  echo "Checking news at $DATE..."
  fetch_isod_news

  # check if anything has been changed
  if cmp -s "$LATEST_HASH" "$TMP_HASH"; then
    echo 'Nothing new.'
  else
    echo 'New message has been detected!'
    mv "$TMP_HASH" "$LATEST_HASH"

    discord_webhook
  fi

  sleep $DELAY
done
