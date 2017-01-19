#! /bin/bash

# Extract params data
echo -e "\n*** extracting image information ***"
get_image() {
  local IMAGE_FILE="./IN/$1/version.json"
  if [ -f "$IMAGE_FILE" ]; then
    export DOCKER_REPOSITORY=$(jq -r '.version.propertyBag.yml.pointer.sourceName' $IMAGE_FILE)
    export TAG=$(jq -r '.version.version.versionName' $IMAGE_FILE)
    echo "loaded image information"
  else
    echo "no image information exists"
  fi
}
