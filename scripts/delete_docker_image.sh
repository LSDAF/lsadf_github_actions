export TOKEN=""
export HOSTNAME="https://api.github.com"
export PACKAGE="lsadf_api"
export OWNER="LSDAF"
export TAG=""

VERSION_IDS=$(curl -s -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/users/$OWNER/packages/container/$PACKAGE/versions \
  | jq --arg TAG "$TAG" -r '.[] | select(.metadata.container.tags[]? == $TAG) | .id')

# Delete each version
echo "$VERSION_IDS" | while read -r VERSION_ID; do
  if [ -n "$VERSION_ID" ]; then
    echo "Deleting version ID: $VERSION_ID"
    curl -X DELETE \
      -H "Authorization: Bearer $TOKEN" \
      -H "Accept: application/vnd.github+json" \
      https://api.github.com/users/$OWNER/packages/container/$PACKAGE/versions/$VERSION_ID
    echo "Deleted version $VERSION_ID"
  fi
done