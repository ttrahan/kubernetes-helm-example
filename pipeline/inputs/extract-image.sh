#! /bin/bash

# Extract params data
echo -e "\n*** extracting image information ***"
get_image() {
  local IMAGE_FILE="./IN/$1/version.json"
  cat $IMAGE_FILE
  if [ -f "$IMAGE_FILE" ]; then
    export DOCKER_REPOSITORY=$(jq -r '.version.propertyBag.yml.pointer.sourceName' $IMAGE_FILE)
    export TAG=$(jq -r '.version.version.versionName' $IMAGE_FILE)
    echo 'docker_repo - '$DOCKER_REPOSITORY
    echo 'docker_tag - '$TAG
    echo "loaded image information"
  else
    echo "no image information exists"
  fi
}
