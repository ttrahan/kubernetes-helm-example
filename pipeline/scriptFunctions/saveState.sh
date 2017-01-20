#! /bin/bash

# Save state
echo -e "\n*** saving state ***"
save_state_variables() {
  STATE_SAVE_LOCATION=/build/state/
  for var in "$@"; do
    echo -e "export "$var"="${!var} >> $STATE_SAVE_LOCATION/variable_state.env
  done
  echo "variables saved to state successfully"
}

save_state_files() {
  STATE_SAVE_LOCATION=/build/state/
  for file in "$@"; do
    cp $file $STATE_SAVE_LOCATION
  done
  echo "files saved to state successfully"
}
