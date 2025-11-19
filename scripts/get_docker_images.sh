#!/bin/sh

export HOSTNAME="https://api.github.com"
export PACKAGE="lsadf_api"
export OWNER="LSDAF"

# Check if both parameters are provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <TOKEN>"
    exit 1
fi

TOKEN=$1

IMAGES=$(curl -s -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/users/$OWNER/packages/container/$PACKAGE/versions \
  | jq '.[] | [.id, .metadata.container.tags]')

echo $IMAGES