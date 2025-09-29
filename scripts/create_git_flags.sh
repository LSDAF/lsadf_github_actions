cd lsadf_backend/ || exit 1

# validate params
    if [[ -z "$GIT_SHA" ]]; then
      echo "Error: git_sha input is required."
      exit 1
    fi


    # Parse the additional tags
    IFS=';' read -ra TAGS <<< "$GIT_SHA"

    for tag in "${TAGS[@]}"; do
      echo "Processing git tag: $tag"

      # Check if tag already exists
      if git rev-parse "$tag" >/dev/null 2>&1; then
        echo "Tag $tag already exists, creating versioned tag"

        # Find the next available version number
        version=1
        while git rev-parse "${tag}_v${version}" >/dev/null 2>&1; do
          version=$((version + 1))
        done

        # Create the versioned tag
        new_tag="${tag}_v${version}"
        git tag -a "$new_tag" $GIT_SHA -m "Auto-tagged by GitHub Actions"
        echo "Created versioned tag: $new_tag"
      else
        # Create the tag
        git tag -a "$tag" $GIT_SHA -m "Auto-tagged by GitHub Actions"
        echo "Created tag: $tag"
      fi
    done

    # Push all tags to the repository
    git config user.name "GitHub Actions"
    git config user.email "actions@github.com"
    git push origin --tags