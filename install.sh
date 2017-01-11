#! /bin/bash -e

# install all dependencies required to execute deployment

# environment variables
export AWS_ACCESS_KEY_ID=$INTAWS_INTEGRATION_AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$INTAWS_INTEGRATION_AWS_SECRET_ACCESS_KEY

sudo apt-get update
sudo apt-get install gettext

# install AWS CLI
# install Python and PIP if not installed
if [[ ! $(which python) ]]; then
  sudo apt-get install python27
  curl -O https://bootstrap.pypa.io/get-pip.py
  sudo python27 get-pip.py
fi
# install AWS CLI
sudo $(which pip) install awscli

if [[ $(aws help) ]]; then
  echo "AWS CLI installed successfully"
fi
