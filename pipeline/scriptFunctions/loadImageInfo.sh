#! /bin/bash

# Extract params data
get_image() {
  echo -e "\n*** extracting image information ***"
  local IMAGE_FILE="./IN/$1/version.json"
  if [ -f "$IMAGE_FILE" ]; then
    export DOCKER_REPOSITORY=$(jq -r '.propertyBag.yml.pointer.sourceName' $IMAGE_FILE)
    export TAG=$(jq -r '.version.versionName' $IMAGE_FILE)
    echo "loaded image information"
  else
    echo "no image information exists"
  fi
}
