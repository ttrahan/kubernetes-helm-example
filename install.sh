#! /bin/bash -e

# install all dependencies required to execute deployment

DISTRO=alpine
# DISTRO=ubuntu

if [ $DISTRO == ubuntu ]; then
  TOOL="sudo apt-get"
  INSTALL_CMD="apt-get install"
elif [ $DISTRO == alpine ]; then
  TOOL="apk"
  INSTALL_CMD="apk add"
else
  echo "Linux distro not supported"
  # exit
fi

# environment variables
export AWS_ACCESS_KEY_ID=$INTAWS_INTEGRATION_AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$INTAWS_INTEGRATION_AWS_SECRET_ACCESS_KEY

# update the package index and install tools
$TOOL update
$INSTALL_CMD gettext curl sudo

# install AWS CLI
# install Python and PIP if not installed
if [[ ! $(which python) ]]; then
  sudo $INSTALL_CMD python
  curl -O https://bootstrap.pypa.io/get-pip.py
  sudo python get-pip.py
fi
# install AWS CLI
if [[ ! $(which aws) ]]; then
  sudo $(which pip) install awscli
  if [[ $(aws help) ]]; then
    echo "AWS CLI installed successfully"
  fi
fi

# install Kubernetes CLI
if [[ ! $(which kubectl) ]]; then
  curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
  chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
fi
