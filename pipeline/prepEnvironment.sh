#! /bin/sh -e

GIT_REPO="/build/IN/repo-sample-kube/gitRepo/"

# source inputs ('IN:'s from shippable.jobs.yml) to job
for f in $GIT_REPO/pipeline/inputs/* ; do
  source $f ;
done
# input parameters
JOB=$1
SCRIPT_REPO=$2
PARAMS_RESOURCE=$3
INTEGRATION=$4
echo "INTEGRATION variable - "$INTEGRATION
# process inputs into environment
get_previous_statefile $JOB
get_params $PARAMS_RESOURCE
get_integration $INTEGRATION

echo "aws_access_key_id - "$aws_access_key_id
echo "environment - "$ENVIRONMENT

# install linux tools
# . $GIT_REPO/pipeline/install/installGlobal.sh
echo "installing Linux tools..."
# DISTRO=alpine
DISTRO=ubuntu
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
# update the package index and install tools
$TOOL update
$INSTALL_CMD gettext curl sudo bash

# install AWS CLI
# . $GIT_REPO/pipeline/install/installAwsCli.sh
echo "installing AWS CLI..."
# add AWS credentials
if [[ ! -d ~/.aws ]]; then
  mkdir ~/.aws
fi
echo -e "[shippable]\naws_access_key_id=$aws_access_key_id\naws_secret_access_key=$aws_secret_access_key" >> ~/.aws/credentials
export AWS_DEFAULT_PROFILE=shippable
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

# install Kubectl CLI
# . $GIT_REPO/pipeline/install/installKubeCli.sh
echo "installing kubectl CLI..."
# add Kube config
if [[ ! -d ~/.kube ]]; then
  mkdir ~/.kube
fi
echo "directory created..."
# copy shared credentials from S3 bucket to job node
aws s3 cp s3://clusters.example-kube-cluster.com/config ~/.kube/config
# install Kubernetes CLI
if [[ ! $(which kubectl) ]]; then
  curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
  chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
fi
