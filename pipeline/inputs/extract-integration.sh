#! /bin/bash

# Extract integration data
# pass in parameter with name of integration resource
get_integration() {
  echo -e "\n*** extracting integration information ***"
  local INTEGRATION_FILE="./IN/$1/integration.env"
  if [ -f "$INTEGRATION_FILE" ]; then
    . $INTEGRATION_FILE
    echo "loaded integration file"
  else
    echo "no integration file exists"
  fi
}
