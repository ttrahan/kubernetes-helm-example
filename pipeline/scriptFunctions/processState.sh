#! /bin/bash

# Save state
echo -e "\n*** saving state ***"
save_state_variables() {
  STATE_SAVE_LOCATION=/build/state/
  # process each parameter passed in
  for var in "$@"; do
    if [[ ! -z $var ]]; then
      echo -e "export "$var"="${!var} >> $STATE_SAVE_LOCATION/variable_state.env
    else
      echo "variable not found or is empty...state not saved"
    fi
  done
  echo "variables saved to state successfully"
  cat $STATE_SAVE_LOCATION/variable_state.env
}

save_state_files() {
  STATE_SAVE_LOCATION=/build/state/
  # process each parameter passed in
  for file in "$@"; do
    if [[ -f $file ]]; then
      cp $file $STATE_SAVE_LOCATION
    else
      echo "file requested is not found in location specified...state not saved"
    fi
  done
  echo "files saved to state successfully"
}

# Load state
echo -e "\n*** loading state ***"
load_state_variables() {
  STATE_LOAD_LOCATION=/build/previousState
  if [[ -f $STATE_LOAD_LOCATION/variable_state.env ]]; then
    cat $STATE_LOAD_LOCATION/variable_state.env
    source $STATE_LOAD_LOCATION/variable_state.env
    echo "variables loaded to state successfully"
  else
    echo "no state variables to load"
  fi
}


