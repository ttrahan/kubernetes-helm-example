#! /bin/bash -e

echo "installing AWS CLI..."

# add AWS credentials
if [[ ! -d ~/.aws ]]; then
  mkdir ~/.aws
fi
echo -e "[shippable]\naws_access_key_id=$aws_access_key_id\naws_secret_access_key=$aws_secret_access_key" >> ~/.aws/credentials
export AWS_DEFAULT_PROFILE=shippable

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
