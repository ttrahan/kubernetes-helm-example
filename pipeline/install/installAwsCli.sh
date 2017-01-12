#! /bin/bash -e

echo "installing AWS CLI..."

# adjust for distro and export variables via .bash_profile for new shells
if [ $DISTRO == ubuntu ]; then
  export TOOL="sudo apt-get"
  export INSTALL_CMD="apt-get install"
elif [ $DISTRO == alpine ]; then
  export TOOL="apk"
  export INSTALL_CMD="apk add"
else
  echo "Linux distro not supported"
  # exit
fi

# add AWS credentials
if [[ ! -d ~/.aws ]]; then
  mkdir ~/.aws
fi
echo -e "[gitlabCi]\naws_access_key_id=$AWS_ACCESS_KEY_ID\naws_secret_access_key=$AWS_SECRET_ACCESS_KEY" >> ~/.aws/credentials
export AWS_DEFAULT_PROFILE=gitlabCi

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
