#! /bin/bash

# Save state
echo -e "\n*** saving state ***"
save_state_variables() {
  STATE_SAVE_LOCATION=/build/state/
  NUM_PARAMS=$#
  for var in {1..$NUM_PARAMS}; do
    ENV_VAR_TO_SAVE=$var
    echo -e "export "$var"="${!var} >> $STATE_SAVE_LOCATION/variable_state.env
  done
}

save_state_files() {
  STATE_SAVE_LOCATION=/build/state/
  NUM_PARAMS=$#
  for file in {1..$NUM_PARAMS}; do
    FILE_TO_SAVE=$file
    cp $file $STATEFILE_SAVE_LOCATION
  done
}

# ENV_VAR_TO_SAVE=$i
# for var in "${ENV_VAR_TO_SAVE[@]}"; do
#   echo -e "export "$var"="${!var} >> $STATE_SAVE_LOCATION/variable_state.env
# done
