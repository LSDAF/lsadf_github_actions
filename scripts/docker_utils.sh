#!/bin/bash

# Function to check if a Docker image exists in the registry
# Arguments:
#   $1: Image name with tag (e.g., ghcr.io/lsdaf/lsadf_api:tag)
#   $2: Optional message to display if image exists
#   $3: Optional message to display if image doesn't exist
check_docker_image_exists() {
  local image_name="$1"
  local exists_message="${2:-Image with tag $(echo "$image_name" | cut -d':' -f2) already exists.}"
  local not_exists_message="${3:-Image with tag $(echo "$image_name" | cut -d':' -f2) does not exist.}"

  echo "Checking if image $image_name exists..."

  if docker manifest inspect "$image_name" > /dev/null 2>&1; then
    echo "$exists_message"
  else
    echo "$not_exists_message"
  fi
  return 0
}

# Function to prepare Docker image tags
# Arguments:
#   $1: Base image name (e.g., ghcr.io/lsdaf/lsadf_api)
#   $2: Primary tag (e.g., git SHA)
#   $3: Boolean flag for adding 'latest' tag
#   $4: Optional semicolon-separated additional tags
prepare_docker_tags() {
  local base_image="$1"
  local primary_tag="$2"
  local add_latest="$3"
  local additional_tags="$4"
  
  local TAGS="${base_image}:${primary_tag}"

  # Add latest tag if requested
  if [[ "$add_latest" == "true" ]]; then
    TAGS="$TAGS,${base_image}:latest"
  fi

  # Add additional tags if provided
  if [[ -n "$additional_tags" ]]; then
    IFS=';' read -ra ADDITIONAL_TAGS <<< "$additional_tags"
    for tag in "${ADDITIONAL_TAGS[@]}"; do
      if [[ -n "$tag" ]]; then
        TAGS="$TAGS,${base_image}:$tag"
      fi
    done
  fi

  echo "$TAGS"
}