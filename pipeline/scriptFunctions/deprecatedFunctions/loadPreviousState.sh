#! /bin/bash

# Extract previous state

get_previous_statefile() {
  echo -e "\n*** extracting previous state for this job ***"
  local previous_statefile_location="/build/previousState"
  if [ -f "$previous_statefile_location/*" ]; then
    cp $previous_statefile_location /build/IN/$1/gitRepo
    echo 'restored previous state'
    if [ -f "$previous_statefile_location/variable_state.env" ]; then
      source $previous_statefile_location/variable_state.env
    fi
  else
    echo "no previous statefile exists"
  fi
}
