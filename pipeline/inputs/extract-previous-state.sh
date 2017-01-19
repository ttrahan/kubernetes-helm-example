#! /bin/bash

# Extract previous state
echo -e "\n*** extracting previous state for this job ***"
get_previous_statefile() {
  local previous_statefile_location="/build/previousState/terraform.tfstate"
  if [ -f "$previous_statefile_location" ]; then
    cp $previous_statefile_location /build/IN/$1/gitRepo
    echo 'restored previous statefile'
  else
    echo "no previous statefile exists"
  fi
}
get_previous_statefile $1
