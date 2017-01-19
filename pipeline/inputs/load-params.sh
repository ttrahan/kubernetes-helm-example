#! /bin/bash

# Extract params data
echo -e "\n*** extracting params information ***"
get_params() {
  local PARAMS_FILE="./IN/$1/version.json"
  if [ -f "$PARAMS_FILE" ]; then
    PARAMS_VALUES=$(jq -r '.version.propertyBag.params' $PARAMS_FILE)
    PARAMS_LENGTH=$(echo $PARAMS_VALUES | jq '. | length')
    PARAMS_KEYS=$(echo $PARAMS_VALUES | jq '. | keys')
    for (( i=0; i<$PARAMS_LENGTH; i++ )) do
      PARAM_KEY=$(echo $PARAMS_KEYS | jq -r .[$i])
      export $PARAM_KEY=$(echo $PARAMS_VALUES | jq -r .[\"$PARAM_KEY\"])
    done
    echo "loaded params file"
  else
    echo "no params file exists"
  fi
}
