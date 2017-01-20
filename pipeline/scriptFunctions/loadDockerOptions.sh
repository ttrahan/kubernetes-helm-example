#! /bin/bash

# Extract params data
get_docker_options() {
  echo -e "\n*** extracting image information ***"
  local OPTIONS_FILE="./IN/$1/version.json"
  cat $OPTIONS_FILE
  if [ -f "$OPTIONS_FILE" ]; then
    export MEMORY=$(jq -r .[]'.images[].dockerOptions.memory' $OPTIONS_FILE)
    export CPU=$(jq -r .[]'.images[].dockerOptions.cpuShares' $OPTIONS_FILE)
    echo "docker options loaded successfully"
  else
    echo "no docker options exists"
  fi
}
